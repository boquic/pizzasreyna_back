# Script de prueba para los endpoints de la API

Write-Host "=== Probando API de Pizzas Reyna ===" -ForegroundColor Green

# Test 1: Obtener pizzas (público)
Write-Host "`n1. Probando GET /api/pizzas (público)..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/api/pizzas" -Method GET
    Write-Host "✓ Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "Pizzas encontradas: $(($response.Content | ConvertFrom-Json).Count)"
} catch {
    Write-Host "✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 2: Login
Write-Host "`n2. Probando POST /api/auth/login..." -ForegroundColor Yellow
try {
    $loginBody = @{
        email = "admin@pizzasreyna.com"
        password = "admin123"
    } | ConvertTo-Json

    $response = Invoke-WebRequest -Uri "http://localhost:8080/api/auth/login" `
        -Method POST `
        -ContentType "application/json" `
        -Body $loginBody

    Write-Host "✓ Status: $($response.StatusCode)" -ForegroundColor Green
    $authData = $response.Content | ConvertFrom-Json
    Write-Host "Token recibido: $($authData.token.Substring(0, 20))..."
    Write-Host "Usuario: $($authData.usuario.nombre) $($authData.usuario.apellido)"
    Write-Host "Rol: $($authData.usuario.rol)"
    
    # Guardar token para siguientes pruebas
    $global:token = $authData.token
} catch {
    Write-Host "✗ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Response: $($_.Exception.Response)" -ForegroundColor Red
}

# Test 3: Registro
Write-Host "`n3. Probando POST /api/auth/register..." -ForegroundColor Yellow
try {
    $registerBody = @{
        nombre = "Test"
        apellido = "User"
        email = "test$(Get-Random)@example.com"
        password = "password123"
        telefono = "987654321"
        direccion = "Test Address 123"
    } | ConvertTo-Json

    $response = Invoke-WebRequest -Uri "http://localhost:8080/api/auth/register" `
        -Method POST `
        -ContentType "application/json" `
        -Body $registerBody

    Write-Host "✓ Status: $($response.StatusCode)" -ForegroundColor Green
    $authData = $response.Content | ConvertFrom-Json
    Write-Host "Usuario registrado: $($authData.usuario.email)"
} catch {
    Write-Host "✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 4: Obtener carrito (requiere autenticación)
if ($global:token) {
    Write-Host "`n4. Probando GET /api/usuario/carrito (autenticado)..." -ForegroundColor Yellow
    try {
        $headers = @{
            "Authorization" = "Bearer $global:token"
        }
        
        $response = Invoke-WebRequest -Uri "http://localhost:8080/api/usuario/carrito" `
            -Method GET `
            -Headers $headers

        Write-Host "✓ Status: $($response.StatusCode)" -ForegroundColor Green
        $carrito = $response.Content | ConvertFrom-Json
        Write-Host "Items en carrito: $($carrito.items.Count)"
        Write-Host "Total: $($carrito.total)"
    } catch {
        Write-Host "✗ Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n=== Pruebas completadas ===" -ForegroundColor Green
