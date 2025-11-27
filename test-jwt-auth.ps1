# Test JWT Authentication Fix
# This script tests the JWT authentication flow with admin users

Write-Host "=== Testing JWT Authentication ===" -ForegroundColor Cyan

# Test 1: Login with admin user
Write-Host "`n1. Testing login with admin1@pizzasreyna.com..." -ForegroundColor Yellow
try {
    $loginResponse = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" `
        -Method POST `
        -ContentType "application/json" `
        -Body '{"email":"admin1@pizzasreyna.com","password":"admin123"}'

    if ($loginResponse.token) {
        Write-Host "✓ Login successful! Token received." -ForegroundColor Green
        $token = $loginResponse.token
        Write-Host "Token: $($token.Substring(0, 50))..." -ForegroundColor Gray
    } else {
        Write-Host "✗ Login failed!" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "✗ Login failed! Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Test 2: Access protected endpoint with token
Write-Host "`n2. Testing protected endpoint /api/usuario/carrito..." -ForegroundColor Yellow
try {
    $carritoResponse = Invoke-RestMethod -Uri "http://localhost:8080/api/usuario/carrito" `
        -Method GET `
        -Headers @{
            "Authorization" = "Bearer $token"
            "Content-Type" = "application/json"
        }
    Write-Host "✓ Protected endpoint accessible! Authentication working." -ForegroundColor Green
    Write-Host "Carrito response: $($carritoResponse | ConvertTo-Json -Depth 2)" -ForegroundColor Gray
} catch {
    Write-Host "✗ Failed to access protected endpoint!" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Test 3: Access protected endpoint without token (should fail)
Write-Host "`n3. Testing protected endpoint without token (should fail)..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/usuario/carrito" `
        -Method GET `
        -ContentType "application/json"
    Write-Host "✗ Endpoint accessible without token! Security issue!" -ForegroundColor Red
    exit 1
} catch {
    Write-Host "✓ Correctly rejected unauthorized request" -ForegroundColor Green
}

# Test 4: Login with admin2
Write-Host "`n4. Testing login with admin2@pizzasreyna.com..." -ForegroundColor Yellow
try {
    $admin2Response = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" `
        -Method POST `
        -ContentType "application/json" `
        -Body '{"email":"admin2@pizzasreyna.com","password":"admin123"}'

    if ($admin2Response.token) {
        Write-Host "✓ Admin2 login successful!" -ForegroundColor Green
        Write-Host "User: $($admin2Response.usuario.nombre) $($admin2Response.usuario.apellido)" -ForegroundColor Gray
        Write-Host "Role: $($admin2Response.usuario.rol.nombre)" -ForegroundColor Gray
    } else {
        Write-Host "✗ Admin2 login failed!" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "✗ Admin2 login failed! Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "`n=== All Tests Passed! ===" -ForegroundColor Green
Write-Host "JWT Authentication is working correctly." -ForegroundColor Green
