# Script para iniciar Pizzas Reyna Backend con Docker
# Este script facilita el inicio del proyecto completo

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("full", "db-only", "rebuild", "stop", "logs", "status")]
    [string]$Action = "full"
)

$ErrorActionPreference = "Stop"

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "🍕 Pizzas Reyna - Docker Manager" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

function Show-Help {
    Write-Host "Uso: .\start-docker.ps1 [accion]" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Acciones disponibles:" -ForegroundColor White
    Write-Host "  full      - Iniciar backend + PostgreSQL (por defecto)" -ForegroundColor Gray
    Write-Host "  db-only   - Iniciar solo PostgreSQL (para desarrollo local)" -ForegroundColor Gray
    Write-Host "  rebuild   - Reconstruir e iniciar todo" -ForegroundColor Gray
    Write-Host "  stop      - Detener todos los servicios" -ForegroundColor Gray
    Write-Host "  logs      - Ver logs en tiempo real" -ForegroundColor Gray
    Write-Host "  status    - Ver estado de los servicios" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Ejemplos:" -ForegroundColor White
    Write-Host "  .\start-docker.ps1              # Iniciar todo" -ForegroundColor Gray
    Write-Host "  .\start-docker.ps1 db-only      # Solo PostgreSQL" -ForegroundColor Gray
    Write-Host "  .\start-docker.ps1 rebuild      # Reconstruir todo" -ForegroundColor Gray
    Write-Host ""
}

function Test-DockerRunning {
    try {
        docker info | Out-Null
        return $true
    } catch {
        Write-Host "❌ Docker no está corriendo" -ForegroundColor Red
        Write-Host "   Por favor, inicia Docker Desktop" -ForegroundColor Yellow
        return $false
    }
}

function Start-Full {
    Write-Host "🚀 Iniciando Backend + PostgreSQL..." -ForegroundColor Yellow
    Write-Host ""
    
    docker-compose up -d
    
    Write-Host ""
    Write-Host "✅ Servicios iniciados" -ForegroundColor Green
    Write-Host ""
    Write-Host "📊 Estado de los servicios:" -ForegroundColor Cyan
    docker-compose ps
    Write-Host ""
    Write-Host "🔗 URLs disponibles:" -ForegroundColor Cyan
    Write-Host "   Backend:    http://localhost:8080" -ForegroundColor White
    Write-Host "   Swagger:    http://localhost:8080/swagger-ui.html" -ForegroundColor White
    Write-Host "   PostgreSQL: localhost:5432" -ForegroundColor White
    Write-Host ""
    Write-Host "📝 Ver logs: .\start-docker.ps1 logs" -ForegroundColor Gray
}

function Start-DbOnly {
    Write-Host "🗄️  Iniciando solo PostgreSQL..." -ForegroundColor Yellow
    Write-Host ""
    
    docker-compose -f docker-compose.dev.yml up -d
    
    Write-Host ""
    Write-Host "✅ PostgreSQL iniciado" -ForegroundColor Green
    Write-Host ""
    Write-Host "📊 Estado:" -ForegroundColor Cyan
    docker-compose -f docker-compose.dev.yml ps
    Write-Host ""
    Write-Host "🔗 Conexión:" -ForegroundColor Cyan
    Write-Host "   Host:     localhost" -ForegroundColor White
    Write-Host "   Port:     5432" -ForegroundColor White
    Write-Host "   Database: pizzasreyna" -ForegroundColor White
    Write-Host "   User:     postgres" -ForegroundColor White
    Write-Host "   Password: postgres" -ForegroundColor White
    Write-Host ""
    Write-Host "💻 Ahora puedes iniciar el backend localmente:" -ForegroundColor Yellow
    Write-Host "   .\mvnw spring-boot:run" -ForegroundColor Gray
}

function Start-Rebuild {
    Write-Host "🔨 Reconstruyendo e iniciando servicios..." -ForegroundColor Yellow
    Write-Host ""
    
    Write-Host "1️⃣  Deteniendo servicios actuales..." -ForegroundColor Cyan
    docker-compose down
    
    Write-Host ""
    Write-Host "2️⃣  Reconstruyendo imágenes..." -ForegroundColor Cyan
    docker-compose build --no-cache
    
    Write-Host ""
    Write-Host "3️⃣  Iniciando servicios..." -ForegroundColor Cyan
    docker-compose up -d
    
    Write-Host ""
    Write-Host "✅ Servicios reconstruidos e iniciados" -ForegroundColor Green
    Write-Host ""
    docker-compose ps
}

function Stop-Services {
    Write-Host "🛑 Deteniendo servicios..." -ForegroundColor Yellow
    Write-Host ""
    
    docker-compose down
    
    Write-Host ""
    Write-Host "✅ Servicios detenidos" -ForegroundColor Green
    Write-Host ""
    Write-Host "💡 Para eliminar también los datos:" -ForegroundColor Gray
    Write-Host "   docker-compose down -v" -ForegroundColor DarkGray
}

function Show-Logs {
    Write-Host "📋 Mostrando logs (Ctrl+C para salir)..." -ForegroundColor Yellow
    Write-Host ""
    
    docker-compose logs -f
}

function Show-Status {
    Write-Host "📊 Estado de los servicios:" -ForegroundColor Cyan
    Write-Host ""
    
    docker-compose ps
    
    Write-Host ""
    Write-Host "🔍 Verificando conectividad..." -ForegroundColor Cyan
    
    # Verificar PostgreSQL
    $pgStatus = docker-compose exec -T postgres pg_isready -U postgres 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   PostgreSQL: ✅ Funcionando" -ForegroundColor Green
    } else {
        Write-Host "   PostgreSQL: ❌ No disponible" -ForegroundColor Red
    }
    
    # Verificar Backend
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8080/api/pizzas" -TimeoutSec 5 -ErrorAction SilentlyContinue
        if ($response.StatusCode -eq 200) {
            Write-Host "   Backend:    ✅ Funcionando" -ForegroundColor Green
        }
    } catch {
        Write-Host "   Backend:    ❌ No disponible" -ForegroundColor Red
    }
    
    Write-Host ""
}

# Verificar que Docker está corriendo
if (-not (Test-DockerRunning)) {
    exit 1
}

# Ejecutar acción
switch ($Action) {
    "full" {
        Start-Full
    }
    "db-only" {
        Start-DbOnly
    }
    "rebuild" {
        Start-Rebuild
    }
    "stop" {
        Stop-Services
    }
    "logs" {
        Show-Logs
    }
    "status" {
        Show-Status
    }
    default {
        Show-Help
    }
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
