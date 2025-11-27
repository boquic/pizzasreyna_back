# 🔧 Troubleshooting Docker - Pizzas Reyna Backend

Soluciones a problemas comunes con Docker.

---

## 🔴 Error: "Unable to start web server" / Dependencia Circular

### Síntoma:
```
org.springframework.beans.factory.UnsatisfiedDependencyException: 
Error creating bean with name 'jwtAuthenticationFilter'
Caused by: Circular dependency
```

### Causa:
Dependencia circular entre `JwtAuthenticationFilter` y `CustomUserDetailsService`.

### ✅ Solución:
Ya está solucionado en el código usando `@Lazy` en el constructor de `JwtAuthenticationFilter`.

Si aún ves este error:

```bash
# 1. Reconstruir completamente
.\rebuild-docker.ps1

# O manualmente:
docker-compose down
./mvnw clean package -DskipTests
docker-compose build --no-cache
docker-compose up -d
```

---

## 🔴 Error: "Port 8080 already in use"

### Síntoma:
```
Bind for 0.0.0.0:8080 failed: port is already allocated
```

### Causa:
Otro proceso está usando el puerto 8080.

### ✅ Solución:

**Opción 1: Detener el proceso que usa el puerto**
```powershell
# Ver qué está usando el puerto
netstat -ano | findstr :8080

# Matar el proceso (reemplaza PID con el número que viste)
taskkill /PID <PID> /F
```

**Opción 2: Cambiar el puerto en Docker**
Edita `docker-compose.yml`:
```yaml
backend:
  ports:
    - "8081:8080"  # Cambiar 8080 a 8081
```

Luego accede en: http://localhost:8081

---

## 🔴 Error: "Port 5432 already in use"

### Síntoma:
```
Bind for 0.0.0.0:5432 failed: port is already allocated
```

### Causa:
PostgreSQL ya está corriendo localmente.

### ✅ Solución:

**Opción 1: Detener PostgreSQL local**
```powershell
# Windows
net stop postgresql-x64-15

# Luego iniciar Docker
docker-compose up -d
```

**Opción 2: Usar PostgreSQL local (sin Docker)**
```bash
# No iniciar PostgreSQL en Docker
# Solo iniciar el backend localmente
./mvnw spring-boot:run
```

**Opción 3: Cambiar el puerto de Docker**
Edita `docker-compose.yml`:
```yaml
postgres:
  ports:
    - "5433:5432"  # Cambiar 5432 a 5433
```

Y actualiza `application.yml`:
```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5433/pizzasreyna
```

---

## 🔴 Error: "Cannot connect to PostgreSQL"

### Síntoma:
```
Connection to localhost:5432 refused
org.postgresql.util.PSQLException: Connection refused
```

### Causa:
PostgreSQL no está corriendo o no está listo.

### ✅ Solución:

```bash
# 1. Verificar que PostgreSQL está corriendo
docker-compose ps

# 2. Ver logs de PostgreSQL
docker-compose logs postgres

# 3. Verificar health check
docker exec pizzasreyna-db pg_isready -U postgres

# 4. Si no está corriendo, iniciarlo
docker-compose up -d postgres

# 5. Esperar a que esté listo (health check)
docker-compose up -d --wait
```

---

## 🔴 Error: "Flyway migration failed"

### Síntoma:
```
FlywayException: Unable to obtain connection from database
Validate failed: Migration checksum mismatch
```

### Causa:
- Base de datos corrupta
- Migraciones modificadas después de aplicarse
- Conexión a BD incorrecta

### ✅ Solución:

**Opción 1: Limpiar y empezar de cero**
```bash
# Detener y eliminar volúmenes (BORRA TODOS LOS DATOS)
docker-compose down -v

# Iniciar de nuevo
docker-compose up -d --build
```

**Opción 2: Reparar Flyway**
```bash
# Acceder a PostgreSQL
docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna

# Limpiar tabla de Flyway
DELETE FROM flyway_schema_history;

# Salir
\q

# Reiniciar backend
docker-compose restart backend
```

---

## 🔴 Error: "Docker daemon not running"

### Síntoma:
```
Cannot connect to the Docker daemon
Is the docker daemon running?
```

### Causa:
Docker Desktop no está iniciado.

### ✅ Solución:

1. Abrir Docker Desktop
2. Esperar a que inicie completamente
3. Verificar: `docker info`
4. Intentar de nuevo: `docker-compose up -d`

---

## 🔴 Error: "No space left on device"

### Síntoma:
```
no space left on device
failed to copy files
```

### Causa:
Docker se quedó sin espacio en disco.

### ✅ Solución:

```bash
# Limpiar imágenes no usadas
docker system prune -a

# Limpiar volúmenes no usados
docker volume prune

# Ver uso de espacio
docker system df

# Limpiar TODO (cuidado, borra todo)
docker system prune -a --volumes
```

---

## 🔴 Error: "Build failed" / Compilación falla

### Síntoma:
```
[ERROR] Failed to execute goal
[ERROR] compilation failure
```

### Causa:
Error en el código Java.

### ✅ Solución:

```bash
# 1. Compilar localmente para ver el error
./mvnw clean compile

# 2. Corregir los errores mostrados

# 3. Reconstruir Docker
.\rebuild-docker.ps1
```

---

## 🔴 Backend inicia pero no responde

### Síntoma:
- `docker-compose ps` muestra el backend como "Up"
- Pero http://localhost:8080 no responde

### ✅ Solución:

```bash
# 1. Ver logs del backend
docker-compose logs -f backend

# 2. Buscar errores en los logs
docker-compose logs backend | grep ERROR

# 3. Verificar que el puerto está expuesto
docker-compose ps

# 4. Verificar dentro del contenedor
docker exec -it pizzasreyna-backend sh
wget -O- http://localhost:8080/api/pizzas

# 5. Reiniciar el backend
docker-compose restart backend
```

---

## 🔴 Error 403 en todos los endpoints

### Síntoma:
- Login funciona (200 OK)
- Otros endpoints retornan 403 Forbidden

### ✅ Solución:

Ya está solucionado en el código. Si aún tienes el problema:

```bash
# 1. Reconstruir completamente
.\rebuild-docker.ps1

# 2. Ver logs de JWT
docker-compose logs backend | grep "JWT Filter"

# 3. Ejecutar test
.\test-carrito.ps1

# 4. Revisar documentación
cat SOLUCION_403_FORBIDDEN.md
```

---

## 🔴 Cambios en código no se reflejan

### Síntoma:
Modificas el código pero Docker sigue usando la versión antigua.

### ✅ Solución:

```bash
# Reconstruir sin caché
docker-compose down
docker-compose build --no-cache backend
docker-compose up -d

# O usar el script
.\rebuild-docker.ps1
```

---

## 🔴 Base de datos vacía / Sin datos

### Síntoma:
- Backend inicia correctamente
- Pero no hay pizzas, usuarios, etc.

### ✅ Solución:

```bash
# 1. Verificar que Flyway corrió
docker-compose logs backend | grep Flyway

# 2. Verificar migraciones
ls src/main/resources/db/migration/

# 3. Verificar datos en PostgreSQL
docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna
SELECT * FROM usuario;
SELECT * FROM pizza;
\q

# 4. Si no hay datos, recrear
docker-compose down -v
docker-compose up -d --build
```

---

## 🔴 Error: "Cannot resolve reference to bean"

### Síntoma:
```
Cannot resolve reference to bean 'jpaSharedEM_entityManagerFactory'
UnsatisfiedDependencyException
```

### Causa:
Problema con la configuración de JPA o dependencias circulares.

### ✅ Solución:

```bash
# 1. Verificar que @Lazy está en JwtAuthenticationFilter
cat src/main/java/com/pizzasreyna/pizzaback/infrastructure/security/JwtAuthenticationFilter.java | grep "@Lazy"

# 2. Limpiar y recompilar
./mvnw clean compile -DskipTests

# 3. Reconstruir Docker
.\rebuild-docker.ps1
```

---

## 🧪 Comandos de Diagnóstico

### Ver estado general
```bash
# Estado de servicios
docker-compose ps

# Logs de todos los servicios
docker-compose logs

# Logs solo del backend
docker-compose logs -f backend

# Logs solo de PostgreSQL
docker-compose logs -f postgres
```

### Verificar conectividad
```bash
# Verificar PostgreSQL
docker exec pizzasreyna-db pg_isready -U postgres

# Verificar backend desde dentro del contenedor
docker exec pizzasreyna-backend wget -O- http://localhost:8080/api/pizzas

# Verificar backend desde host
curl http://localhost:8080/api/pizzas
```

### Inspeccionar contenedores
```bash
# Entrar al contenedor del backend
docker exec -it pizzasreyna-backend sh

# Entrar a PostgreSQL
docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna

# Ver variables de entorno
docker exec pizzasreyna-backend env

# Ver procesos
docker exec pizzasreyna-backend ps aux
```

### Limpiar y reiniciar
```bash
# Reinicio suave
docker-compose restart

# Reinicio completo
docker-compose down
docker-compose up -d

# Reinicio con rebuild
docker-compose down
docker-compose up -d --build

# Reinicio limpio (borra datos)
docker-compose down -v
docker-compose up -d --build
```

---

## 📋 Checklist de Troubleshooting

Cuando tengas un problema, sigue estos pasos:

- [ ] ¿Docker Desktop está corriendo?
- [ ] ¿Los puertos 8080 y 5432 están libres?
- [ ] ¿El código compila localmente? (`./mvnw clean compile`)
- [ ] ¿Los logs muestran errores? (`docker-compose logs backend`)
- [ ] ¿PostgreSQL está listo? (`docker exec pizzasreyna-db pg_isready`)
- [ ] ¿Flyway corrió correctamente? (`docker-compose logs backend | grep Flyway`)
- [ ] ¿Hay datos en la BD? (`docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna`)
- [ ] ¿El backend responde? (`curl http://localhost:8080/api/pizzas`)

---

## 🆘 Último Recurso: Empezar de Cero

Si nada funciona:

```bash
# 1. Detener todo
docker-compose down -v

# 2. Limpiar Docker completamente
docker system prune -a --volumes

# 3. Limpiar compilación local
./mvnw clean

# 4. Recompilar
./mvnw clean package -DskipTests

# 5. Reconstruir Docker
docker-compose build --no-cache

# 6. Iniciar
docker-compose up -d

# 7. Ver logs
docker-compose logs -f

# 8. Probar
.\test-carrito.ps1
```

---

## 📞 Soporte Adicional

Si después de seguir esta guía aún tienes problemas:

1. Revisa [SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md)
2. Consulta [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md)
3. Revisa [GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md)
4. Comparte los logs: `docker-compose logs backend > logs.txt`

---

¡Buena suerte! 🍀🐳
