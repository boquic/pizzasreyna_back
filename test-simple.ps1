Write-Host "=== Test Simple de Login ===" -ForegroundColor Green

$body = '{"email":"admin@pizzasreyna.com","password":"admin123"}'

Write-Host "Probando LOGIN..." -ForegroundColor Yellow
Write-Host "URL: http://localhost:8080/api/auth/login"
Write-Host "Body: $body"

try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" -Method POST -ContentType "application/json" -Body $body
    
    Write-Host "LOGIN EXITOSO!" -ForegroundColor Green
    Write-Host "Token: $($response.token.Substring(0, 50))..."
    Write-Host "Usuario: $($response.usuario.nombre) $($response.usuario.apellido)"
    Write-Host "Rol: $($response.usuario.rol)"
    
} catch {
    Write-Host "ERROR:" -ForegroundColor Red
    Write-Host $_.Exception.Message
}
