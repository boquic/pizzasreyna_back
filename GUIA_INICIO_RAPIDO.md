# 🚀 Guía de Inicio Rápido - Pizzas Reyna Backend

Esta guía te muestra cómo iniciar el backend de dos formas: **con Docker** (recomendado) o **sin Docker** (desarrollo local).

---

## 📋 Requisitos Previos

### Opción 1: Con Docker (Recomendado) ✨
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado
- Eso es todo! Docker se encarga del resto

### Opción 2: Sin Docker (Desarrollo Local)
- Java 17 o superior
- PostgreSQL 15 instalado y corriendo
- Maven (incluido en el proyecto como `mvnw`)

---

## 🐳 Opción 1: Iniciar con Docker (Recomendado)

### Ventajas:
✅ No necesitas instalar PostgreSQL  
✅ No necesitas configurar nada  
✅ Todo funciona "out of the box"  
✅ Mismo ambiente en todos los equipos  

### Pasos:

#### 1. Iniciar Todo (Backend + Base de Datos)

```bash
# Construir e iniciar ambos servicios
docker-compose up --build

# O en modo detached (segundo plano)
docker-compose up -d --build
```

Esto iniciará:
- PostgreSQL en `localhost:5432`
- Backend en `http://localhost:8080`

#### 2. Solo Base de Datos (Para desarrollo local del backend)

Si prefieres correr el backend desde tu IDE pero usar PostgreSQL en Docker:

```bash
# Iniciar solo PostgreSQL
docker-compose -f docker-compose.dev.yml up -d

# Luego en otra terminal, iniciar el backend localmente
./mvnw spring-boot:run
```

#### 3. Verificar que Todo Funciona

```bash
# Ver logs
docker-compose logs -f

# Verificar servicios corriendo
docker-compose ps

# Probar el backend
curl http://localhost:8080/api/pizzas
```

#### 4. Detener los Servicios

```bash
# Detener servicios
docker-compose down

# Detener y eliminar volúmenes (borra la BD)
docker-compose down -v
```

### 🔧 Comandos Útiles Docker

```bash
# Ver logs del backend
docker-compose logs -f backend

# Ver logs de PostgreSQL
docker-compose logs -f postgres

# Reiniciar solo el backend
docker-compose restart backend

# Reconstruir el backend después de cambios
docker-compose up -d --build backend

# Acceder a la base de datos
docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna
```

---

## 💻 Opción 2: Iniciar sin Docker (Desarrollo Local)

### Ventajas:
✅ Más rápido para desarrollo (no necesitas reconstruir imagen)  
✅ Debugging más fácil desde el IDE  
✅ Hot reload con Spring DevTools  

### Pasos:

#### 1. Instalar y Configurar PostgreSQL

**Windows:**
```powershell
# Descargar desde: https://www.postgresql.org/download/windows/
# O con Chocolatey:
choco install postgresql

# Iniciar servicio
net start postgresql-x64-15
```

**Linux:**
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql
```

**macOS:**
```bash
brew install postgresql@15
brew services start postgresql@15
```

#### 2. Crear la Base de Datos

```bash
# Conectar a PostgreSQL
psql -U postgres

# Crear la base de datos
CREATE DATABASE pizzasreyna;

# Salir
\q
```

#### 3. Verificar Configuración

Edita `src/main/resources/application.yml` si tu configuración es diferente:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/pizzasreyna
    username: postgres
    password: postgres  # Cambia esto si usas otra contraseña
```

#### 4. Iniciar el Backend

```bash
# Compilar y ejecutar
./mvnw spring-boot:run

# O solo compilar
./mvnw clean install

# Y luego ejecutar el JAR
java -jar target/pizzaback-0.0.1-SNAPSHOT.jar
```

#### 5. Verificar que Funciona

```bash
# Probar endpoint público
curl http://localhost:8080/api/pizzas

# O abrir en el navegador
start http://localhost:8080/swagger-ui.html
```

---

## 🧪 Probar la Solución del Error 403

Después de iniciar el backend (con Docker o sin Docker), ejecuta:

```powershell
# Probar autenticación y carrito
.\test-carrito.ps1

# O probar login simple
.\test-login-real.ps1
```

---

## 🔍 Verificar que Todo Está Funcionando

### 1. Base de Datos
```bash
# Con Docker
docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna -c "SELECT * FROM usuario;"

# Sin Docker
psql -U postgres -d pizzasreyna -c "SELECT * FROM usuario;"
```

Deberías ver el usuario admin.

### 2. Backend
```bash
# Probar endpoint público
curl http://localhost:8080/api/pizzas

# Probar login
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@pizzasreyna.com","password":"admin123"}'
```

### 3. Logs del Backend

Busca estas líneas en los logs:

```
✅ Started PizzabackApplication in X.XXX seconds
✅ Flyway migration completed successfully
✅ CustomUserDetailsService bean created
```

---

## 🐛 Troubleshooting

### Error: "Connection refused" a PostgreSQL

**Con Docker:**
```bash
# Verificar que PostgreSQL está corriendo
docker-compose ps

# Ver logs de PostgreSQL
docker-compose logs postgres

# Reiniciar PostgreSQL
docker-compose restart postgres
```

**Sin Docker:**
```bash
# Windows
net start postgresql-x64-15

# Linux/Mac
sudo systemctl start postgresql
# o
brew services start postgresql@15
```

### Error: "Port 5432 already in use"

Ya tienes PostgreSQL corriendo localmente. Opciones:

**Opción A:** Usar el PostgreSQL local (sin Docker)
```bash
# No uses docker-compose, solo corre el backend
./mvnw spring-boot:run
```

**Opción B:** Detener el PostgreSQL local y usar Docker
```bash
# Windows
net stop postgresql-x64-15

# Linux
sudo systemctl stop postgresql

# Luego iniciar Docker
docker-compose up -d
```

**Opción C:** Cambiar el puerto de Docker
Edita `docker-compose.yml`:
```yaml
ports:
  - "5433:5432"  # Cambiar 5432 a 5433
```

Y actualiza `application.yml`:
```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5433/pizzasreyna
```

### Error: "Port 8080 already in use"

```bash
# Windows - Ver qué está usando el puerto
netstat -ano | findstr :8080

# Matar el proceso (reemplaza PID con el número que viste)
taskkill /PID <PID> /F

# O cambiar el puerto en application.yml
server:
  port: 8081
```

### Error: Flyway migration failed

```bash
# Limpiar la base de datos y empezar de nuevo

# Con Docker
docker-compose down -v
docker-compose up -d

# Sin Docker
psql -U postgres -c "DROP DATABASE pizzasreyna;"
psql -U postgres -c "CREATE DATABASE pizzasreyna;"
./mvnw spring-boot:run
```

---

## 📊 Comparación: Docker vs Sin Docker

| Aspecto | Con Docker 🐳 | Sin Docker 💻 |
|---------|---------------|---------------|
| **Setup inicial** | Rápido (1 comando) | Lento (instalar PostgreSQL) |
| **Portabilidad** | ✅ Funciona igual en todos lados | ❌ Depende del sistema |
| **Velocidad desarrollo** | ⚠️ Más lento (rebuild) | ✅ Más rápido (hot reload) |
| **Debugging** | ⚠️ Más complejo | ✅ Fácil desde IDE |
| **Producción** | ✅ Recomendado | ❌ No recomendado |
| **Limpieza** | ✅ Fácil (docker-compose down) | ⚠️ Manual |

---

## 🎯 Recomendaciones

### Para Desarrollo Diario:
```bash
# Opción híbrida (mejor de ambos mundos)
# 1. PostgreSQL en Docker
docker-compose -f docker-compose.dev.yml up -d

# 2. Backend desde IDE o terminal
./mvnw spring-boot:run
```

### Para Demos o Producción:
```bash
# Todo en Docker
docker-compose up -d --build
```

### Para Testing:
```bash
# Ambiente limpio cada vez
docker-compose down -v
docker-compose up -d --build
./test-carrito.ps1
```

---

## 📞 Próximos Pasos

1. ✅ Iniciar el backend (con Docker o sin Docker)
2. ✅ Ejecutar `.\test-carrito.ps1` para verificar que funciona
3. ✅ Revisar `API_DOCUMENTATION_FLUTTER.md` para integrar con Flutter
4. ✅ Importar `Pizzas_Reyna_Postman_Collection.json` en Postman

---

## 🔗 Enlaces Útiles

- **Swagger UI:** http://localhost:8080/swagger-ui.html
- **API Docs:** http://localhost:8080/api-docs
- **Health Check:** http://localhost:8080/actuator/health (si está habilitado)

---

¡Listo para desarrollar! 🚀🍕
