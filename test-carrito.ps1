# Script de prueba para el carrito con autenticación JWT
# Asegúrate de que el backend esté corriendo en http://localhost:8080

$baseUrl = "http://localhost:8080"

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "🍕 Test de Carrito - Pizzas Reyna" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Paso 1: Login
Write-Host "📝 Paso 1: Login..." -ForegroundColor Yellow
$loginBody = @{
    email = "admin@pizzasreyna.com"
    password = "admin123"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "$baseUrl/api/auth/login" `
        -Method Post `
        -ContentType "application/json" `
        -Body $loginBody
    
    $token = $loginResponse.token
    Write-Host "✅ Login exitoso" -ForegroundColor Green
    Write-Host "   Usuario: $($loginResponse.usuario.nombre) $($loginResponse.usuario.apellido)" -ForegroundColor Gray
    Write-Host "   Email: $($loginResponse.usuario.email)" -ForegroundColor Gray
    Write-Host "   Rol: $($loginResponse.usuario.rol)" -ForegroundColor Gray
    Write-Host "   Token: $($token.Substring(0, 30))..." -ForegroundColor Gray
    Write-Host ""
} catch {
    Write-Host "❌ Error en login: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Paso 2: Obtener carrito vacío
Write-Host "📝 Paso 2: Obtener carrito..." -ForegroundColor Yellow
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

try {
    $carrito = Invoke-RestMethod -Uri "$baseUrl/api/usuario/carrito" `
        -Method Get `
        -Headers $headers
    
    Write-Host "✅ Carrito obtenido" -ForegroundColor Green
    Write-Host "   Items: $($carrito.items.Count)" -ForegroundColor Gray
    Write-Host "   Total: S/. $($carrito.total)" -ForegroundColor Gray
    Write-Host ""
} catch {
    Write-Host "❌ Error al obtener carrito: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        $statusCode = $_.Exception.Response.StatusCode.value__
        Write-Host "   Status Code: $statusCode" -ForegroundColor Red
        
        if ($statusCode -eq 403) {
            Write-Host "   🔴 ERROR 403 FORBIDDEN - El token JWT no está siendo procesado correctamente" -ForegroundColor Red
            Write-Host "   Verifica los logs del backend para más detalles" -ForegroundColor Yellow
        }
    }
    exit 1
}

# Paso 3: Agregar pizza al carrito
Write-Host "📝 Paso 3: Agregar pizza Pepperoni al carrito..." -ForegroundColor Yellow
$agregarBody = @{
    pizzaId = 2
    comboId = $null
    cantidad = 2
    notas = "Sin cebolla por favor"
    ingredientesPersonalizadosIds = @(10, 4)
} | ConvertTo-Json

try {
    $carritoActualizado = Invoke-RestMethod -Uri "$baseUrl/api/usuario/carrito/agregar" `
        -Method Post `
        -Headers $headers `
        -Body $agregarBody
    
    Write-Host "✅ Pizza agregada al carrito" -ForegroundColor Green
    Write-Host "   Items: $($carritoActualizado.items.Count)" -ForegroundColor Gray
    Write-Host "   Total: S/. $($carritoActualizado.total)" -ForegroundColor Gray
    
    foreach ($item in $carritoActualizado.items) {
        Write-Host "   - $($item.pizzaNombre) x$($item.cantidad) = S/. $($item.subtotal)" -ForegroundColor Gray
        if ($item.ingredientesPersonalizados) {
            foreach ($ing in $item.ingredientesPersonalizados) {
                Write-Host "     + $($ing.nombre) (+S/. $($ing.precioAdicional))" -ForegroundColor DarkGray
            }
        }
    }
    Write-Host ""
} catch {
    Write-Host "❌ Error al agregar al carrito: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response) {
        $statusCode = $_.Exception.Response.StatusCode.value__
        Write-Host "   Status Code: $statusCode" -ForegroundColor Red
        
        if ($statusCode -eq 403) {
            Write-Host "   🔴 ERROR 403 FORBIDDEN - El token JWT no está siendo procesado correctamente" -ForegroundColor Red
            Write-Host "   Verifica los logs del backend para más detalles" -ForegroundColor Yellow
        }
    }
    exit 1
}

# Paso 4: Limpiar carrito
Write-Host "📝 Paso 4: Limpiar carrito..." -ForegroundColor Yellow
try {
    Invoke-RestMethod -Uri "$baseUrl/api/usuario/carrito/limpiar" `
        -Method Delete `
        -Headers $headers
    
    Write-Host "✅ Carrito limpiado" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "❌ Error al limpiar carrito: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "✅ Todas las pruebas pasaron!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan
