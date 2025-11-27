# 🍕 Pizzas Reyna - Backend API

Sistema backend completo para plataforma de delivery de pizzas personalizadas con seguimiento en tiempo real, gestión de pedidos y pagos integrados.

## 📋 Tabla de Contenidos

- [Tecnologías](#-tecnologías)
- [Requisitos Previos](#-requisitos-previos)
- [Instalación y Ejecución](#-instalación-y-ejecución)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Endpoints de la API](#-endpoints-de-la-api)
- [Autenticación](#-autenticación)
- [WebSocket](#-websocket)
- [Base de Datos](#-base-de-datos)
- [Testing](#-testing)

## 🚀 Tecnologías

- **Java 17**
- **Spring Boot 4.0.0**
- **PostgreSQL 15**
- **Maven**
- **Flyway** - Migraciones de base de datos
- **JWT** - Autenticación y autorización
- **WebSocket** - Comunicación en tiempo real
- **Swagger/OpenAPI 3** - Documentación de API
- **Docker & Docker Compose** - Contenedorización
- **Lombok** - Reducción de código boilerplate

## 📦 Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- **Java 17** o superior ([Descargar](https://adoptium.net/))
- **Maven 3.8+** (incluido en el proyecto con Maven Wrapper)
- **Docker** y **Docker Compose** ([Descargar](https://www.docker.com/))
- **Git** ([Descargar](https://git-scm.com/))

### Verificar instalaciones:

```bash
java -version
docker --version
docker-compose --version
```

## 🔧 Instalación y Ejecución

> 💡 **Nota:** Después de clonar el proyecto, revisa `GUIA_INICIO_RAPIDO.md` para instrucciones detalladas.

### 🐳 Opción 1: Con Docker (Recomendado)

La forma más rápida de iniciar el proyecto completo:

```bash
# Clonar el repositorio
git clone <repository-url>
cd pizzaback

# Iniciar todo (Backend + PostgreSQL)
docker-compose up -d --build

# Ver logs
docker-compose logs -f

# O usar el script helper
.\start-docker.ps1
```

**URLs disponibles:**
- Backend: http://localhost:8080
- Swagger UI: http://localhost:8080/swagger-ui.html
- PostgreSQL: localhost:5432

**Comandos útiles:**
```bash
# Ver estado
.\start-docker.ps1 status

# Ver logs
.\start-docker.ps1 logs

# Detener servicios
.\start-docker.ps1 stop

# Reconstruir todo
.\start-docker.ps1 rebuild
```

---

### 💻 Opción 2: Sin Docker (Desarrollo Local)

Si prefieres correr el backend localmente:

#### 1. Instalar PostgreSQL

**Windows:**
```powershell
choco install postgresql
net start postgresql-x64-15
```

**Linux:**
```bash
sudo apt install postgresql
sudo systemctl start postgresql
```

**macOS:**
```bash
brew install postgresql@15
brew services start postgresql@15
```

#### 2. Crear la Base de Datos

```bash
psql -U postgres
CREATE DATABASE pizzasreyna;
\q
```

#### 3. Iniciar el Backend

```bash
# Compilar y ejecutar
./mvnw spring-boot:run

# O construir JAR
./mvnw clean package
java -jar target/pizzaback-0.0.1-SNAPSHOT.jar
```

---

### 🔄 Opción 3: Híbrida (PostgreSQL en Docker, Backend Local)

Ideal para desarrollo con hot-reload:

```bash
# 1. Iniciar solo PostgreSQL
docker-compose -f docker-compose.dev.yml up -d

# 2. Iniciar backend localmente
./mvnw spring-boot:run
```

---

## ✅ Verificar Instalación

Después de iniciar el backend, ejecuta:

```powershell
# Probar autenticación y endpoints
.\test-carrito.ps1

# O manualmente
curl http://localhost:8080/api/pizzas
```

Deberías ver la lista de pizzas disponibles.

Esta opción levanta tanto la base de datos como el backend en contenedores Docker.

#### 1. Clonar el repositorio

```bash
git clone <url-del-repositorio>
cd pizzaback
```

#### 2. Levantar los servicios

```bash
docker-compose up -d
```

Esto iniciará:
- **PostgreSQL** en el puerto `5432`
- **Backend** en el puerto `8080`

#### 3. Verificar que los servicios estén corriendo

```bash
docker-compose ps
```

Deberías ver algo como:

```
NAME                    STATUS              PORTS
pizzasreyna-backend     Up                  0.0.0.0:8080->8080/tcp
pizzasreyna-db          Up (healthy)        0.0.0.0:5432->5432/tcp
```

#### 4. Ver los logs

```bash
# Ver logs del backend
docker-compose logs -f backend

# Ver logs de PostgreSQL
docker-compose logs -f postgres
```

#### 5. Detener los servicios

```bash
docker-compose down
```

Para eliminar también los volúmenes (datos de la BD):

```bash
docker-compose down -v
```

---

### Opción 2: Desarrollo Local

Esta opción es ideal para desarrollo, ya que permite hot-reload del código.

#### 1. Levantar solo PostgreSQL con Docker

```bash
docker-compose -f docker-compose.dev.yml up -d
```

#### 2. Compilar el proyecto

```bash
# En Linux/Mac
./mvnw clean install

# En Windows
mvnw.cmd clean install
```

#### 3. Ejecutar el backend

```bash
# En Linux/Mac
./mvnw spring-boot:run

# En Windows
mvnw.cmd spring-boot:run
```

El backend estará disponible en `http://localhost:8080`

#### 4. Detener el backend

Presiona `Ctrl + C` en la terminal donde está corriendo.

Para detener PostgreSQL:

```bash
docker-compose -f docker-compose.dev.yml down
```

---

### Opción 3: Ejecución Manual (Sin Docker)

Si prefieres instalar PostgreSQL manualmente:

#### 1. Instalar y configurar PostgreSQL

Instala PostgreSQL 15 y crea la base de datos:

```sql
CREATE DATABASE pizzasreyna;
CREATE USER postgres WITH PASSWORD 'postgres';
GRANT ALL PRIVILEGES ON DATABASE pizzasreyna TO postgres;
```

#### 2. Configurar application.yml

Edita `src/main/resources/application.yml` si es necesario:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/pizzasreyna
    username: postgres
    password: postgres
```

#### 3. Ejecutar el backend

```bash
./mvnw spring-boot:run
```

## 📂 Estructura del Proyecto

El proyecto sigue **Clean Architecture** con las siguientes capas:

```
src/main/java/com/pizzasreyna/pizzaback/
│
├── domain/                      # Capa de Dominio
│   ├── model/                  # Entidades del negocio
│   │   ├── Usuario.java
│   │   ├── Pizza.java
│   │   ├── Pedido.java
│   │   ├── Carrito.java
│   │   └── ...
│   └── repository/             # Interfaces de repositorios
│       ├── UsuarioRepository.java
│       ├── PizzaRepository.java
│       └── ...
│
├── application/                 # Capa de Aplicación
│   ├── service/                # Servicios de negocio
│   │   ├── AuthService.java
│   │   ├── PizzaService.java
│   │   ├── PedidoService.java
│   │   └── CarritoService.java
│   └── usecase/                # Casos de uso
│
├── infrastructure/              # Capa de Infraestructura
│   ├── config/                 # Configuraciones
│   │   ├── CorsConfig.java
│   │   └── OpenApiConfig.java
│   ├── security/               # Seguridad y JWT
│   │   ├── JwtUtil.java
│   │   ├── JwtAuthenticationFilter.java
│   │   ├── SecurityConfig.java
│   │   └── CustomUserDetailsService.java
│   ├── repository/             # Implementaciones JPA
│   └── websocket/              # Configuración WebSocket
│       ├── WebSocketConfig.java
│       └── PedidoWebSocketService.java
│
└── adapters/                    # Capa de Adaptadores
    ├── controller/             # Controladores REST
    │   ├── AuthController.java
    │   ├── PizzaController.java
    │   ├── PedidoController.java
    │   ├── CarritoController.java
    │   ├── AdminPizzaController.java
    │   └── AdminPedidoController.java
    ├── dto/                    # Data Transfer Objects
    │   ├── LoginRequest.java
    │   ├── RegisterRequest.java
    │   ├── PizzaDTO.java
    │   └── ...
    └── mapper/                 # Mappers DTO <-> Entity
        ├── UsuarioMapper.java
        ├── PizzaMapper.java
        └── ...
```

## 🌐 Endpoints de la API

Una vez que el backend esté corriendo, puedes acceder a:

### Documentación Interactiva

- **Swagger UI**: http://localhost:8080/swagger-ui.html
- **OpenAPI JSON**: http://localhost:8080/api-docs

### Endpoints Principales

#### 🔓 Públicos (Sin autenticación)

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| POST | `/api/auth/register` | Registrar nuevo usuario |
| POST | `/api/auth/login` | Iniciar sesión |
| GET | `/api/pizzas` | Listar pizzas disponibles |
| GET | `/api/pizzas/{id}` | Obtener detalle de pizza |

#### 👤 Usuario (Requiere autenticación)

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/usuario/carrito` | Ver carrito actual |
| POST | `/api/usuario/carrito/agregar` | Agregar item al carrito |
| DELETE | `/api/usuario/carrito/limpiar` | Vaciar carrito |
| POST | `/api/usuario/pedidos` | Crear nuevo pedido |
| GET | `/api/usuario/pedidos` | Ver historial de pedidos |
| GET | `/api/usuario/pedidos/{id}` | Ver detalle de pedido |

#### 👨‍💼 Admin (Requiere rol ADMIN)

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/admin/pizzas` | Listar todas las pizzas |
| POST | `/api/admin/pizzas` | Crear nueva pizza |
| PUT | `/api/admin/pizzas/{id}` | Actualizar pizza |
| DELETE | `/api/admin/pizzas/{id}` | Eliminar pizza |
| GET | `/api/admin/pedidos` | Ver todos los pedidos |
| PUT | `/api/admin/pedidos/{id}/estado` | Actualizar estado de pedido |
| PUT | `/api/admin/pedidos/{id}/repartidor` | Asignar repartidor |

## 🔐 Autenticación

El sistema usa **JWT (JSON Web Tokens)** para autenticación.

### 1. Registrar un nuevo usuario

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

### 2. Iniciar sesión

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "juan@example.com",
    "password": "password123"
  }'
```

**Respuesta:**

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "tipo": "Bearer",
  "usuario": {
    "id": 1,
    "nombre": "Juan",
    "apellido": "Pérez",
    "email": "juan@example.com",
    "rol": "USUARIO",
    "activo": true
  }
}
```

### 3. Usar el token en peticiones

Incluye el token en el header `Authorization`:

```bash
curl -X GET http://localhost:8080/api/usuario/carrito \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
```

### Credenciales de Admin por Defecto

- **Email**: `admin@pizzasreyna.com`
- **Password**: `admin123`

### Roles del Sistema

- **ADMIN**: Acceso completo al sistema
- **USUARIO**: Cliente que puede hacer pedidos
- **REPARTIDOR**: Repartidor de pedidos

## 🔌 WebSocket

El sistema incluye WebSocket para seguimiento en tiempo real de pedidos.

### Conectar al WebSocket

**URL**: `ws://localhost:8080/ws`

### Ejemplo con JavaScript

```javascript
// Conectar usando SockJS y STOMP
const socket = new SockJS('http://localhost:8080/ws');
const stompClient = Stomp.over(socket);

stompClient.connect({}, function(frame) {
    console.log('Conectado: ' + frame);

    // Suscribirse a actualizaciones de un pedido específico
    stompClient.subscribe('/topic/pedidos/1', function(message) {
        const estado = JSON.parse(message.body);
        console.log('Nuevo estado del pedido:', estado);
    });

    // Suscribirse a nuevos pedidos (para admin)
    stompClient.subscribe('/topic/pedidos/nuevos', function(message) {
        const pedidoId = JSON.parse(message.body);
        console.log('Nuevo pedido recibido:', pedidoId);
    });
});
```

### Canales Disponibles

- `/topic/pedidos/{pedidoId}` - Actualizaciones de estado de un pedido específico
- `/topic/pedidos/nuevos` - Notificaciones de nuevos pedidos (para admin)

## 🗄️ Base de Datos

### Esquema de Base de Datos

El sistema incluye las siguientes tablas principales:

- **usuario** - Usuarios del sistema
- **rol** - Roles (ADMIN, USUARIO, REPARTIDOR)
- **pizza** - Catálogo de pizzas
- **ingrediente** - Ingredientes disponibles
- **combo** - Combos de pizzas
- **pedido** - Pedidos realizados
- **pedido_detalle** - Detalles de cada pedido
- **carrito** - Carritos de compra
- **carrito_item** - Items en el carrito
- **repartidor** - Información de repartidores
- **pago** - Información de pagos
- **estado_pedido** - Estados de pedidos

### Migraciones Flyway

Las migraciones se ejecutan automáticamente al iniciar la aplicación:

- `V1__create_initial_schema.sql` - Crea todas las tablas
- `V2__insert_sample_data.sql` - Inserta datos de ejemplo

### Conectar a la Base de Datos

```bash
# Conectar al contenedor de PostgreSQL
docker exec -it pizzasreyna-db psql -U postgres -d pizzasreyna

# Ver todas las tablas
\dt

# Ver datos de ejemplo
SELECT * FROM pizza;
SELECT * FROM ingrediente;
SELECT * FROM usuario;
```

### Datos de Ejemplo Incluidos

El sistema viene con datos de ejemplo:

- **1 Usuario Admin** (admin@pizzasreyna.com / admin123)
- **15 Ingredientes** (Mozzarella, Pepperoni, Jamón, etc.)
- **8 Pizzas** (Margarita, Pepperoni, Hawaiana, etc.)
- **3 Combos** (Familiar, Pareja, Party)
- **7 Estados de Pedido** (Pendiente, Confirmado, En Preparación, etc.)

## 🧪 Testing

### Ejecutar todos los tests

```bash
./mvnw test
```

### Ejecutar tests de integración

```bash
./mvnw verify
```

### Test de compilación

```bash
./mvnw clean compile
```

## 📦 Build para Producción

### Generar JAR ejecutable

```bash
./mvnw clean package -DskipTests
```

El archivo JAR se generará en: `target/pizzaback-0.0.1-SNAPSHOT.jar`

### Ejecutar el JAR

```bash
java -jar target/pizzaback-0.0.1-SNAPSHOT.jar
```

## 🔍 Troubleshooting

### Error: Puerto 8080 ya está en uso

**Solución**: Cambiar el puerto en `src/main/resources/application.yml`:

```yaml
server:
  port: 8081
```

### Error: No se puede conectar a PostgreSQL

**Verificar que PostgreSQL esté corriendo:**

```bash
docker-compose ps
```

**Reiniciar PostgreSQL:**

```bash
docker-compose restart postgres
```

### Error: Flyway migration failed

**Limpiar la base de datos y volver a crear:**

```bash
docker-compose down -v
docker-compose up -d
```

### Error: Cannot find symbol (compilación)

**Limpiar y recompilar:**

```bash
./mvnw clean install -DskipTests
```

### Ver logs detallados

```bash
# Logs del backend
docker-compose logs -f backend

# Logs de PostgreSQL
docker-compose logs -f postgres

# Todos los logs
docker-compose logs -f
```

## 📝 Configuración Adicional

### Configuración de JWT y Mejores Prácticas de Seguridad

La configuración de JWT se encuentra en `src/main/resources/application.yml`:

```yaml
jwt:
  # Para desarrollo - en producción usar variables de entorno o un vault seguro
  # El secret debe tener al menos 256 bits (32 caracteres) para el algoritmo HS256
  secret: ${JWT_SECRET:UHl6emFzUmV5bmEyMDI0U2VjcmV0S2V5MzJDaGFyYWN0ZXJz}
  expiration: 86400000      # 24 horas en milisegundos
  refresh-expiration: 604800000  # 7 días en milisegundos
```

#### Mejores Prácticas para JWT

1. **Nunca hardcodear el secret en archivos de configuración**:
   - Usa variables de entorno: `${JWT_SECRET}`
   - Usa servicios de gestión de secretos como AWS Secrets Manager, HashiCorp Vault, etc.

2. **Longitud y complejidad del secret**:
   - Para HMAC-SHA256 (HS256), usa al menos 32 caracteres (256 bits)
   - Usa caracteres aleatorios (letras, números, símbolos)
   - Considera usar Base64 para representar valores binarios

3. **Rotación de secrets**:
   - Cambia el secret periódicamente
   - Implementa un mecanismo para invalidar tokens antiguos

4. **Configuración en diferentes entornos**:

   **Desarrollo**:
   ```bash
   # Establecer variable de entorno en desarrollo
   export JWT_SECRET=tu_secret_seguro_para_desarrollo
   ```

   **Producción**:
   ```bash
   # Establecer variable de entorno en producción
   export JWT_SECRET=$(openssl rand -base64 32)
   ```

5. **Seguridad adicional**:
   - Usa HTTPS para todas las comunicaciones
   - Implementa tiempos de expiración cortos
   - Considera usar JWE (JWT Encriptado) para información sensible

### Configurar CORS

```yaml
cors:
  allowed-origins: http://localhost:3000,http://localhost:4200
  allowed-methods: GET,POST,PUT,DELETE,PATCH,OPTIONS
  allowed-headers: "*"
  allow-credentials: true
```

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto es privado y confidencial.

## 📧 Contacto

Para soporte técnico: contacto@pizzasreyna.com

---

**¡Disfruta desarrollando con Pizzas Reyna Backend! 🍕**
