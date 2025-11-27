# 🍕 Pizzas Reyna Backend - Inicio

## 👋 ¡Bienvenido!

Este es el backend de Pizzas Reyna. Aquí encontrarás todo lo que necesitas para empezar.

---

## ⚡ Inicio Rápido (3 pasos)

### 1️⃣ Iniciar el Backend

**Con Docker (Recomendado):**
```bash
docker-compose up -d --build
```

**Sin Docker:**
```bash
./mvnw spring-boot:run
```

**Con Script Helper:**
```bash
.\start-docker.ps1
```

### 2️⃣ Verificar que Funciona

```bash
# Abrir en el navegador
start http://localhost:8080/swagger-ui.html

# O con curl
curl http://localhost:8080/api/pizzas
```

### 3️⃣ Probar Autenticación

```powershell
.\test-carrito.ps1
```

✅ Si ves "Todas las pruebas pasaron", ¡estás listo!

---

## 📚 ¿Qué Necesitas?

### 🆕 Soy Nuevo en el Proyecto
1. Lee [README.md](README.md) - Visión general
2. Sigue [GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md) - Setup completo
3. Guarda [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md) - Referencia

### 📱 Desarrollo Flutter
1. **EMPIEZA AQUÍ:** [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md)
2. Revisa [EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md)
3. Importa [Pizzas_Reyna_Postman_Collection.json](Pizzas_Reyna_Postman_Collection.json)

### 🧪 Testing / QA
1. Sigue [GUIA_POSTMAN.md](GUIA_POSTMAN.md)
2. Importa [Pizzas_Reyna_Postman_Collection.json](Pizzas_Reyna_Postman_Collection.json)
3. Usa [REFERENCIA_RAPIDA_POSTMAN.md](REFERENCIA_RAPIDA_POSTMAN.md)

### 🔧 Tengo un Problema
1. **Error 403:** [SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md)
2. **Otros problemas:** [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md) → Sección "Troubleshooting"
3. **Ver logs:** `docker-compose logs -f backend`

### 📖 Busco Documentación Específica
- **Índice completo:** [INDICE_DOCUMENTACION.md](INDICE_DOCUMENTACION.md)
- **Comandos:** [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md)
- **API:** [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md)

---

## 🎯 Flujo de Trabajo Recomendado

### Desarrollo Diario

```bash
# 1. Iniciar PostgreSQL en Docker
docker-compose -f docker-compose.dev.yml up -d

# 2. Iniciar backend desde IDE o terminal
./mvnw spring-boot:run

# 3. Hacer cambios en el código

# 4. Probar cambios
.\test-carrito.ps1

# 5. Al terminar, detener PostgreSQL
docker-compose -f docker-compose.dev.yml down
```

### Testing Completo

```bash
# 1. Iniciar todo con Docker
docker-compose up -d --build

# 2. Ejecutar tests
.\test-carrito.ps1
.\test-login-real.ps1

# 3. Probar con Postman
# (Importar Pizzas_Reyna_Postman_Collection.json)

# 4. Detener servicios
docker-compose down
```

### Deployment

```bash
# 1. Construir imagen
docker build -t pizzasreyna-backend:latest .

# 2. Ejecutar en producción
docker-compose -f docker-compose.prod.yml up -d
```

---

## 🔗 URLs Importantes

| Servicio | URL | Descripción |
|----------|-----|-------------|
| **Backend** | http://localhost:8080 | API REST |
| **Swagger UI** | http://localhost:8080/swagger-ui.html | Documentación interactiva |
| **API Docs** | http://localhost:8080/api-docs | OpenAPI JSON |
| **PostgreSQL** | localhost:5432 | Base de datos |

---

## 🛠️ Scripts Disponibles

| Script | Descripción | Uso |
|--------|-------------|-----|
| `start-docker.ps1` | Gestión de Docker | `.\start-docker.ps1 [accion]` |
| `rebuild-docker.ps1` | Reconstruir Docker | `.\rebuild-docker.ps1` |
| `test-carrito.ps1` | Test de carrito | `.\test-carrito.ps1` |
| `test-login-real.ps1` | Test de login | `.\test-login-real.ps1` |
| `test-api.ps1` | Test general | `.\test-api.ps1` |

### Acciones de start-docker.ps1

```bash
.\start-docker.ps1              # Iniciar todo
.\start-docker.ps1 db-only      # Solo PostgreSQL
.\start-docker.ps1 rebuild      # Reconstruir todo
.\start-docker.ps1 stop         # Detener servicios
.\start-docker.ps1 logs         # Ver logs
.\start-docker.ps1 status       # Ver estado
```

---

## 📊 Arquitectura Rápida

```
┌─────────────────┐
│  Flutter App    │
└────────┬────────┘
         │ HTTP/WebSocket
         ▼
┌─────────────────┐
│  Spring Boot    │ ← JWT Auth
│  Backend        │ ← REST API
└────────┬────────┘
         │ JDBC
         ▼
┌─────────────────┐
│  PostgreSQL     │
│  Database       │
└─────────────────┘
```

---

## 🔐 Credenciales por Defecto

### Usuario Admin
- **Email:** `admin@pizzasreyna.com`
- **Password:** `admin123`
- **Rol:** ADMIN

### Base de Datos
- **Host:** `localhost`
- **Port:** `5432`
- **Database:** `pizzasreyna`
- **User:** `postgres`
- **Password:** `postgres`

---

## 🎓 Recursos de Aprendizaje

### Documentación Técnica
- [Spring Boot Docs](https://spring.io/projects/spring-boot)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [Docker Docs](https://docs.docker.com/)
- [JWT.io](https://jwt.io/)

### Tutoriales Internos
- [GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md) - Setup completo
- [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md) - API para Flutter
- [SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md) - Solución de problemas

---

## 🆘 Ayuda Rápida

### ❓ ¿El backend no inicia?

```bash
# 1. Verificar que PostgreSQL está corriendo
docker-compose ps

# 2. Ver logs
docker-compose logs backend

# 3. Verificar puerto 8080
netstat -ano | findstr :8080
```

### ❓ ¿Recibo error 403?

```bash
# 1. Leer la solución
cat SOLUCION_403_FORBIDDEN.md

# 2. Ejecutar test
.\test-carrito.ps1

# 3. Ver logs de JWT
docker-compose logs backend | grep "JWT Filter"
```

### ❓ ¿Necesito empezar de cero?

```bash
# Limpiar todo y empezar de nuevo
docker-compose down -v
docker-compose up -d --build
.\test-carrito.ps1
```

---

## 📞 Contacto y Soporte

- **Documentación:** [INDICE_DOCUMENTACION.md](INDICE_DOCUMENTACION.md)
- **Comandos:** [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md)
- **Issues:** Revisa los logs con `docker-compose logs -f`

---

## ✅ Checklist de Inicio

- [ ] Docker Desktop instalado y corriendo
- [ ] Repositorio clonado
- [ ] Backend iniciado (`docker-compose up -d` o `./mvnw spring-boot:run`)
- [ ] Swagger UI accesible (http://localhost:8080/swagger-ui.html)
- [ ] Test de carrito exitoso (`.\test-carrito.ps1`)
- [ ] Postman configurado (importar colección)
- [ ] Documentación revisada

---

## 🎉 ¡Listo para Desarrollar!

Ahora que tienes todo configurado:

1. 🔍 Explora la API en Swagger UI
2. 📱 Integra con Flutter usando [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md)
3. 🧪 Prueba endpoints con Postman
4. 💻 Desarrolla nuevas features

**¡Éxito con tu proyecto! 🚀🍕**

---

*Última actualización: 27 de Noviembre, 2024*
