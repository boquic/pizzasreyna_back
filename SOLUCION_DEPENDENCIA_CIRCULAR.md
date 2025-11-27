# 🔄 Solución: Dependencia Circular en Docker

## ❌ Problema

Al iniciar el backend en Docker, aparecía este error:

```
org.springframework.beans.factory.UnsatisfiedDependencyException: 
Error creating bean with name 'jwtAuthenticationFilter'
Unsatisfied dependency expressed through constructor parameter 1: 
Error creating bean with name 'customUserDetailsService'
Cannot resolve reference to bean 'jpaSharedEM_entityManagerFactory'
```

## 🔍 Causa Raíz

**Dependencia circular** entre:
- `JwtAuthenticationFilter` necesita `UserDetailsService`
- `UserDetailsService` (CustomUserDetailsService) necesita `UsuarioRepository`
- `UsuarioRepository` necesita JPA EntityManager
- JPA se inicializa después de los filtros de seguridad

Esto crea un ciclo de dependencias que Spring no puede resolver.

## ✅ Solución Aplicada

### Usar `@Lazy` en el Constructor

Modificamos `JwtAuthenticationFilter.java` para usar **lazy initialization** del `UserDetailsService`:

**Antes:**
```java
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtUtil jwtUtil;
    private final UserDetailsService userDetailsService;
    // ...
}
```

**Después:**
```java
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtUtil jwtUtil;
    private final UserDetailsService userDetailsService;

    // Constructor con @Lazy para evitar dependencia circular
    public JwtAuthenticationFilter(JwtUtil jwtUtil, @Lazy UserDetailsService userDetailsService) {
        this.jwtUtil = jwtUtil;
        this.userDetailsService = userDetailsService;
    }
    // ...
}
```

### ¿Qué hace `@Lazy`?

- **Sin @Lazy:** Spring intenta crear todas las dependencias inmediatamente al iniciar
- **Con @Lazy:** Spring crea un proxy del `UserDetailsService` y lo inicializa solo cuando se usa por primera vez
- Esto rompe el ciclo de dependencias permitiendo que Spring inicie correctamente

## 🚀 Cómo Aplicar la Solución

### Opción 1: Reconstruir Docker (Recomendado)

```bash
# Usar el script automatizado
.\rebuild-docker.ps1
```

Este script:
1. Detiene servicios actuales
2. Limpia imágenes antiguas
3. Compila el proyecto localmente
4. Construye nueva imagen Docker
5. Inicia los servicios
6. Verifica que funcione

### Opción 2: Manual

```bash
# 1. Detener servicios
docker-compose down

# 2. Compilar localmente
./mvnw clean package -DskipTests

# 3. Reconstruir imagen sin caché
docker-compose build --no-cache backend

# 4. Iniciar servicios
docker-compose up -d

# 5. Ver logs
docker-compose logs -f backend
```

### Opción 3: Sin Docker (Desarrollo Local)

```bash
# Simplemente reiniciar
./mvnw spring-boot:run
```

## ✅ Verificar que Funciona

### 1. Ver Logs

```bash
docker-compose logs backend
```

Deberías ver:
```
Started PizzabackApplication in X.XXX seconds
```

**NO** deberías ver:
```
UnsatisfiedDependencyException
Circular dependency
```

### 2. Probar Endpoints

```bash
# Probar endpoint público
curl http://localhost:8080/api/pizzas

# Ejecutar test completo
.\test-carrito.ps1
```

### 3. Verificar Autenticación

```powershell
.\test-carrito.ps1
```

Deberías ver:
```
✅ Login exitoso
✅ Carrito obtenido
✅ Pizza agregada al carrito
✅ Carrito limpiado
✅ Todas las pruebas pasaron!
```

## 🔍 Entendiendo el Problema

### Flujo de Inicialización (Antes - ❌ Falla)

```
1. Spring inicia SecurityConfig
   ↓
2. SecurityConfig necesita JwtAuthenticationFilter
   ↓
3. JwtAuthenticationFilter necesita UserDetailsService
   ↓
4. UserDetailsService necesita UsuarioRepository
   ↓
5. UsuarioRepository necesita JPA EntityManager
   ↓
6. JPA EntityManager aún no está listo
   ↓
❌ ERROR: Circular dependency
```

### Flujo de Inicialización (Después - ✅ Funciona)

```
1. Spring inicia SecurityConfig
   ↓
2. SecurityConfig necesita JwtAuthenticationFilter
   ↓
3. JwtAuthenticationFilter necesita UserDetailsService
   ↓
4. @Lazy crea un PROXY de UserDetailsService (no el real)
   ↓
5. JwtAuthenticationFilter se inicializa con el proxy
   ↓
6. Spring continúa inicializando JPA
   ↓
7. JPA EntityManager se inicializa
   ↓
8. UsuarioRepository se inicializa
   ↓
9. UserDetailsService REAL se inicializa
   ↓
10. Cuando se usa UserDetailsService, el proxy lo redirige al real
    ↓
✅ TODO FUNCIONA
```

## 📚 Conceptos Clave

### ¿Qué es una Dependencia Circular?

Cuando dos o más componentes se necesitan mutuamente:
- A necesita B
- B necesita C
- C necesita A

Spring no puede decidir cuál crear primero.

### ¿Qué es @Lazy?

Una anotación de Spring que indica:
- "No crees este bean inmediatamente"
- "Crea un proxy ahora"
- "Inicializa el bean real cuando se use por primera vez"

### ¿Por qué funciona @Lazy?

Rompe el ciclo de dependencias:
- Spring crea el proxy inmediatamente (rápido)
- El proxy no necesita las dependencias reales
- Las dependencias reales se crean después
- Cuando se usa el proxy, redirige al bean real

## 🛠️ Alternativas Consideradas

### Alternativa 1: @Autowired en lugar de Constructor
❌ No recomendado - Oculta dependencias

### Alternativa 2: Setter Injection
❌ No recomendado - Permite objetos en estado inválido

### Alternativa 3: @Lazy en ambos lados
❌ Innecesario - Solo se necesita en un lado

### Alternativa 4: Reestructurar código
⚠️ Posible pero complejo - Requiere cambios mayores

### ✅ Alternativa Elegida: @Lazy en Constructor
- Simple
- Explícito
- No cambia la arquitectura
- Patrón recomendado por Spring

## 🧪 Testing

Después de aplicar la solución, ejecuta:

```bash
# Test automatizado
.\test-carrito.ps1

# Test manual
curl http://localhost:8080/api/pizzas
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@pizzasreyna.com","password":"admin123"}'
```

## 📊 Impacto de la Solución

### Performance
- ✅ Sin impacto negativo
- El proxy es muy ligero
- La inicialización lazy ocurre solo una vez

### Funcionalidad
- ✅ Sin cambios
- Todo funciona igual que antes
- Solo cambia CUÁNDO se inicializa

### Mantenibilidad
- ✅ Código más claro
- Constructor explícito
- Fácil de entender

## 🔗 Documentación Relacionada

- [SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md) - Solución completa del error 403
- [TROUBLESHOOTING_DOCKER.md](TROUBLESHOOTING_DOCKER.md) - Otros problemas de Docker
- [GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md) - Cómo iniciar el proyecto

## 📞 Si Aún Tienes Problemas

1. **Verifica que el código está actualizado:**
   ```bash
   git pull
   ```

2. **Limpia y recompila:**
   ```bash
   ./mvnw clean compile
   ```

3. **Reconstruye Docker completamente:**
   ```bash
   .\rebuild-docker.ps1
   ```

4. **Revisa los logs:**
   ```bash
   docker-compose logs backend | grep -i error
   ```

5. **Consulta troubleshooting:**
   ```bash
   cat TROUBLESHOOTING_DOCKER.md
   ```

---

## ✅ Resumen

| Aspecto | Antes | Después |
|---------|-------|---------|
| **Problema** | Dependencia circular | ✅ Resuelto |
| **Solución** | - | `@Lazy` en constructor |
| **Cambios** | - | 1 archivo modificado |
| **Impacto** | Backend no inicia | ✅ Backend funciona |
| **Performance** | - | Sin cambios |

---

¡Problema resuelto! 🎉 El backend ahora inicia correctamente en Docker.
