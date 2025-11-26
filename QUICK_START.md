# 🚀 Quick Start - Pizzas Reyna Backend

## Opción 1: Docker (Recomendado)

### Levantar todo con Docker Compose

```bash
docker-compose up -d
```

Esto levantará:
- PostgreSQL en `localhost:5432`
- Backend en `localhost:8080`

### Ver logs

```bash
docker-compose logs -f backend
```

### Detener servicios

```bash
docker-compose down
```

## Opción 2: Desarrollo Local

### 1. Levantar solo PostgreSQL

```bash
docker-compose -f docker-compose.dev.yml up -d
```

### 2. Ejecutar el backend

```bash
./mvnw spring-boot:run
```

O en Windows:

```cmd
mvnw.cmd spring-boot:run
```

## 📍 URLs Importantes

- **API Base**: http://localhost:8080
- **Swagger UI**: http://localhost:8080/swagger-ui.html
- **OpenAPI Docs**: http://localhost:8080/api-docs

## 🔐 Credenciales por Defecto

### Admin
- **Email**: admin@pizzasreyna.com
- **Password**: admin123

## 🧪 Probar la API

### 1. Login como Admin

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@pizzasreyna.com",
    "password": "admin123"
  }'
```

### 2. Obtener Pizzas Disponibles

```bash
curl http://localhost:8080/api/pizzas
```

### 3. Registrar Usuario

```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan",
    "apellido": "Pérez",
    "email": "juan@example.com",
    "password": "password123",
    "telefono": "987654321",
    "direccion": "Av. Principal 123"
  }'
```

## 🔧 Troubleshooting

### Puerto 8080 ocupado

Cambiar en `application.yml`:

```yaml
server:
  port: 8081
```

### Error de conexión a PostgreSQL

Verificar que PostgreSQL esté corriendo:

```bash
docker-compose ps
```

### Limpiar y reconstruir

```bash
docker-compose down -v
docker-compose up -d --build
```

## 📦 Build para Producción

```bash
./mvnw clean package -DskipTests
```

El JAR estará en `target/pizzaback-0.0.1-SNAPSHOT.jar`

## 🧪 Ejecutar Tests

```bash
./mvnw test
```

## 📊 Base de Datos

### Conectar a PostgreSQL

```bash
docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna
```

### Ver tablas

```sql
\dt
```

### Ver datos de ejemplo

```sql
SELECT * FROM pizza;
SELECT * FROM ingrediente;
SELECT * FROM combo;
```

## 🌐 WebSocket Testing

Puedes probar WebSockets usando herramientas como:
- [WebSocket King](https://websocketking.com/)
- [Postman](https://www.postman.com/)

**URL**: `ws://localhost:8080/ws`

**Suscribirse a un pedido**:
```
SUBSCRIBE /topic/pedidos/1
```

## 📝 Notas

- Las migraciones de Flyway se ejecutan automáticamente al iniciar
- Los datos de ejemplo se cargan automáticamente
- JWT expira en 24 horas
- Refresh token expira en 7 días
