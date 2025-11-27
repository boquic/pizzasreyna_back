# Script para reconstruir completamente el backend en Docker
# Útil después de cambios en el código

$ErrorActionPreference = "Stop"

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "🔨 Reconstruyendo Backend Docker" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Verificar que Docker está corriendo
try {
    docker info | Out-Null
} catch {
    Write-Host "❌ Docker no está corriendo" -ForegroundColor Red
    Write-Host "   Por favor, inicia Docker Desktop" -ForegroundColor Yellow
    exit 1
}

Write-Host "1️⃣  Deteniendo servicios actuales..." -ForegroundColor Yellow
docker-compose down

Write-Host ""
Write-Host "2️⃣  Limpiando imágenes antiguas..." -ForegroundColor Yellow
docker-compose rm -f backend

Write-Host ""
Write-Host "3️⃣  Compilando proyecto localmente..." -ForegroundColor Yellow
./mvnw clean package -DskipTests

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "❌ Error en la compilación" -ForegroundColor Red
    Write-Host "   Revisa los errores arriba" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "4️⃣  Construyendo imagen Docker..." -ForegroundColor Yellow
docker-compose build --no-cache backend

Write-Host ""
Write-Host "5️⃣  Iniciando servicios..." -ForegroundColor Yellow
docker-compose up -d

Write-Host ""
Write-Host "6️⃣  Esperando que el backend inicie..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "7️⃣  Verificando logs..." -ForegroundColor Yellow
docker-compose logs --tail=50 backend

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "✅ Reconstrucción Completa" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Verificar estado
Write-Host "📊 Estado de los servicios:" -ForegroundColor Cyan
docker-compose ps

Write-Host ""
Write-Host "🔗 URLs disponibles:" -ForegroundColor Cyan
Write-Host "   Backend:    http://localhost:8080" -ForegroundColor White
Write-Host "   Swagger:    http://localhost:8080/swagger-ui.html" -ForegroundColor White
Write-Host "   PostgreSQL: localhost:5432" -ForegroundColor White

Write-Host ""
Write-Host "📝 Comandos útiles:" -ForegroundColor Cyan
Write-Host "   Ver logs:        docker-compose logs -f backend" -ForegroundColor Gray
Write-Host "   Probar API:      .\test-carrito.ps1" -ForegroundColor Gray
Write-Host "   Detener:         docker-compose down" -ForegroundColor Gray

Write-Host ""
Write-Host "🧪 Ejecutando pruebas..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# Intentar probar el endpoint de pizzas
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/pizzas" -TimeoutSec 10 -ErrorAction Stop
    Write-Host "✅ Backend respondiendo correctamente" -ForegroundColor Green
    Write-Host "   Pizzas disponibles: $($response.Count)" -ForegroundColor Gray
} catch {
    Write-Host "⚠️  Backend aún no está listo o hay un error" -ForegroundColor Yellow
    Write-Host "   Espera unos segundos y ejecuta: .\test-carrito.ps1" -ForegroundColor Gray
    Write-Host "   O revisa los logs: docker-compose logs -f backend" -ForegroundColor Gray
}

Write-Host ""
