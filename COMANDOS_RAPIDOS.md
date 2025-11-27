# ⚡ Comandos Rápidos - Pizzas Reyna Backend

Referencia rápida de comandos más usados.

---

## 🐳 Docker

### Iniciar Servicios
```bash
# Todo (Backend + PostgreSQL)
docker-compose up -d

# Solo PostgreSQL
docker-compose -f docker-compose.dev.yml up -d

# Con rebuild
docker-compose up -d --build

# Con script helper
.\start-docker.ps1              # Iniciar todo
.\start-docker.ps1 db-only      # Solo PostgreSQL
.\start-docker.ps1 rebuild      # Reconstruir todo
```

### Ver Estado y Logs
```bash
# Estado de servicios
docker-compose ps
.\start-docker.ps1 status

# Ver logs
docker-compose logs -f
docker-compose logs -f backend
docker-compose logs -f postgres
.\start-docker.ps1 logs
```

### Detener y Limpiar
```bash
# Detener servicios
docker-compose down
.\start-docker.ps1 stop

# Detener y eliminar volúmenes (borra BD)
docker-compose down -v

# Limpiar todo Docker
docker system prune -a
```

### Acceder a Contenedores
```bash
# Acceder a PostgreSQL
docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna

# Ver logs del backend
docker exec -it pizzasreyna-backend tail -f /var/log/spring.log

# Bash en el contenedor
docker exec -it pizzasreyna-backend sh
```

---

## 💻 Backend Local

### Compilar y Ejecutar
```bash
# Ejecutar directamente
./mvnw spring-boot:run

# Compilar
./mvnw clean compile

# Compilar y empaquetar
./mvnw clean package

# Ejecutar JAR
java -jar target/pizzaback-0.0.1-SNAPSHOT.jar

# Compilar sin tests
./mvnw clean package -DskipTests
```

### Testing
```bash
# Ejecutar todos los tests
./mvnw test

# Ejecutar test específico
./mvnw test -Dtest=AuthServiceTest

# Con coverage
./mvnw clean test jacoco:report
```

### Limpiar
```bash
# Limpiar build
./mvnw clean

# Limpiar caché de Maven
./mvnw dependency:purge-local-repository
```

---

## 🗄️ PostgreSQL

### Conexión
```bash
# Con Docker
docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna

# Local
psql -U postgres -d pizzasreyna
```

### Comandos Útiles
```sql
-- Ver todas las tablas
\dt

-- Describir tabla
\d usuario

-- Ver usuarios
SELECT * FROM usuario;

-- Ver pizzas
SELECT * FROM pizza;

-- Ver pedidos
SELECT * FROM pedido;

-- Limpiar tabla
TRUNCATE TABLE pedido CASCADE;

-- Resetear secuencias
ALTER SEQUENCE usuario_id_seq RESTART WITH 1;

-- Salir
\q
```

### Backup y Restore
```bash
# Backup
docker exec pizzasreyna-db pg_dump -U postgres pizzasreyna > backup.sql

# Restore
docker exec -i pizzasreyna-db psql -U postgres pizzasreyna < backup.sql
```

---

## 🧪 Testing de API

### Con PowerShell Scripts
```powershell
# Test completo de carrito
.\test-carrito.ps1

# Test de login
.\test-login-real.ps1

# Test general de API
.\test-api.ps1
```

### Con cURL
```bash
# Login
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@pizzasreyna.com","password":"admin123"}'

# Listar pizzas
curl http://localhost:8080/api/pizzas

# Obtener carrito (con token)
curl http://localhost:8080/api/usuario/carrito \
  -H "Authorization: Bearer YOUR_TOKEN"

# Agregar al carrito
curl -X POST http://localhost:8080/api/usuario/carrito/agregar \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"pizzaId":2,"cantidad":2}'
```

### Con Postman
```bash
# Importar colección
# Archivo: Pizzas_Reyna_Postman_Collection.json

# Variables de entorno
base_url = http://localhost:8080
auth_token = (se guarda automáticamente después del login)
```

---

## 🔍 Debugging

### Ver Logs del Backend
```bash
# Con Docker
docker-compose logs -f backend

# Local (en la consola donde corre)
# Los logs aparecen automáticamente

# Filtrar logs de JWT
docker-compose logs backend | grep "JWT Filter"

# Filtrar errores
docker-compose logs backend | grep "ERROR"
```

### Verificar Configuración
```bash
# Ver variables de entorno
docker-compose exec backend env

# Ver application.yml
cat src/main/resources/application.yml

# Verificar puerto
netstat -ano | findstr :8080
```

### Problemas Comunes
```bash
# Puerto 8080 ocupado
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Puerto 5432 ocupado
net stop postgresql-x64-15

# Limpiar caché de Maven
./mvnw clean

# Reconstruir Docker
docker-compose down -v
docker-compose up -d --build
```

---

## 📊 Monitoreo

### Health Check
```bash
# Verificar que el backend está vivo
curl http://localhost:8080/actuator/health

# Verificar PostgreSQL
docker exec pizzasreyna-db pg_isready -U postgres
```

### Métricas
```bash
# Ver métricas (si está habilitado)
curl http://localhost:8080/actuator/metrics

# Ver info de la aplicación
curl http://localhost:8080/actuator/info
```

---

## 🔧 Configuración

### Cambiar Puerto del Backend
```yaml
# src/main/resources/application.yml
server:
  port: 8081  # Cambiar de 8080 a 8081
```

### Cambiar Configuración de BD
```yaml
# src/main/resources/application.yml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/pizzasreyna
    username: postgres
    password: tu_password_aqui
```

### Cambiar JWT Secret
```yaml
# src/main/resources/application.yml
jwt:
  secret: tu_nuevo_secret_muy_largo_y_seguro_aqui
  expiration: 86400000  # 24 horas
```

---

## 📱 Integración con Flutter

### Obtener Documentación
```bash
# Ver documentación para Flutter
cat API_DOCUMENTATION_FLUTTER.md

# Ver ejemplos de respuestas
cat EJEMPLOS_RESPUESTAS_API.md

# Abrir Swagger UI
start http://localhost:8080/swagger-ui.html
```

### URLs para Flutter
```dart
// Desarrollo local
const String BASE_URL = 'http://localhost:8080';

// Android Emulator
const String BASE_URL = 'http://10.0.2.2:8080';

// iOS Simulator
const String BASE_URL = 'http://localhost:8080';

// Producción
const String BASE_URL = 'https://api.pizzasreyna.com';
```

---

## 🚀 Deployment

### Construir para Producción
```bash
# Construir JAR
./mvnw clean package -DskipTests

# Construir imagen Docker
docker build -t pizzasreyna-backend:latest .

# Ejecutar imagen
docker run -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://host:5432/pizzasreyna \
  -e SPRING_DATASOURCE_USERNAME=postgres \
  -e SPRING_DATASOURCE_PASSWORD=password \
  pizzasreyna-backend:latest
```

### Variables de Entorno para Producción
```bash
# JWT
JWT_SECRET=tu_secret_super_seguro_de_produccion
JWT_EXPIRATION=86400000

# Base de Datos
SPRING_DATASOURCE_URL=jdbc:postgresql://prod-host:5432/pizzasreyna
SPRING_DATASOURCE_USERNAME=prod_user
SPRING_DATASOURCE_PASSWORD=prod_password

# CORS
CORS_ALLOWED_ORIGINS=https://pizzasreyna.com,https://app.pizzasreyna.com
```

---

## 📚 Documentación

### Ver Documentación
```bash
# Swagger UI
start http://localhost:8080/swagger-ui.html

# OpenAPI JSON
curl http://localhost:8080/api-docs

# Documentación local
cat API_DOCUMENTATION_FLUTTER.md
cat GUIA_POSTMAN.md
cat SOLUCION_403_FORBIDDEN.md
```

---

## 🆘 Ayuda Rápida

```bash
# ¿Backend no inicia?
1. Verificar que PostgreSQL está corriendo
2. Verificar puerto 8080 libre
3. Ver logs: docker-compose logs backend

# ¿Error 403 en endpoints?
1. Verificar que el token JWT es válido
2. Ejecutar: .\test-carrito.ps1
3. Ver: SOLUCION_403_FORBIDDEN.md

# ¿Base de datos vacía?
1. Verificar que Flyway corrió: docker-compose logs backend | grep Flyway
2. Verificar migraciones: ls src/main/resources/db/migration/

# ¿Necesitas empezar de cero?
docker-compose down -v
docker-compose up -d --build
```

---

¡Guarda este archivo para referencia rápida! 📌
