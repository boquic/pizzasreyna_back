# 📋 Ejemplos de Respuestas de la API

Este documento muestra ejemplos de las respuestas que recibirás al probar los endpoints con los datos reales de tu base de datos.

---

## 🔐 Autenticación

### POST /api/auth/login
**Request:**
```json
{
  "email": "admin@pizzasreyna.com",
  "password": "admin123"
}
```

**Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBwaXp6YXNyZXluYS5jb20iLCJpYXQiOjE3MzI3MjAwMDAsImV4cCI6MTczMjcyMzYwMH0...",
  "refreshToken": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBwaXp6YXNyZXluYS5jb20iLCJpYXQiOjE3MzI3MjAwMDAsImV4cCI6MTczMzMyNDgwMH0...",
  "tipo": "Bearer",
  "usuario": {
    "id": 1,
    "nombre": "Admin",
    "apellido": "Sistema",
    "email": "admin@pizzasreyna.com",
    "telefono": "999888777",
    "direccion": "Oficina Central",
    "rol": "ADMIN",
    "activo": true
  }
}
```

### POST /api/auth/register
**Request:**
```json
{
  "nombre": "Juan",
  "apellido": "Pérez",
  "email": "juan.perez@example.com",
  "password": "password123",
  "telefono": "987654321",
  "direccion": "Av. Principal 123, Lima"
}
```

**Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "refreshToken": "eyJhbGciOiJIUzI1NiJ9...",
  "tipo": "Bearer",
  "usuario": {
    "id": 2,
    "nombre": "Juan",
    "apellido": "Pérez",
    "email": "juan.perez@example.com",
    "telefono": "987654321",
    "direccion": "Av. Principal 123, Lima",
    "rol": "USUARIO",
    "activo": true
  }
}
```

---

## 🍕 Pizzas

### GET /api/pizzas
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
      },
      {
        "id": 8,
        "nombre": "Tomate",
        "descripcion": "Tomate fresco",
        "precioAdicional": 1.50,
        "disponible": true,
        "imagenUrl": "https://example.com/tomate.jpg"
      },
      {
        "id": 14,
        "nombre": "Albahaca",
        "descripcion": "Albahaca fresca",
        "precioAdicional": 1.00,
        "disponible": true,
        "imagenUrl": "https://example.com/albahaca.jpg"
      }
    ]
  },
  {
    "id": 2,
    "nombre": "Pepperoni",
    "descripcion": "Pizza con abundante pepperoni y queso mozzarella",
    "precioBase": 30.00,
    "tamanio": "MEDIANA",
    "disponible": true,
    "imagenUrl": "https://example.com/pepperoni-pizza.jpg",
    "esPersonalizada": false,
    "ingredientes": [
      {
        "id": 1,
        "nombre": "Queso Mozzarella",
        "descripcion": "Queso mozzarella de alta calidad",
        "precioAdicional": 2.00,
        "disponible": true,
        "imagenUrl": "https://example.com/mozzarella.jpg"
      },
      {
        "id": 2,
        "nombre": "Pepperoni",
        "descripcion": "Pepperoni italiano premium",
        "precioAdicional": 3.50,
        "disponible": true,
        "imagenUrl": "https://example.com/pepperoni.jpg"
      }
    ]
  }
  // ... más pizzas
]
```

### GET /api/pizzas/2
**Response (200 OK):**
```json
{
  "id": 2,
  "nombre": "Pepperoni",
  "descripcion": "Pizza con abundante pepperoni y queso mozzarella",
  "precioBase": 30.00,
  "tamanio": "MEDIANA",
  "disponible": true,
  "imagenUrl": "https://example.com/pepperoni-pizza.jpg",
  "esPersonalizada": false,
  "ingredientes": [
    {
      "id": 1,
      "nombre": "Queso Mozzarella",
      "descripcion": "Queso mozzarella de alta calidad",
      "precioAdicional": 2.00,
      "disponible": true,
      "imagenUrl": "https://example.com/mozzarella.jpg"
    },
    {
      "id": 2,
      "nombre": "Pepperoni",
      "descripcion": "Pepperoni italiano premium",
      "precioAdicional": 3.50,
      "disponible": true,
      "imagenUrl": "https://example.com/pepperoni.jpg"
    }
  ]
}
```

---

## 🛒 Carrito

### GET /api/usuario/carrito (Carrito Vacío)
**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 2,
  "items": [],
  "total": 0.00
}
```

### POST /api/usuario/carrito/agregar
**Request:**
```json
{
  "pizzaId": 2,
  "comboId": null,
  "cantidad": 2,
  "notas": "Sin cebolla por favor",
  "ingredientesPersonalizadosIds": [10, 4]
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 2,
  "items": [
    {
      "id": 1,
      "pizzaId": 2,
      "pizzaNombre": "Pepperoni",
      "comboId": null,
      "comboNombre": null,
      "cantidad": 2,
      "precioUnitario": 36.00,
      "subtotal": 72.00,
      "notas": "Sin cebolla por favor",
      "ingredientesPersonalizados": [
        {
          "id": 10,
          "nombre": "Tocino",
          "precioAdicional": 3.50
        },
        {
          "id": 4,
          "nombre": "Champiñones",
          "precioAdicional": 2.50
        }
      ]
    }
  ],
  "total": 72.00
}
```

**Cálculo del precio:**
- Precio base Pepperoni: S/. 30.00
- Tocino: +S/. 3.50
- Champiñones: +S/. 2.50
- **Precio unitario:** S/. 36.00
- **Cantidad:** 2
- **Subtotal:** S/. 72.00

### GET /api/usuario/carrito (Con Items)
**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 2,
  "items": [
    {
      "id": 1,
      "pizzaId": 2,
      "pizzaNombre": "Pepperoni",
      "comboId": null,
      "comboNombre": null,
      "cantidad": 2,
      "precioUnitario": 36.00,
      "subtotal": 72.00,
      "notas": "Sin cebolla por favor",
      "ingredientesPersonalizados": [
        {
          "id": 10,
          "nombre": "Tocino",
          "precioAdicional": 3.50
        },
        {
          "id": 4,
          "nombre": "Champiñones",
          "precioAdicional": 2.50
        }
      ]
    },
    {
      "id": 2,
      "pizzaId": 3,
      "pizzaNombre": "Hawaiana",
      "comboId": null,
      "comboNombre": null,
      "cantidad": 1,
      "precioUnitario": 34.50,
      "subtotal": 34.50,
      "notas": "Extra piña",
      "ingredientesPersonalizados": [
        {
          "id": 9,
          "nombre": "Piña",
          "precioAdicional": 2.50
        }
      ]
    }
  ],
  "total": 106.50
}
```

---

## 📦 Pedidos

### POST /api/usuario/pedidos
**Request:**
```json
{
  "direccionEntrega": "Av. Arequipa 1234, Miraflores, Lima",
  "telefonoContacto": "987654321",
  "notas": "Tocar el timbre 2 veces",
  "items": [
    {
      "pizzaId": 2,
      "comboId": null,
      "cantidad": 2,
      "notas": "Sin cebolla",
      "ingredientesPersonalizadosIds": [10]
    }
  ]
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 2,
  "usuarioNombre": "Juan Pérez",
  "repartidorId": null,
  "repartidorNombre": null,
  "estadoNombre": "PENDIENTE",
  "direccionEntrega": "Av. Arequipa 1234, Miraflores, Lima",
  "telefonoContacto": "987654321",
  "subtotal": 67.00,
  "costoEnvio": 5.00,
  "total": 72.00,
  "notas": "Tocar el timbre 2 veces",
  "fechaPedido": "2024-11-27T14:30:00",
  "fechaEntregaEstimada": "2024-11-27T15:15:00",
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
      "ingredientesPersonalizados": [
        {
          "id": 10,
          "nombre": "Tocino",
          "precioAdicional": 3.50
        }
      ]
    }
  ]
}
```

**Cálculo del pedido:**
- 2 Pizzas Pepperoni: S/. 30.00 × 2 = S/. 60.00
- Tocino extra: S/. 3.50 × 2 = S/. 7.00
- **Subtotal:** S/. 67.00
- **Costo de envío:** S/. 5.00
- **Total:** S/. 72.00

### GET /api/usuario/pedidos
**Response (200 OK):**
```json
[
  {
    "id": 1,
    "usuarioId": 2,
    "usuarioNombre": "Juan Pérez",
    "repartidorId": null,
    "repartidorNombre": null,
    "estadoNombre": "PENDIENTE",
    "direccionEntrega": "Av. Arequipa 1234, Miraflores, Lima",
    "telefonoContacto": "987654321",
    "subtotal": 67.00,
    "costoEnvio": 5.00,
    "total": 72.00,
    "notas": "Tocar el timbre 2 veces",
    "fechaPedido": "2024-11-27T14:30:00",
    "fechaEntregaEstimada": "2024-11-27T15:15:00",
    "fechaEntregaReal": null,
    "detalles": [...]
  },
  {
    "id": 2,
    "usuarioId": 2,
    "usuarioNombre": "Juan Pérez",
    "repartidorId": 1,
    "repartidorNombre": "Admin Sistema",
    "estadoNombre": "ENTREGADO",
    "direccionEntrega": "Jr. Los Olivos 456, San Isidro, Lima",
    "telefonoContacto": "912345678",
    "subtotal": 120.00,
    "costoEnvio": 5.00,
    "total": 125.00,
    "notas": "Dejar en recepción",
    "fechaPedido": "2024-11-26T18:00:00",
    "fechaEntregaEstimada": "2024-11-26T18:45:00",
    "fechaEntregaReal": "2024-11-26T18:40:00",
    "detalles": [...]
  }
]
```

### GET /api/usuario/pedidos/1
**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 2,
  "usuarioNombre": "Juan Pérez",
  "repartidorId": null,
  "repartidorNombre": null,
  "estadoNombre": "PENDIENTE",
  "direccionEntrega": "Av. Arequipa 1234, Miraflores, Lima",
  "telefonoContacto": "987654321",
  "subtotal": 67.00,
  "costoEnvio": 5.00,
  "total": 72.00,
  "notas": "Tocar el timbre 2 veces",
  "fechaPedido": "2024-11-27T14:30:00",
  "fechaEntregaEstimada": "2024-11-27T15:15:00",
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
      "ingredientesPersonalizados": [
        {
          "id": 10,
          "nombre": "Tocino",
          "precioAdicional": 3.50
        }
      ]
    }
  ]
}
```

---

## 👨‍💼 Admin - Pizzas

### GET /api/admin/pizzas
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
    "ingredientes": [...]
  },
  // ... todas las pizzas, incluidas las no disponibles
]
```

### POST /api/admin/pizzas
**Request:**
```json
{
  "nombre": "Pizza BBQ Especial",
  "descripcion": "Pizza con salsa BBQ, pollo, tocino y cebolla caramelizada",
  "precioBase": 38.00,
  "tamanio": "GRANDE",
  "disponible": true,
  "imagenUrl": "https://example.com/bbq-especial.jpg",
  "esPersonalizada": false,
  "ingredientes": [
    {
      "id": 1
    },
    {
      "id": 12
    },
    {
      "id": 10
    },
    {
      "id": 7
    }
  ]
}
```

**Response (200 OK):**
```json
{
  "id": 9,
  "nombre": "Pizza BBQ Especial",
  "descripcion": "Pizza con salsa BBQ, pollo, tocino y cebolla caramelizada",
  "precioBase": 38.00,
  "tamanio": "GRANDE",
  "disponible": true,
  "imagenUrl": "https://example.com/bbq-especial.jpg",
  "esPersonalizada": false,
  "ingredientes": [
    {
      "id": 1,
      "nombre": "Queso Mozzarella",
      "descripcion": "Queso mozzarella de alta calidad",
      "precioAdicional": 2.00,
      "disponible": true,
      "imagenUrl": "https://example.com/mozzarella.jpg"
    },
    {
      "id": 12,
      "nombre": "Pollo",
      "descripcion": "Pollo a la parrilla",
      "precioAdicional": 4.00,
      "disponible": true,
      "imagenUrl": "https://example.com/pollo.jpg"
    },
    {
      "id": 10,
      "nombre": "Tocino",
      "descripcion": "Tocino crujiente",
      "precioAdicional": 3.50,
      "disponible": true,
      "imagenUrl": "https://example.com/tocino.jpg"
    },
    {
      "id": 7,
      "nombre": "Cebolla",
      "descripcion": "Cebolla morada",
      "precioAdicional": 1.50,
      "disponible": true,
      "imagenUrl": "https://example.com/cebolla.jpg"
    }
  ]
}
```

### PUT /api/admin/pizzas/1
**Request:**
```json
{
  "nombre": "Margarita Premium",
  "descripcion": "Pizza clásica con salsa de tomate, mozzarella premium y albahaca fresca",
  "precioBase": 28.00,
  "tamanio": "MEDIANA",
  "disponible": true,
  "imagenUrl": "https://example.com/margarita-premium.jpg",
  "esPersonalizada": false,
  "ingredientes": [
    {
      "id": 1
    },
    {
      "id": 8
    },
    {
      "id": 14
    }
  ]
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "nombre": "Margarita Premium",
  "descripcion": "Pizza clásica con salsa de tomate, mozzarella premium y albahaca fresca",
  "precioBase": 28.00,
  "tamanio": "MEDIANA",
  "disponible": true,
  "imagenUrl": "https://example.com/margarita-premium.jpg",
  "esPersonalizada": false,
  "ingredientes": [...]
}
```

---

## 👨‍💼 Admin - Pedidos

### GET /api/admin/pedidos
**Response (200 OK):**
```json
[
  {
    "id": 1,
    "usuarioId": 2,
    "usuarioNombre": "Juan Pérez",
    "repartidorId": null,
    "repartidorNombre": null,
    "estadoNombre": "PENDIENTE",
    "direccionEntrega": "Av. Arequipa 1234, Miraflores, Lima",
    "telefonoContacto": "987654321",
    "subtotal": 67.00,
    "costoEnvio": 5.00,
    "total": 72.00,
    "notas": "Tocar el timbre 2 veces",
    "fechaPedido": "2024-11-27T14:30:00",
    "fechaEntregaEstimada": "2024-11-27T15:15:00",
    "fechaEntregaReal": null,
    "detalles": [...]
  }
  // ... todos los pedidos del sistema
]
```

### PUT /api/admin/pedidos/1/estado?estado=CONFIRMADO
**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 2,
  "usuarioNombre": "Juan Pérez",
  "repartidorId": null,
  "repartidorNombre": null,
  "estadoNombre": "CONFIRMADO",
  "direccionEntrega": "Av. Arequipa 1234, Miraflores, Lima",
  "telefonoContacto": "987654321",
  "subtotal": 67.00,
  "costoEnvio": 5.00,
  "total": 72.00,
  "notas": "Tocar el timbre 2 veces",
  "fechaPedido": "2024-11-27T14:30:00",
  "fechaEntregaEstimada": "2024-11-27T15:15:00",
  "fechaEntregaReal": null,
  "detalles": [...]
}
```

### PUT /api/admin/pedidos/1/repartidor?repartidorId=1
**Response (200 OK):**
```json
{
  "id": 1,
  "usuarioId": 2,
  "usuarioNombre": "Juan Pérez",
  "repartidorId": 1,
  "repartidorNombre": "Admin Sistema",
  "estadoNombre": "CONFIRMADO",
  "direccionEntrega": "Av. Arequipa 1234, Miraflores, Lima",
  "telefonoContacto": "987654321",
  "subtotal": 67.00,
  "costoEnvio": 5.00,
  "total": 72.00,
  "notas": "Tocar el timbre 2 veces",
  "fechaPedido": "2024-11-27T14:30:00",
  "fechaEntregaEstimada": "2024-11-27T15:15:00",
  "fechaEntregaReal": null,
  "detalles": [...]
}
```

---

## ❌ Ejemplos de Errores

### 401 Unauthorized
```json
{
  "timestamp": "2024-11-27T14:30:00",
  "status": 401,
  "error": "Unauthorized",
  "message": "Token inválido o expirado",
  "path": "/api/usuario/carrito"
}
```

### 403 Forbidden
```json
{
  "timestamp": "2024-11-27T14:30:00",
  "status": 403,
  "error": "Forbidden",
  "message": "No tienes permisos para acceder a este recurso",
  "path": "/api/admin/pizzas"
}
```

### 404 Not Found
```json
{
  "timestamp": "2024-11-27T14:30:00",
  "status": 404,
  "error": "Not Found",
  "message": "Pizza no encontrada con ID: 999",
  "path": "/api/pizzas/999"
}
```

### 400 Bad Request
```json
{
  "timestamp": "2024-11-27T14:30:00",
  "status": 400,
  "error": "Bad Request",
  "message": "El campo 'email' es requerido",
  "path": "/api/auth/register"
}
```

---

## 📊 Estados de Pedido

Los pedidos pueden tener los siguientes estados:

1. **PENDIENTE** - Pedido recién creado, esperando confirmación
2. **CONFIRMADO** - Pedido confirmado por el restaurante
3. **EN_PREPARACION** - Pizza en preparación
4. **LISTO** - Pedido listo para entrega
5. **EN_CAMINO** - Repartidor en camino
6. **ENTREGADO** - Pedido entregado al cliente
7. **CANCELADO** - Pedido cancelado

---

¡Usa estos ejemplos como referencia al probar la API! 🍕
