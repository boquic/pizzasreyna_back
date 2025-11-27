# 🔧 Solución al Error 403 Forbidden

## ❌ Problema Identificado

El backend estaba retornando **403 Forbidden** en todas las peticiones autenticadas porque **faltaba la implementación de `UserDetailsService`**, que es el componente que Spring Security usa para cargar los usuarios desde la base de datos.

## ✅ Solución Implementada

### 1. ✨ Creado `CustomUserDetailsService`

**Archivo:** `src/main/java/com/pizzasreyna/pizzaback/infrastructure/security/CustomUserDetailsService.java`

Este servicio:
- Carga usuarios desde la base de datos usando `UsuarioRepository`
- Convierte el modelo `Usuario` a `UserDetails` de Spring Security
- Asigna los roles correctamente con el prefijo `ROLE_`
- Valida que el usuario esté activo

**Nota:** Se usa `@Lazy` en `JwtAuthenticationFilter` para evitar dependencia circular durante la inicialización de Spring

```java
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UsuarioRepository usuarioRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));

        List<GrantedAuthority> authorities = Collections.singletonList(
                new SimpleGrantedAuthority("ROLE_" + usuario.getRol().getNombre())
        );

        return User.builder()
                .username(usuario.getEmail())
                .password(usuario.getPassword())
                .authorities(authorities)
                .disabled(!usuario.getActivo())
                .build();
    }
}
```

### 2. 🔍 Mejorado `JwtAuthenticationFilter` con Logs

**Archivo:** `src/main/java/com/pizzasreyna/pizzaback/infrastructure/security/JwtAuthenticationFilter.java`

Agregué logs detallados para debugging:
- Path y método de la petición
- Presencia del header Authorization
- Username extraído del token
- Resultado de la validación del token
- Estado de la autenticación

Ahora verás en los logs:
```
=== JWT Filter Debug ===
Path: /api/usuario/carrito
Method: GET
Auth Header: Present
Extracted username: admin@pizzasreyna.com
User loaded: admin@pizzasreyna.com
Authorities: [ROLE_ADMIN]
✅ Authentication set successfully for: admin@pizzasreyna.com
========================
```

### 3. 🌐 Creado `CorsConfig`

**Archivo:** `src/main/java/com/pizzasreyna/pizzaback/infrastructure/config/CorsConfig.java`

Configuración de CORS que:
- Lee los valores desde `application.yml`
- Permite configurar orígenes, métodos y headers
- Maneja correctamente las peticiones preflight (OPTIONS)

## 🧪 Cómo Probar la Solución

### Opción 1: Script PowerShell Automatizado

```powershell
# Ejecutar el script de prueba
.\test-carrito.ps1
```

Este script:
1. ✅ Hace login con el usuario admin
2. ✅ Obtiene el carrito vacío
3. ✅ Agrega una pizza al carrito
4. ✅ Limpia el carrito

### Opción 2: Prueba Manual con Postman

#### 1. Login
```http
POST http://localhost:8080/api/auth/login
Content-Type: application/json

{
  "email": "admin@pizzasreyna.com",
  "password": "admin123"
}
```

**Respuesta esperada:** 200 OK con token JWT

#### 2. Obtener Carrito
```http
GET http://localhost:8080/api/usuario/carrito
Authorization: Bearer {TOKEN_AQUI}
```

**Respuesta esperada:** 200 OK (no 403)

#### 3. Agregar al Carrito
```http
POST http://localhost:8080/api/usuario/carrito/agregar
Authorization: Bearer {TOKEN_AQUI}
Content-Type: application/json

{
  "pizzaId": 2,
  "comboId": null,
  "cantidad": 2,
  "notas": "Sin cebolla",
  "ingredientesPersonalizadosIds": [10, 4]
}
```

**Respuesta esperada:** 200 OK con el carrito actualizado

## 📋 Checklist de Verificación

- [x] `CustomUserDetailsService` implementado
- [x] `JwtAuthenticationFilter` con logs de debug
- [x] `CorsConfig` creado
- [x] `SecurityConfig` ya tenía el filtro registrado correctamente
- [x] `application.yml` tiene las configuraciones JWT
- [ ] Backend reiniciado
- [ ] Pruebas ejecutadas exitosamente

## 🚀 Pasos para Aplicar la Solución

### Opción A: Con Docker (Recomendado) 🐳

#### 1. Reconstruir e Iniciar los Servicios

```bash
# Detener servicios actuales
docker-compose down

# Reconstruir e iniciar
docker-compose up -d --build

# Ver logs en tiempo real
docker-compose logs -f backend
```

#### 2. Verificar los Logs

```bash
# Ver logs del backend
docker-compose logs backend | grep "JWT Filter"
```

Deberías ver:
```
✅ Authentication set successfully for: admin@pizzasreyna.com
```

#### 3. Ejecutar las Pruebas

```powershell
.\test-carrito.ps1
```

---

### Opción B: Sin Docker (Desarrollo Local) 💻

#### 1. Asegurarte que PostgreSQL está Corriendo

```bash
# Windows
net start postgresql-x64-15

# Linux
sudo systemctl start postgresql

# Mac
brew services start postgresql@15
```

#### 2. Compilar el Proyecto

```bash
.\mvnw clean compile
```

#### 3. Reiniciar el Backend

```bash
.\mvnw spring-boot:run
```

#### 4. Verificar los Logs

Al iniciar, deberías ver:
```
Started PizzabackApplication in X.XXX seconds
CustomUserDetailsService bean created
```

#### 5. Ejecutar las Pruebas

```powershell
.\test-carrito.ps1
```

---

### Opción C: Híbrida (PostgreSQL en Docker, Backend Local) 🔄

```bash
# 1. Iniciar solo PostgreSQL
docker-compose -f docker-compose.dev.yml up -d

# 2. Iniciar backend localmente
.\mvnw spring-boot:run

# 3. Ejecutar pruebas
.\test-carrito.ps1
```

## 🔍 Verificación de Logs

Cuando hagas una petición autenticada, verás en los logs del backend:

```
=== JWT Filter Debug ===
Path: /api/usuario/carrito/agregar
Method: POST
Auth Header: Present
Extracted username: admin@pizzasreyna.com
User loaded: admin@pizzasreyna.com
Authorities: [ROLE_ADMIN]
✅ Authentication set successfully for: admin@pizzasreyna.com
========================
```

Si ves `❌` en los logs, significa que hay un problema con:
- El token está expirado
- El token es inválido
- El usuario no existe en la BD
- El usuario está inactivo

## 🐛 Troubleshooting

### Error: "Usuario no encontrado"
**Causa:** El email en el token no existe en la base de datos.
**Solución:** Verifica que el usuario exista con:
```sql
SELECT * FROM usuario WHERE email = 'admin@pizzasreyna.com';
```

### Error: "Token validation failed"
**Causa:** El token JWT está expirado o es inválido.
**Solución:** 
1. Haz logout en el frontend
2. Haz login nuevamente para obtener un token nuevo
3. Intenta la petición de nuevo

### Error: "JWT secret mismatch"
**Causa:** El secret usado para generar el token es diferente al configurado.
**Solución:** Verifica que `jwt.secret` en `application.yml` sea el mismo que se usó al generar el token.

### Aún recibo 403
**Causa:** El filtro no se está ejecutando o hay un problema con Spring Security.
**Solución:**
1. Verifica que `CustomUserDetailsService` esté anotado con `@Service`
2. Verifica que `JwtAuthenticationFilter` esté anotado con `@Component`
3. Verifica que `SecurityConfig` tenga `@Configuration` y `@EnableWebSecurity`
4. Reinicia completamente el backend
5. Revisa los logs para ver si el filtro se está ejecutando

## 📊 Flujo de Autenticación Corregido

```
1. Cliente envía petición con header:
   Authorization: Bearer eyJhbGciOi...

2. JwtAuthenticationFilter intercepta la petición
   ↓
3. Extrae el token del header
   ↓
4. Extrae el username (email) del token usando JwtUtil
   ↓
5. Carga el usuario desde la BD usando CustomUserDetailsService
   ↓
6. Valida el token con JwtUtil.validateToken()
   ↓
7. Si es válido, crea UsernamePasswordAuthenticationToken
   ↓
8. Establece la autenticación en SecurityContextHolder
   ↓
9. Spring Security permite el acceso al endpoint
   ↓
10. El controller recibe la petición con Authentication
```

## 🎯 Resultado Esperado

Después de aplicar esta solución:

✅ **Login funciona** → Retorna token JWT
✅ **GET /api/usuario/carrito** → Retorna 200 OK (no 403)
✅ **POST /api/usuario/carrito/agregar** → Retorna 200 OK (no 403)
✅ **DELETE /api/usuario/carrito/limpiar** → Retorna 200 OK (no 403)
✅ **Todos los endpoints autenticados funcionan correctamente**

## 📞 Soporte

Si después de aplicar esta solución sigues teniendo problemas:

1. Revisa los logs del backend en detalle
2. Ejecuta el script `test-carrito.ps1` y comparte el output
3. Verifica que la base de datos tenga el usuario admin:
   ```sql
   SELECT u.*, r.nombre as rol_nombre 
   FROM usuario u 
   JOIN rol r ON u.rol_id = r.id 
   WHERE u.email = 'admin@pizzasreyna.com';
   ```

---

## 📝 Resumen de Cambios

| Archivo | Acción | Descripción |
|---------|--------|-------------|
| `CustomUserDetailsService.java` | ✨ Creado | Implementa UserDetailsService para cargar usuarios |
| `JwtAuthenticationFilter.java` | 🔧 Modificado | Agregados logs de debug detallados |
| `CorsConfig.java` | ✨ Creado | Configuración de CORS desde application.yml |
| `test-carrito.ps1` | ✨ Creado | Script de prueba automatizado |

---

¡La solución está lista! 🎉 Reinicia el backend y ejecuta las pruebas.
