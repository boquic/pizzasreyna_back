Write-Host "Probando login..." -ForegroundColor Yellow

$body = @{
    email = "admin@pizzasreyna.com"
    password = "admin123"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" -Method POST -ContentType "application/json" -Body $body
    Write-Host "Login exitoso!" -ForegroundColor Green
    Write-Host "Token: $($response.token.Substring(0, 50))..."
    Write-Host "Usuario: $($response.usuario.nombre) $($response.usuario.apellido)"
    Write-Host "Rol: $($response.usuario.rol)"
} catch {
    Write-Host "Error en login:" -ForegroundColor Red
    Write-Host $_.Exception.Message
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $reader.BaseStream.Position = 0
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response: $responseBody"
    }
}
