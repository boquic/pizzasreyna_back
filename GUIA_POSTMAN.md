# 📮 Guía de Uso - Colección Postman de Pizzas Reyna

## 🚀 Importar la Colección

1. Abre Postman
2. Click en **Import** (esquina superior izquierda)
3. Selecciona el archivo `Pizzas_Reyna_Postman_Collection.json`
4. La colección aparecerá en tu sidebar con el nombre "Pizzas Reyna API - Colección Completa"

## ⚙️ Configuración Inicial

### Variables de Entorno

La colección usa dos variables principales:

- **`base_url`**: `http://localhost:8080` (URL base de tu API)
- **`auth_token`**: Se guarda automáticamente al hacer login

### Configurar Variables (Opcional)

Si tu API corre en otro puerto o servidor:

1. Click derecho en la colección → **Edit**
2. Ve a la pestaña **Variables**
3. Modifica `base_url` según tu configuración

## 📋 Orden Recomendado para Probar

### 1️⃣ Autenticación

#### Opción A: Login como Admin
```
🔐 Autenticación → Login - Usuario Admin
```
**Credenciales:**
- Email: `admin@pizzasreyna.com`
- Password: `admin123`

✅ **El token se guarda automáticamente** para las siguientes peticiones

#### Opción B: Registrar Nuevo Usuario
```
🔐 Autenticación → Registro - Nuevo Usuario
```
Puedes modificar los datos del usuario en el body de la petición.

---

### 2️⃣ Explorar el Catálogo (No requiere autenticación)

```
🍕 Pizzas (Público) → Listar Todas las Pizzas Disponibles
```

Verás las 8 pizzas predefinidas:
1. Margarita (ID: 1) - S/. 25.00
2. Pepperoni (ID: 2) - S/. 30.00
3. Hawaiana (ID: 3) - S/. 32.00
4. Cuatro Quesos (ID: 4) - S/. 35.00
5. Vegetariana (ID: 5) - S/. 28.00
6. Suprema (ID: 6) - S/. 38.00
7. BBQ Chicken (ID: 7) - S/. 36.00
8. Meat Lovers (ID: 8) - S/. 42.00

**Probar detalles de pizzas específicas:**
```
🍕 Pizzas (Público) → Obtener Pizza - Pepperoni (ID: 2)
🍕 Pizzas (Público) → Obtener Pizza - Hawaiana (ID: 3)
```

---

### 3️⃣ Gestionar el Carrito (Requiere autenticación)

#### Ver carrito vacío
```
🛒 Carrito de Compras → Obtener Mi Carrito
```

#### Agregar pizzas al carrito
```
🛒 Carrito de Compras → Agregar Pizza Pepperoni al Carrito
```
Este ejemplo agrega 2 pizzas Pepperoni con ingredientes extra:
- Tocino (ID: 10) - +S/. 3.50
- Champiñones (ID: 4) - +S/. 2.50

**Otros ejemplos para probar:**
```
🛒 Carrito de Compras → Agregar Pizza Hawaiana al Carrito
🛒 Carrito de Compras → Agregar Pizza Suprema al Carrito
🛒 Carrito de Compras → Agregar Combo Familiar al Carrito
```

#### Ver carrito actualizado
```
🛒 Carrito de Compras → Obtener Mi Carrito
```

#### Limpiar carrito
```
🛒 Carrito de Compras → Limpiar Carrito
```

---

### 4️⃣ Crear Pedidos (Requiere autenticación)

#### Pedido Simple
```
📦 Pedidos de Usuario → Crear Pedido - Pizza Simple
```
Crea un pedido con 2 pizzas Pepperoni con tocino extra.

#### Pedido con Múltiples Pizzas
```
📦 Pedidos de Usuario → Crear Pedido - Múltiples Pizzas
```
Crea un pedido con 3 pizzas diferentes:
- 1 Hawaiana con piña extra
- 1 Suprema
- 1 Meat Lovers con tocino y carne extra

#### Pedido con Combo
```
📦 Pedidos de Usuario → Crear Pedido - Con Combo
```
Crea un pedido con el Combo Familiar + 1 pizza Margarita adicional.

#### Ver historial de pedidos
```
📦 Pedidos de Usuario → Obtener Mis Pedidos
```

#### Ver detalle de un pedido
```
📦 Pedidos de Usuario → Obtener Detalle de Pedido (ID: 1)
```
⚠️ Usa el ID del pedido que acabas de crear.

---

### 5️⃣ Administración de Pizzas (Requiere rol ADMIN)

⚠️ **Importante:** Debes estar logueado como admin para usar estos endpoints.

#### Listar todas las pizzas (incluidas no disponibles)
```
👨‍💼 Admin - Pizzas → Listar Todas las Pizzas (Admin)
```

#### Crear nueva pizza
```
👨‍💼 Admin - Pizzas → Crear Nueva Pizza
```
Crea una "Pizza BBQ Especial" con ingredientes:
- Mozzarella (ID: 1)
- Pollo (ID: 12)
- Tocino (ID: 10)
- Cebolla (ID: 7)

#### Actualizar pizza existente
```
👨‍💼 Admin - Pizzas → Actualizar Pizza Existente (ID: 1)
```
Actualiza la Margarita a "Margarita Premium" con nuevo precio.

#### Eliminar pizza
```
👨‍💼 Admin - Pizzas → Eliminar Pizza (ID: 9)
```
⚠️ Usa el ID de la pizza que acabas de crear.

---

### 6️⃣ Administración de Pedidos (Requiere rol ADMIN)

#### Listar todos los pedidos del sistema
```
👨‍💼 Admin - Pedidos → Listar Todos los Pedidos
```

#### Actualizar estado del pedido (flujo completo)

Prueba el flujo completo de un pedido:

1. **CONFIRMADO**
```
👨‍💼 Admin - Pedidos → Actualizar Estado - CONFIRMADO
```

2. **EN_PREPARACION**
```
👨‍💼 Admin - Pedidos → Actualizar Estado - EN_PREPARACION
```

3. **LISTO**
```
👨‍💼 Admin - Pedidos → Actualizar Estado - LISTO
```

4. **EN_CAMINO**
```
👨‍💼 Admin - Pedidos → Actualizar Estado - EN_CAMINO
```

5. **ENTREGADO**
```
👨‍💼 Admin - Pedidos → Actualizar Estado - ENTREGADO
```

**O cancelar:**
```
👨‍💼 Admin - Pedidos → Actualizar Estado - CANCELADO
```

#### Asignar repartidor
```
👨‍💼 Admin - Pedidos → Asignar Repartidor al Pedido
```
⚠️ Usa el ID del usuario admin (1) como ejemplo de repartidor.

---

## 📊 Datos de Ejemplo en la Base de Datos

### Pizzas (IDs 1-8)
| ID | Nombre | Precio | Tamaño |
|----|--------|--------|--------|
| 1 | Margarita | S/. 25.00 | MEDIANA |
| 2 | Pepperoni | S/. 30.00 | MEDIANA |
| 3 | Hawaiana | S/. 32.00 | MEDIANA |
| 4 | Cuatro Quesos | S/. 35.00 | MEDIANA |
| 5 | Vegetariana | S/. 28.00 | MEDIANA |
| 6 | Suprema | S/. 38.00 | GRANDE |
| 7 | BBQ Chicken | S/. 36.00 | GRANDE |
| 8 | Meat Lovers | S/. 42.00 | GRANDE |

### Ingredientes (IDs 1-15)
| ID | Nombre | Precio Adicional |
|----|--------|------------------|
| 1 | Queso Mozzarella | S/. 2.00 |
| 2 | Pepperoni | S/. 3.50 |
| 3 | Jamón | S/. 3.00 |
| 4 | Champiñones | S/. 2.50 |
| 5 | Aceitunas | S/. 2.00 |
| 6 | Pimientos | S/. 2.00 |
| 7 | Cebolla | S/. 1.50 |
| 8 | Tomate | S/. 1.50 |
| 9 | Piña | S/. 2.50 |
| 10 | Tocino | S/. 3.50 |
| 11 | Salchicha | S/. 3.00 |
| 12 | Pollo | S/. 4.00 |
| 13 | Carne Molida | S/. 4.00 |
| 14 | Albahaca | S/. 1.00 |
| 15 | Orégano | S/. 0.50 |

### Combos (IDs 1-3)
| ID | Nombre | Precio | Descuento |
|----|--------|--------|-----------|
| 1 | Combo Familiar | S/. 75.00 | S/. 10.00 |
| 2 | Combo Pareja | S/. 35.00 | S/. 5.00 |
| 3 | Combo Party | S/. 110.00 | S/. 15.00 |

### Usuario Admin
- **Email:** `admin@pizzasreyna.com`
- **Password:** `admin123`
- **ID:** 1
- **Rol:** ADMIN

---

## 🎯 Escenarios de Prueba Recomendados

### Escenario 1: Cliente Nuevo
1. Registrar nuevo usuario
2. Ver catálogo de pizzas
3. Agregar 2-3 pizzas al carrito
4. Ver carrito
5. Crear pedido
6. Ver historial de pedidos

### Escenario 2: Administrador
1. Login como admin
2. Ver todos los pedidos
3. Actualizar estado de un pedido (PENDIENTE → CONFIRMADO → EN_PREPARACION → LISTO → EN_CAMINO → ENTREGADO)
4. Crear nueva pizza
5. Actualizar pizza existente
6. Ver todas las pizzas

### Escenario 3: Personalización de Pizza
1. Login
2. Agregar pizza con ingredientes personalizados
3. Ejemplo: Pepperoni + Tocino + Champiñones + Aceitunas
4. Ver carrito con precios calculados
5. Crear pedido

### Escenario 4: Pedido con Combo
1. Login
2. Agregar Combo Familiar al carrito
3. Agregar pizzas individuales adicionales
4. Crear pedido
5. Verificar descuento aplicado

---

## 🔧 Solución de Problemas

### Error 401 Unauthorized
- Verifica que hayas hecho login primero
- El token se guarda automáticamente, pero si no funciona:
  1. Ve a la colección → Edit → Variables
  2. Verifica que `auth_token` tenga un valor
  3. Si está vacío, haz login nuevamente

### Error 403 Forbidden
- Estás intentando acceder a un endpoint de admin sin el rol ADMIN
- Haz login con: `admin@pizzasreyna.com` / `admin123`

### Error 404 Not Found
- Verifica que el ID del recurso exista en la BD
- Usa los IDs de ejemplo proporcionados en esta guía

### Error 400 Bad Request
- Revisa el formato del JSON en el body
- Verifica que los IDs de pizzas/ingredientes/combos existan
- Asegúrate de que los campos requeridos estén presentes

### La API no responde
- Verifica que el backend esté corriendo: `http://localhost:8080`
- Revisa la consola del backend para ver errores
- Verifica que la base de datos esté activa

---

## 💡 Tips Útiles

### 1. Scripts Automáticos
La colección incluye scripts que:
- Guardan automáticamente el token al hacer login
- No necesitas copiar/pegar el token manualmente

### 2. Variables de Colección
Puedes crear variables adicionales para:
- IDs de pedidos recién creados
- IDs de pizzas personalizadas
- Tokens de diferentes usuarios

### 3. Entornos de Postman
Crea diferentes entornos para:
- **Local**: `http://localhost:8080`
- **Desarrollo**: `http://dev.pizzasreyna.com`
- **Producción**: `https://api.pizzasreyna.com`

### 4. Orden de Ejecución
Puedes ejecutar toda la colección en orden usando:
- Collection Runner
- Newman (CLI de Postman)

---

## 📞 Soporte

Si encuentras algún problema:
1. Verifica que el backend esté corriendo
2. Revisa los logs del servidor
3. Consulta la documentación Swagger: `http://localhost:8080/swagger-ui.html`

---

¡Feliz testing! 🍕🚀
