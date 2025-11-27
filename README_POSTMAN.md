# 📮 Documentación Postman - Pizzas Reyna API

## 📁 Archivos Creados

Este paquete incluye 4 archivos para facilitar las pruebas de la API:

### 1. `Pizzas_Reyna_Postman_Collection.json` ⭐
**Archivo principal de Postman**
- Colección completa con todos los endpoints
- 40+ requests organizados por categorías
- Scripts automáticos para guardar tokens
- Ejemplos con datos reales de tu BD
- Variables pre-configuradas

### 2. `GUIA_POSTMAN.md` 📖
**Guía paso a paso**
- Instrucciones de importación
- Configuración inicial
- Orden recomendado de pruebas
- Escenarios de prueba completos
- Solución de problemas

### 3. `EJEMPLOS_RESPUESTAS_API.md` 📋
**Respuestas esperadas**
- Ejemplos de respuestas exitosas
- Ejemplos de errores
- Cálculos de precios explicados
- Formato de datos completo

### 4. `REFERENCIA_RAPIDA_POSTMAN.md` ⚡
**Cheat sheet**
- Credenciales de prueba
- Lista de endpoints
- IDs de pizzas e ingredientes
- Ejemplos de JSON rápidos
- Tips y errores comunes

---

## 🚀 Inicio Rápido

### Paso 1: Importar en Postman
1. Abre Postman
2. Click en **Import**
3. Selecciona `Pizzas_Reyna_Postman_Collection.json`
4. ¡Listo!

### Paso 2: Hacer Login
1. Ve a: `🔐 Autenticación → Login - Usuario Admin`
2. Click en **Send**
3. El token se guarda automáticamente

### Paso 3: Probar Endpoints
Ahora puedes probar cualquier endpoint. Recomendamos empezar con:
```
🍕 Pizzas (Público) → Listar Todas las Pizzas Disponibles
```

---

## 📂 Estructura de la Colección

```
Pizzas Reyna API
│
├── 🔐 Autenticación (2 requests)
│   ├── Login - Usuario Admin
│   └── Registro - Nuevo Usuario
│
├── 🍕 Pizzas (Público) (6 requests)
│   ├── Listar Todas las Pizzas Disponibles
│   ├── Obtener Pizza - Margarita (ID: 1)
│   ├── Obtener Pizza - Pepperoni (ID: 2)
│   ├── Obtener Pizza - Hawaiana (ID: 3)
│   ├── Obtener Pizza - Suprema (ID: 6)
│   └── Obtener Pizza - Meat Lovers (ID: 8)
│
├── 🛒 Carrito de Compras (6 requests)
│   ├── Obtener Mi Carrito
│   ├── Agregar Pizza Pepperoni al Carrito
│   ├── Agregar Pizza Hawaiana al Carrito
│   ├── Agregar Pizza Suprema al Carrito
│   ├── Agregar Combo Familiar al Carrito
│   └── Limpiar Carrito
│
├── 📦 Pedidos de Usuario (5 requests)
│   ├── Crear Pedido - Pizza Simple
│   ├── Crear Pedido - Múltiples Pizzas
│   ├── Crear Pedido - Con Combo
│   ├── Obtener Mis Pedidos
│   └── Obtener Detalle de Pedido (ID: 1)
│
├── 👨‍💼 Admin - Pizzas (4 requests)
│   ├── Listar Todas las Pizzas (Admin)
│   ├── Crear Nueva Pizza
│   ├── Actualizar Pizza Existente (ID: 1)
│   └── Eliminar Pizza (ID: 9)
│
└── 👨‍💼 Admin - Pedidos (8 requests)
    ├── Listar Todos los Pedidos
    ├── Actualizar Estado - CONFIRMADO
    ├── Actualizar Estado - EN_PREPARACION
    ├── Actualizar Estado - LISTO
    ├── Actualizar Estado - EN_CAMINO
    ├── Actualizar Estado - ENTREGADO
    ├── Actualizar Estado - CANCELADO
    └── Asignar Repartidor al Pedido
```

---

## 🎯 Casos de Uso Principales

### 1. Cliente Hace un Pedido
```
1. Registro → Nuevo Usuario
2. Pizzas → Listar Todas las Pizzas
3. Carrito → Agregar Pizza Pepperoni
4. Carrito → Agregar Pizza Hawaiana
5. Carrito → Obtener Mi Carrito
6. Pedidos → Crear Pedido
7. Pedidos → Obtener Mis Pedidos
```

### 2. Admin Gestiona Pedidos
```
1. Autenticación → Login Admin
2. Admin Pedidos → Listar Todos los Pedidos
3. Admin Pedidos → Actualizar Estado - CONFIRMADO
4. Admin Pedidos → Actualizar Estado - EN_PREPARACION
5. Admin Pedidos → Asignar Repartidor
6. Admin Pedidos → Actualizar Estado - EN_CAMINO
7. Admin Pedidos → Actualizar Estado - ENTREGADO
```

### 3. Admin Gestiona Catálogo
```
1. Autenticación → Login Admin
2. Admin Pizzas → Listar Todas las Pizzas
3. Admin Pizzas → Crear Nueva Pizza
4. Admin Pizzas → Actualizar Pizza Existente
5. Pizzas → Listar Pizzas Disponibles (verificar)
```

---

## 🔑 Datos de Prueba

### Usuario Administrador
```
Email: admin@pizzasreyna.com
Password: admin123
ID: 1
Rol: ADMIN
```

### Pizzas Disponibles (IDs 1-8)
- **ID 1:** Margarita - S/. 25.00 (MEDIANA)
- **ID 2:** Pepperoni - S/. 30.00 (MEDIANA)
- **ID 3:** Hawaiana - S/. 32.00 (MEDIANA)
- **ID 4:** Cuatro Quesos - S/. 35.00 (MEDIANA)
- **ID 5:** Vegetariana - S/. 28.00 (MEDIANA)
- **ID 6:** Suprema - S/. 38.00 (GRANDE)
- **ID 7:** BBQ Chicken - S/. 36.00 (GRANDE)
- **ID 8:** Meat Lovers - S/. 42.00 (GRANDE)

### Ingredientes Más Usados
- **ID 1:** Mozzarella - S/. 2.00
- **ID 2:** Pepperoni - S/. 3.50
- **ID 4:** Champiñones - S/. 2.50
- **ID 9:** Piña - S/. 2.50
- **ID 10:** Tocino - S/. 3.50
- **ID 12:** Pollo - S/. 4.00

### Combos
- **ID 1:** Combo Familiar - S/. 75.00
- **ID 2:** Combo Pareja - S/. 35.00
- **ID 3:** Combo Party - S/. 110.00

---

## ⚙️ Características de la Colección

### ✅ Autenticación Automática
- El token se guarda automáticamente al hacer login
- No necesitas copiar/pegar tokens manualmente
- Todos los endpoints autenticados usan el token guardado

### ✅ Variables Pre-configuradas
- `base_url`: http://localhost:8080
- `auth_token`: Se actualiza automáticamente

### ✅ Ejemplos Reales
- Todos los IDs corresponden a datos reales en tu BD
- Precios calculados correctamente
- Ingredientes válidos

### ✅ Organización Clara
- 6 categorías principales
- Nombres descriptivos
- Documentación en cada request

### ✅ Scripts Incluidos
```javascript
// Script automático en Login
if (pm.response.code === 200) {
    var jsonData = pm.response.json();
    pm.collectionVariables.set('auth_token', jsonData.token);
    pm.environment.set('auth_token', jsonData.token);
}
```

---

## 🔧 Configuración Avanzada

### Cambiar URL Base
Si tu API corre en otro puerto:

1. Click derecho en la colección
2. **Edit** → **Variables**
3. Cambiar `base_url` a tu URL
4. Ejemplos:
   - `http://localhost:9090`
   - `http://192.168.1.100:8080`
   - `https://api.pizzasreyna.com`

### Crear Entornos
Para diferentes ambientes (dev, staging, prod):

1. Click en **Environments** (esquina superior derecha)
2. **Create Environment**
3. Agregar variables:
   ```
   base_url: http://localhost:8080
   auth_token: (vacío)
   ```
4. Crear entornos para cada ambiente

### Usar Collection Runner
Para ejecutar toda la colección:

1. Click derecho en la colección
2. **Run collection**
3. Seleccionar requests a ejecutar
4. **Run Pizzas Reyna API**

---

## 📊 Códigos de Respuesta

| Código | Significado | Cuándo Ocurre |
|--------|-------------|---------------|
| 200 | OK | Operación exitosa |
| 201 | Created | Recurso creado |
| 400 | Bad Request | JSON inválido o datos incorrectos |
| 401 | Unauthorized | No autenticado o token inválido |
| 403 | Forbidden | Sin permisos (no es admin) |
| 404 | Not Found | Recurso no existe |
| 500 | Server Error | Error interno del servidor |

---

## 💡 Tips y Mejores Prácticas

### 1. Orden de Pruebas
Siempre empieza con autenticación:
```
Login → Endpoints Públicos → Endpoints Autenticados → Admin
```

### 2. Verificar Respuestas
Revisa que las respuestas tengan:
- Status 200 (o el esperado)
- Estructura JSON correcta
- Datos coherentes

### 3. Usar IDs Válidos
- Pizzas: 1-8
- Ingredientes: 1-15
- Combos: 1-3
- Usuario Admin: 1

### 4. Probar Errores
También prueba casos de error:
- IDs inexistentes (999)
- Tokens inválidos
- Datos faltantes

### 5. Limpiar Datos
Después de probar:
- Limpia el carrito
- Puedes cancelar pedidos de prueba

---

## 🐛 Solución de Problemas

### "401 Unauthorized"
**Causa:** No estás autenticado o el token expiró
**Solución:** 
1. Hacer login nuevamente
2. Verificar que el token se guardó en las variables

### "403 Forbidden"
**Causa:** Intentas acceder a endpoint de admin sin ser admin
**Solución:** 
1. Hacer login con: admin@pizzasreyna.com / admin123

### "404 Not Found"
**Causa:** El ID del recurso no existe
**Solución:** 
1. Verificar IDs válidos en REFERENCIA_RAPIDA_POSTMAN.md
2. Usar IDs de pizzas 1-8, ingredientes 1-15

### "Connection Refused"
**Causa:** El backend no está corriendo
**Solución:** 
1. Iniciar el backend: `mvnw spring-boot:run`
2. Verificar que corra en puerto 8080

### "Token no se guarda"
**Causa:** Script no se ejecutó
**Solución:** 
1. Verificar que los scripts estén habilitados en Postman
2. Settings → General → Allow reading files outside working directory

---

## 📚 Recursos Adicionales

### Documentación Swagger
```
http://localhost:8080/swagger-ui.html
```

### Archivos de Referencia
- `GUIA_POSTMAN.md` - Guía completa paso a paso
- `EJEMPLOS_RESPUESTAS_API.md` - Respuestas esperadas
- `REFERENCIA_RAPIDA_POSTMAN.md` - Cheat sheet rápido
- `API_DOCUMENTATION_FLUTTER.md` - Documentación para Flutter

### Scripts PowerShell de Prueba
Tu proyecto incluye scripts de prueba:
- `test-login.ps1`
- `test-api.ps1`
- `test-jwt-auth.ps1`

---

## 🎓 Aprendizaje

### Para Principiantes
1. Empieza con la `GUIA_POSTMAN.md`
2. Sigue el orden recomendado
3. Lee las descripciones de cada request
4. Revisa las respuestas en `EJEMPLOS_RESPUESTAS_API.md`

### Para Usuarios Avanzados
1. Usa `REFERENCIA_RAPIDA_POSTMAN.md` como cheat sheet
2. Crea tus propios entornos
3. Personaliza los scripts
4. Usa Collection Runner para pruebas automatizadas

---

## 📞 Soporte

Si tienes problemas:
1. Revisa la sección "Solución de Problemas"
2. Consulta `GUIA_POSTMAN.md`
3. Verifica los logs del backend
4. Revisa Swagger UI para documentación interactiva

---

## ✨ Características Destacadas

✅ **40+ Requests** organizados y documentados
✅ **Autenticación automática** con scripts
✅ **Datos reales** de tu base de datos
✅ **Ejemplos completos** para cada endpoint
✅ **Documentación detallada** en 4 archivos
✅ **Casos de uso** reales y prácticos
✅ **Solución de problemas** incluida

---

## 🚀 ¡Comienza Ahora!

1. Importa `Pizzas_Reyna_Postman_Collection.json` en Postman
2. Haz login con admin@pizzasreyna.com / admin123
3. Prueba el endpoint: `🍕 Pizzas → Listar Todas las Pizzas`
4. ¡Explora el resto de la colección!

---

**¡Disfruta probando la API de Pizzas Reyna!** 🍕🎉
