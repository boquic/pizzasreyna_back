# ⚡ Referencia Rápida - API Pizzas Reyna

## 🔑 Credenciales de Prueba

```
Admin:
Email: admin@pizzasreyna.com
Password: admin123
```

## 📍 Endpoints Principales

### Autenticación (No requiere token)
```
POST   /api/auth/login       - Iniciar sesión
POST   /api/auth/register    - Registrar usuario
```

### Pizzas (No requiere token)
```
GET    /api/pizzas           - Listar pizzas disponibles
GET    /api/pizzas/{id}      - Obtener pizza por ID
```

### Carrito (Requiere token)
```
GET    /api/usuario/carrito              - Ver carrito
POST   /api/usuario/carrito/agregar      - Agregar item
DELETE /api/usuario/carrito/limpiar      - Limpiar carrito
```

### Pedidos Usuario (Requiere token)
```
GET    /api/usuario/pedidos      - Historial de pedidos
POST   /api/usuario/pedidos      - Crear pedido
GET    /api/usuario/pedidos/{id} - Detalle de pedido
```

### Admin - Pizzas (Requiere token + rol ADMIN)
```
GET    /api/admin/pizzas         - Todas las pizzas
POST   /api/admin/pizzas         - Crear pizza
PUT    /api/admin/pizzas/{id}    - Actualizar pizza
DELETE /api/admin/pizzas/{id}    - Eliminar pizza
```

### Admin - Pedidos (Requiere token + rol ADMIN)
```
GET    /api/admin/pedidos                    - Todos los pedidos
PUT    /api/admin/pedidos/{id}/estado        - Actualizar estado
PUT    /api/admin/pedidos/{id}/repartidor    - Asignar repartidor
```

## 🍕 IDs de Pizzas en BD

| ID | Nombre | Precio |
|----|--------|--------|
| 1 | Margarita | S/. 25.00 |
| 2 | Pepperoni | S/. 30.00 |
| 3 | Hawaiana | S/. 32.00 |
| 4 | Cuatro Quesos | S/. 35.00 |
| 5 | Vegetariana | S/. 28.00 |
| 6 | Suprema | S/. 38.00 |
| 7 | BBQ Chicken | S/. 36.00 |
| 8 | Meat Lovers | S/. 42.00 |

## 🧀 IDs de Ingredientes Populares

| ID | Nombre | Precio |
|----|--------|--------|
| 1 | Mozzarella | S/. 2.00 |
| 2 | Pepperoni | S/. 3.50 |
| 4 | Champiñones | S/. 2.50 |
| 7 | Cebolla | S/. 1.50 |
| 9 | Piña | S/. 2.50 |
| 10 | Tocino | S/. 3.50 |
| 12 | Pollo | S/. 4.00 |
| 13 | Carne Molida | S/. 4.00 |

## 📦 IDs de Combos

| ID | Nombre | Precio |
|----|--------|--------|
| 1 | Combo Familiar | S/. 75.00 |
| 2 | Combo Pareja | S/. 35.00 |
| 3 | Combo Party | S/. 110.00 |

## 🔄 Estados de Pedido

```
PENDIENTE → CONFIRMADO → EN_PREPARACION → LISTO → EN_CAMINO → ENTREGADO
                                                              ↓
                                                          CANCELADO
```

## 📝 Ejemplos Rápidos de JSON

### Login
```json
{
  "email": "admin@pizzasreyna.com",
  "password": "admin123"
}
```

### Agregar al Carrito
```json
{
  "pizzaId": 2,
  "comboId": null,
  "cantidad": 2,
  "notas": "Sin cebolla",
  "ingredientesPersonalizadosIds": [10, 4]
}
```

### Crear Pedido
```json
{
  "direccionEntrega": "Av. Arequipa 1234, Lima",
  "telefonoContacto": "987654321",
  "notas": "Tocar el timbre",
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

### Crear Pizza (Admin)
```json
{
  "nombre": "Pizza Nueva",
  "descripcion": "Descripción de la pizza",
  "precioBase": 35.00,
  "tamanio": "GRANDE",
  "disponible": true,
  "imagenUrl": "https://example.com/pizza.jpg",
  "esPersonalizada": false,
  "ingredientes": [
    {"id": 1},
    {"id": 2}
  ]
}
```

## 🎯 Flujo de Prueba Rápido

1. **Login** → Guarda el token automáticamente
2. **Ver Pizzas** → GET /api/pizzas
3. **Agregar al Carrito** → POST /api/usuario/carrito/agregar
4. **Ver Carrito** → GET /api/usuario/carrito
5. **Crear Pedido** → POST /api/usuario/pedidos
6. **Ver Pedidos** → GET /api/usuario/pedidos

## 🔧 Configuración Postman

**Variables de Colección:**
- `base_url`: `http://localhost:8080`
- `auth_token`: Se guarda automáticamente al hacer login

**Headers Automáticos:**
- Authorization: `Bearer {{auth_token}}`
- Content-Type: `application/json`

## 💡 Tips

✅ El token se guarda automáticamente al hacer login
✅ Los endpoints de admin requieren login con admin@pizzasreyna.com
✅ Los IDs de pizzas van del 1 al 8
✅ Los IDs de ingredientes van del 1 al 15
✅ El costo de envío es S/. 5.00 por defecto

## 🚨 Errores Comunes

| Código | Causa | Solución |
|--------|-------|----------|
| 401 | No autenticado | Hacer login primero |
| 403 | Sin permisos | Usar cuenta admin |
| 404 | ID no existe | Verificar IDs válidos |
| 400 | JSON inválido | Revisar formato |

---

**URL Base:** `http://localhost:8080`
**Swagger UI:** `http://localhost:8080/swagger-ui.html`

¡Listo para probar! 🍕🚀
