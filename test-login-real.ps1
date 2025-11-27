Write-Host "=== Probando Login con datos reales ===" -ForegroundColor Green

$body = @{
    email = "admin@pizzasreyna.com"
    password = "admin123"
} | ConvertTo-Json

Write-Host "`nEnviando petición..." -ForegroundColor Yellow
Write-Host "Body: $body"

try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" `
        -Method POST `
        -ContentType "application/json" `
        -Body $body
    
    Write-Host "`n✓ LOGIN EXITOSO!" -ForegroundColor Green
    Write-Host "Token: $($response.token.Substring(0, 50))..."
    Write-Host "Usuario: $($response.usuario.nombre) $($response.usuario.apellido)"
    Write-Host "Email: $($response.usuario.email)"
    Write-Host "Rol: $($response.usuario.rol)"
    
    # Guardar token
    $global:authToken = $response.token
    
    Write-Host "`n=== Probando endpoint autenticado ===" -ForegroundColor Green
    
    # Probar obtener carrito
    $headers = @{
        "Authorization" = "Bearer $($response.token)"
    }
    
    $carrito = Invoke-RestMethod -Uri "http://localhost:8080/api/usuario/carrito" `
        -Method GET `
        -Headers $headers
    
    Write-Host "✓ Carrito obtenido exitosamente!" -ForegroundColor Green
    Write-Host "Items en carrito: $($carrito.items.Count)"
    Write-Host "Total: $($carrito.total)"
    
} catch {
    Write-Host "`n✗ ERROR:" -ForegroundColor Red
    Write-Host $_.Exception.Message
    
    if ($_.ErrorDetails.Message) {
        Write-Host "Detalles: $($_.ErrorDetails.Message)"
    }
}

Write-Host "`n=== Probando Registro ===" -ForegroundColor Green

$registerBody = @{
    nombre = "Juan"
    apellido = "Pérez"
    email = "juan.perez$(Get-Random -Maximum 9999)@example.com"
    password = "password123"
    telefono = "987654321"
    direccion = "Av. Principal 123"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/register" `
        -Method POST `
        -ContentType "application/json" `
        -Body $registerBody
    
    Write-Host "✓ REGISTRO EXITOSO!" -ForegroundColor Green
    Write-Host "Usuario: $($response.usuario.nombre) $($response.usuario.apellido)"
    Write-Host "Email: $($response.usuario.email)"
    Write-Host "Token recibido: $($response.token.Substring(0, 30))..."
    
} catch {
    Write-Host "✗ ERROR en registro:" -ForegroundColor Red
    Write-Host $_.Exception.Message
}

Write-Host "`n=== Probando endpoint público (pizzas) ===" -ForegroundColor Green

try {
    $pizzas = Invoke-RestMethod -Uri "http://localhost:8080/api/pizzas" -Method GET
    Write-Host "✓ Pizzas obtenidas exitosamente!" -ForegroundColor Green
    Write-Host "Total de pizzas: $($pizzas.Count)"
    
    if ($pizzas.Count -gt 0) {
        Write-Host "`nPrimera pizza:"
        Write-Host "  - Nombre: $($pizzas[0].nombre)"
        Write-Host "  - Precio: S/. $($pizzas[0].precioBase)"
        Write-Host "  - Tamaño: $($pizzas[0].tamanio)"
    }
    
} catch {
    Write-Host "✗ ERROR obteniendo pizzas:" -ForegroundColor Red
    Write-Host $_.Exception.Message
}

Write-Host "`n=== TODAS LAS PRUEBAS COMPLETADAS ===" -ForegroundColor Green
