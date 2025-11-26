# 📱 Documentación API para Flutter - Pizzas Reyna

## 🌐 Configuración Base

### URL Base
```dart
const String BASE_URL = 'http://localhost:8080';
// Para dispositivo físico o emulador Android: 'http://10.0.2.2:8080'
// Para iOS Simulator: 'http://localhost:8080'
// Para producción: 'https://api.pizzasreyna.com'
```

### Headers Comunes
```dart
Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

// Para endpoints autenticados
Map<String, String> headersWithAuth(String token) => {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer $token',
};
```

---

## 🔐 AUTENTICACIÓN

### 1. Registro de Usuario

**Endpoint:** `POST /api/auth/register`

**Request Body:**
```json
{
  "nombre": "Juan",
  "apellido": "Pérez",
  "email": "juan@example.com",
  "password": "password123",
  "telefono": "987654321",
  "direccion": "Av. Principal 123"
}
```

**Response (200 OK):**
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
    "telefono": "987654321",
    "direccion": "Av. Principal 123",
    "rol": "USUARIO",
    "activo": true
  }
}
```

**Ejemplo Flutter:**
```dart
Future<AuthResponse> register(RegisterRequest request) async {
  final response = await http.post(
    Uri.parse('$BASE_URL/api/auth/register'),
    headers: headers,
    body: jsonEncode(request.toJson()),
  );
  
  if (response.statusCode == 200) {
    return AuthResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error en registro');
  }
}
```

---

### 2. Login

**Endpoint:** `POST /api/auth/login`

**Request Body:**
```json
{
  "email": "juan@example.com",
  "password": "password123"
}
```

**Response (200 OK):**
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
    "telefono": "987654321",
    "direccion": "Av. Principal 123",
    "rol": "USUARIO",
    "activo": true
  }
}
```

**Credenciales Admin por Defecto:**
- Email: `admin@pizzasreyna.com`
- Password: `admin123`

---

## 🍕 CATÁLOGO DE PIZZAS

### 3. Listar Pizzas Disponibles

**Endpoint:** `GET /api/pizzas`

**Headers:** No requiere autenticación

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "nombre": "Margarita",
    "descripcion": "Pizza clásica con salsa de tomate, mozzarella y albahaca",
    "precioBase": 25.00,
    "tamanio": "MEDIANA",
    "disponible": true,
    "imagenUrl": "https://example.com/margarita.jpg",
    "esPersonalizada": false,
    "ingredientes": [
      {
        "id": 1,
        "nombre": "Queso Mozzarella",
        "descripcion": "Queso mozzarella de alta calidad",
        "precioAdicional": 2.00,
        "disponible": true,
        "imagenUrl": "https://example.com/mozzarella.jpg"
      }
    ]
  }
]
```

**Tamaños disponibles:**
- `PEQUEÑA`
- `MEDIANA`
- `GRANDE`
- `FAMILIAR`

---

### 4. Obtener Detalle de Pizza

**Endpoint:** `GET /api/pizzas/{id}`

**Headers:** No requiere autenticación

**Response (200 OK):**
```json
{
  "id": 1,
  "nombre": "Margarita",
  "descripcion": "Pizza clásica con salsa de tomate, mozzarella y albahaca",
  "precioBase": 25.00,
  "tamanio": "MEDIANA",
  "disponible": true,
  "imagenUrl": "https://example.com/margarita.jpg",
  "esPersonalizada": false,
  "ingredientes": [...]
}
```

---

## 🛒 CARRITO DE COMPRAS

### 5. Obtener Carrito

**Endpoint:** `GET /api/usuario/carrito`

**Headers:** Requiere autenticación (Bearer Token)

**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 1,
  "items": [
    {
      "id": 1,
      "pizzaId": 2,
      "pizzaNombre": "Pepperoni",
      "comboId": null,
      "comboNombre": null,
      "cantidad": 2,
      "precioUnitario": 30.00,
      "subtotal": 60.00,
      "notas": "Sin cebolla",
      "ingredientesPersonalizados": [
        {
          "id": 10,
          "nombre": "Tocino",
          "precioAdicional": 3.50
        }
      ]
    }
  ],
  "total": 60.00
}
```

---

### 6. Agregar Item al Carrito

**Endpoint:** `POST /api/usuario/carrito/agregar`

**Headers:** Requiere autenticación

**Request Body (Pizza):**
```json
{
  "pizzaId": 2,
  "comboId": null,
  "cantidad": 2,
  "notas": "Sin cebolla",
  "ingredientesPersonalizadosIds": [10, 12]
}
```

**Request Body (Combo):**
```json
{
  "pizzaId": null,
  "comboId": 1,
  "cantidad": 1,
  "notas": "Para llevar",
  "ingredientesPersonalizadosIds": null
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 1,
  "items": [...],
  "total": 60.00
}
```

---

### 7. Limpiar Carrito

**Endpoint:** `DELETE /api/usuario/carrito/limpiar`

**Headers:** Requiere autenticación

**Response (200 OK):** Sin contenido

---

## 📦 PEDIDOS

### 8. Crear Pedido

**Endpoint:** `POST /api/usuario/pedidos`

**Headers:** Requiere autenticación

**Request Body:**
```json
{
  "direccionEntrega": "Av. Principal 123, Dpto 401",
  "telefonoContacto": "987654321",
  "notas": "Tocar el timbre 2 veces",
  "items": [
    {
      "pizzaId": 2,
      "comboId": null,
      "cantidad": 2,
      "notas": "Sin cebolla",
      "ingredientesPersonalizadosIds": [10, 12]
    },
    {
      "pizzaId": null,
      "comboId": 1,
      "cantidad": 1,
      "notas": null,
      "ingredientesPersonalizadosIds": null
    }
  ]
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 1,
  "usuarioNombre": "Juan Pérez",
  "repartidorId": null,
  "repartidorNombre": null,
  "estadoNombre": "PENDIENTE",
  "direccionEntrega": "Av. Principal 123, Dpto 401",
  "telefonoContacto": "987654321",
  "subtotal": 95.00,
  "costoEnvio": 5.00,
  "total": 100.00,
  "notas": "Tocar el timbre 2 veces",
  "fechaPedido": "2024-11-26T10:30:00",
  "fechaEntregaEstimada": "2024-11-26T11:15:00",
  "fechaEntregaReal": null,
  "detalles": [
    {
      "id": 1,
      "pizzaId": 2,
      "pizzaNombre": "Pepperoni",
      "comboId": null,
      "comboNombre": null,
      "cantidad": 2,
      "precioUnitario": 33.50,
      "subtotal": 67.00,
      "notas": "Sin cebolla",
      "ingredientesPersonalizados": [...]
    }
  ]
}
```

---

### 9. Obtener Historial de Pedidos

**Endpoint:** `GET /api/usuario/pedidos`

**Headers:** Requiere autenticación

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "usuarioId": 1,
    "usuarioNombre": "Juan Pérez",
    "estadoNombre": "EN_CAMINO",
    "direccionEntrega": "Av. Principal 123",
    "total": 100.00,
    "fechaPedido": "2024-11-26T10:30:00",
    "fechaEntregaEstimada": "2024-11-26T11:15:00",
    "detalles": [...]
  }
]
```

---

### 10. Obtener Detalle de Pedido

**Endpoint:** `GET /api/usuario/pedidos/{id}`

**Headers:** Requiere autenticación

**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 1,
  "usuarioNombre": "Juan Pérez",
  "repartidorId": 5,
  "repartidorNombre": "Carlos",
  "estadoNombre": "EN_CAMINO",
  "direccionEntrega": "Av. Principal 123, Dpto 401",
  "telefonoContacto": "987654321",
  "subtotal": 95.00,
  "costoEnvio": 5.00,
  "total": 100.00,
  "notas": "Tocar el timbre 2 veces",
  "fechaPedido": "2024-11-26T10:30:00",
  "fechaEntregaEstimada": "2024-11-26T11:15:00",
  "fechaEntregaReal": null,
  "detalles": [...]
}
```

---

## 👨‍💼 ENDPOINTS ADMIN

### 11. Listar Todas las Pizzas (Admin)

**Endpoint:** `GET /api/admin/pizzas`

**Headers:** Requiere autenticación + rol ADMIN

**Response:** Igual que `/api/pizzas` pero incluye pizzas no disponibles

---

### 12. Crear Pizza (Admin)

**Endpoint:** `POST /api/admin/pizzas`

**Headers:** Requiere autenticación + rol ADMIN

**Request Body:**
```json
{
  "nombre": "Pizza BBQ",
  "descripcion": "Pizza con salsa BBQ",
  "precioBase": 35.00,
  "tamanio": "GRANDE",
  "disponible": true,
  "imagenUrl": "https://example.com/bbq.jpg",
  "esPersonalizada": false,
  "ingredientes": []
}
```

---

### 13. Actualizar Pizza (Admin)

**Endpoint:** `PUT /api/admin/pizzas/{id}`

**Headers:** Requiere autenticación + rol ADMIN

**Request Body:** Igual que crear pizza

---

### 14. Eliminar Pizza (Admin)

**Endpoint:** `DELETE /api/admin/pizzas/{id}`

**Headers:** Requiere autenticación + rol ADMIN

**Response (200 OK):** Sin contenido

---

### 15. Listar Todos los Pedidos (Admin)

**Endpoint:** `GET /api/admin/pedidos`

**Headers:** Requiere autenticación + rol ADMIN

**Response:** Array de todos los pedidos del sistema

---

### 16. Actualizar Estado de Pedido (Admin)

**Endpoint:** `PUT /api/admin/pedidos/{id}/estado?estado=EN_PREPARACION`

**Headers:** Requiere autenticación + rol ADMIN

**Query Params:**
- `estado`: Nuevo estado del pedido

**Estados disponibles:**
- `PENDIENTE`
- `CONFIRMADO`
- `EN_PREPARACION`
- `LISTO`
- `EN_CAMINO`
- `ENTREGADO`
- `CANCELADO`

**Response (200 OK):** Pedido actualizado

---

### 17. Asignar Repartidor (Admin)

**Endpoint:** `PUT /api/admin/pedidos/{id}/repartidor?repartidorId=5`

**Headers:** Requiere autenticación + rol ADMIN

**Query Params:**
- `repartidorId`: ID del repartidor a asignar

**Response (200 OK):** Pedido actualizado

---

## 🔌 WEBSOCKET - Tracking en Tiempo Real

### Configuración WebSocket

**URL:** `ws://localhost:8080/ws`

**Protocolo:** SockJS + STOMP

### Paquetes Flutter Recomendados
```yaml
dependencies:
  stomp_dart_client: ^1.0.0
  web_socket_channel: ^2.4.0
```

### Ejemplo de Conexión

```dart
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService {
  late StompClient stompClient;
  
  void connect() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/ws',
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
      ),
    );
    
    stompClient.activate();
  }
  
  void onConnect(StompFrame frame) {
    print('Conectado al WebSocket');
    
    // Suscribirse a actualizaciones de un pedido específico
    stompClient.subscribe(
      destination: '/topic/pedidos/1',
      callback: (frame) {
        final estado = jsonDecode(frame.body!);
        print('Nuevo estado del pedido: ${estado['estadoNombre']}');
        // Actualizar UI
      },
    );
    
    // Suscribirse a nuevos pedidos (para admin)
    stompClient.subscribe(
      destination: '/topic/pedidos/nuevos',
      callback: (frame) {
        final pedidoId = jsonDecode(frame.body!);
        print('Nuevo pedido recibido: $pedidoId');
        // Actualizar lista de pedidos
      },
    );
  }
  
  void disconnect() {
    stompClient.deactivate();
  }
}
```

### Canales Disponibles

1. **Actualizaciones de Pedido Específico:**
   - Canal: `/topic/pedidos/{pedidoId}`
   - Mensaje:
   ```json
   {
     "pedidoId": 1,
     "estadoNombre": "EN_CAMINO",
     "estadoDescripcion": "Pedido en camino al cliente",
     "fechaCambio": "2024-11-26T11:00:00",
     "comentario": null
   }
   ```

2. **Nuevos Pedidos (Admin):**
   - Canal: `/topic/pedidos/nuevos`
   - Mensaje: `1` (ID del nuevo pedido)

---

## 📊 MODELOS DART SUGERIDOS

### AuthResponse
```dart
class AuthResponse {
  final String token;
  final String refreshToken;
  final String tipo;
  final Usuario usuario;
  
  AuthResponse({
    required this.token,
    required this.refreshToken,
    required this.tipo,
    required this.usuario,
  });
  
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      refreshToken: json['refreshToken'],
      tipo: json['tipo'],
      usuario: Usuario.fromJson(json['usuario']),
    );
  }
}
```

### Usuario
```dart
class Usuario {
  final int id;
  final String nombre;
  final String apellido;
  final String email;
  final String? telefono;
  final String? direccion;
  final String rol;
  final bool activo;
  
  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    this.telefono,
    this.direccion,
    required this.rol,
    required this.activo,
  });
  
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      email: json['email'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      rol: json['rol'],
      activo: json['activo'],
    );
  }
}
```

### Pizza
```dart
class Pizza {
  final int id;
  final String nombre;
  final String descripcion;
  final double precioBase;
  final String tamanio;
  final bool disponible;
  final String? imagenUrl;
  final bool esPersonalizada;
  final List<Ingrediente> ingredientes;
  
  Pizza({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precioBase,
    required this.tamanio,
    required this.disponible,
    this.imagenUrl,
    required this.esPersonalizada,
    required this.ingredientes,
  });
  
  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precioBase: json['precioBase'].toDouble(),
      tamanio: json['tamanio'],
      disponible: json['disponible'],
      imagenUrl: json['imagenUrl'],
      esPersonalizada: json['esPersonalizada'],
      ingredientes: (json['ingredientes'] as List)
          .map((i) => Ingrediente.fromJson(i))
          .toList(),
    );
  }
}
```

### Pedido
```dart
class Pedido {
  final int id;
  final int usuarioId;
  final String usuarioNombre;
  final int? repartidorId;
  final String? repartidorNombre;
  final String estadoNombre;
  final String direccionEntrega;
  final String telefonoContacto;
  final double subtotal;
  final double costoEnvio;
  final double total;
  final String? notas;
  final DateTime fechaPedido;
  final DateTime? fechaEntregaEstimada;
  final DateTime? fechaEntregaReal;
  final List<PedidoDetalle> detalles;
  
  Pedido({
    required this.id,
    required this.usuarioId,
    required this.usuarioNombre,
    this.repartidorId,
    this.repartidorNombre,
    required this.estadoNombre,
    required this.direccionEntrega,
    required this.telefonoContacto,
    required this.subtotal,
    required this.costoEnvio,
    required this.total,
    this.notas,
    required this.fechaPedido,
    this.fechaEntregaEstimada,
    this.fechaEntregaReal,
    required this.detalles,
  });
  
  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      usuarioId: json['usuarioId'],
      usuarioNombre: json['usuarioNombre'],
      repartidorId: json['repartidorId'],
      repartidorNombre: json['repartidorNombre'],
      estadoNombre: json['estadoNombre'],
      direccionEntrega: json['direccionEntrega'],
      telefonoContacto: json['telefonoContacto'],
      subtotal: json['subtotal'].toDouble(),
      costoEnvio: json['costoEnvio'].toDouble(),
      total: json['total'].toDouble(),
      notas: json['notas'],
      fechaPedido: DateTime.parse(json['fechaPedido']),
      fechaEntregaEstimada: json['fechaEntregaEstimada'] != null 
          ? DateTime.parse(json['fechaEntregaEstimada']) 
          : null,
      fechaEntregaReal: json['fechaEntregaReal'] != null 
          ? DateTime.parse(json['fechaEntregaReal']) 
          : null,
      detalles: (json['detalles'] as List)
          .map((d) => PedidoDetalle.fromJson(d))
          .toList(),
    );
  }
}
```

---

## 🔒 MANEJO DE ERRORES

### Códigos de Estado HTTP

- **200 OK**: Operación exitosa
- **201 Created**: Recurso creado exitosamente
- **400 Bad Request**: Datos inválidos
- **401 Unauthorized**: No autenticado o token inválido
- **403 Forbidden**: No tiene permisos
- **404 Not Found**: Recurso no encontrado
- **500 Internal Server Error**: Error del servidor

### Ejemplo de Manejo de Errores

```dart
Future<Pizza> getPizza(int id) async {
  try {
    final response = await http.get(
      Uri.parse('$BASE_URL/api/pizzas/$id'),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return Pizza.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Pizza no encontrada');
    } else if (response.statusCode == 401) {
      throw Exception('No autenticado');
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
}
```

---

## 💡 TIPS DE INTEGRACIÓN

### 1. Almacenamiento del Token
```dart
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String TOKEN_KEY = 'auth_token';
  static const String REFRESH_TOKEN_KEY = 'refresh_token';
  
  static Future<void> saveToken(String token, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN_KEY, token);
    await prefs.setString(REFRESH_TOKEN_KEY, refreshToken);
  }
  
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }
  
  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
    await prefs.remove(REFRESH_TOKEN_KEY);
  }
}
```

### 2. Interceptor HTTP para Token
```dart
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await AuthStorage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expirado, redirigir a login
      // Navigator.pushReplacementNamed(context, '/login');
    }
    handler.next(err);
  }
}
```

### 3. Configuración para Emulador Android
```dart
// En Android Emulator, localhost del backend es 10.0.2.2
const String BASE_URL = Platform.isAndroid 
    ? 'http://10.0.2.2:8080' 
    : 'http://localhost:8080';
```

### 4. Manejo de Imágenes
Las URLs de imágenes en el backend son placeholders. Puedes:
- Usar imágenes locales en assets
- Implementar upload de imágenes
- Usar URLs de CDN externo

---

## 📞 SOPORTE

Si tienes dudas sobre algún endpoint o necesitas funcionalidad adicional, contacta al equipo de backend.

**Swagger UI (Documentación Interactiva):** http://localhost:8080/swagger-ui.html

---

¡Éxito con la integración! 🚀🍕
