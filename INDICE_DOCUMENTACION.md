# 📚 Índice de Documentación - Pizzas Reyna Backend

Guía completa de toda la documentación disponible del proyecto.

---

## 🚀 Inicio Rápido

| Documento | Descripción | Para Quién |
|-----------|-------------|------------|
| **[README.md](README.md)** | Introducción general al proyecto | Todos |
| **[GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md)** | Cómo iniciar el proyecto (Docker o local) | Desarrolladores nuevos |
| **[COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md)** | Referencia rápida de comandos | Desarrolladores |
| **[QUICK_START.md](QUICK_START.md)** | Guía de inicio rápido original | Desarrolladores |

---

## 🔧 Configuración y Solución de Problemas

| Documento | Descripción | Cuándo Usar |
|-----------|-------------|-------------|
| **[SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md)** | Solución al error 403 en endpoints autenticados | Cuando recibes 403 Forbidden |
| **[RESUMEN_SOLUCION.md](RESUMEN_SOLUCION.md)** | Resumen ejecutivo de la solución 403 | Vista rápida del problema |
| **[TROUBLESHOOTING_DOCKER.md](TROUBLESHOOTING_DOCKER.md)** | Solución a problemas comunes con Docker | Problemas con Docker |

---

## 📱 Integración con Flutter

| Documento | Descripción | Para Quién |
|-----------|-------------|------------|
| **[API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md)** | Documentación completa de API para Flutter | Desarrolladores Flutter |
| **[EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md)** | Ejemplos reales de respuestas de la API | Desarrolladores Flutter |

---

## 🧪 Testing con Postman

| Documento | Descripción | Para Quién |
|-----------|-------------|------------|
| **[GUIA_POSTMAN.md](GUIA_POSTMAN.md)** | Guía completa de uso de Postman | Testers, QA |
| **[README_POSTMAN.md](README_POSTMAN.md)** | Introducción a la colección de Postman | Testers, QA |
| **[INDICE_DOCUMENTACION_POSTMAN.md](INDICE_DOCUMENTACION_POSTMAN.md)** | Índice de documentación de Postman | Testers, QA |
| **[REFERENCIA_RAPIDA_POSTMAN.md](REFERENCIA_RAPIDA_POSTMAN.md)** | Referencia rápida de Postman | Testers, QA |
| **[Pizzas_Reyna_Postman_Collection.json](Pizzas_Reyna_Postman_Collection.json)** | Colección de Postman importable | Testers, QA |

---

## 📊 Diagramas y Arquitectura

| Documento | Descripción | Para Quién |
|-----------|-------------|------------|
| **[DIAGRAMA_FLUJO_API.md](DIAGRAMA_FLUJO_API.md)** | Diagramas de flujo de la API | Arquitectos, Desarrolladores |

---

## 🛠️ Scripts de Automatización

| Script | Descripción | Uso |
|--------|-------------|-----|
| **[start-docker.ps1](start-docker.ps1)** | Gestión de Docker (iniciar, detener, logs) | `.\start-docker.ps1 [accion]` |
| **[rebuild-docker.ps1](rebuild-docker.ps1)** | Reconstruir Docker completamente | `.\rebuild-docker.ps1` |
| **[test-carrito.ps1](test-carrito.ps1)** | Prueba completa del carrito | `.\test-carrito.ps1` |
| **[test-login-real.ps1](test-login-real.ps1)** | Prueba de login | `.\test-login-real.ps1` |
| **[test-login.ps1](test-login.ps1)** | Prueba de login alternativa | `.\test-login.ps1` |
| **[test-api.ps1](test-api.ps1)** | Prueba general de API | `.\test-api.ps1` |

---

## 📖 Guía de Uso por Rol

### 👨‍💻 Desarrollador Backend (Nuevo en el Proyecto)

1. **Inicio:**
   - [README.md](README.md) - Visión general
   - [GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md) - Configurar ambiente
   - [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md) - Comandos útiles

2. **Desarrollo:**
   - [SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md) - Si tienes problemas de autenticación
   - `.\start-docker.ps1` - Gestionar servicios
   - `.\test-carrito.ps1` - Probar cambios

3. **Referencia:**
   - [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md) - Endpoints disponibles
   - [EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md) - Formato de respuestas

---

### 📱 Desarrollador Flutter

1. **Documentación Principal:**
   - [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md) - **EMPEZAR AQUÍ**
   - [EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md) - Ejemplos reales

2. **Testing:**
   - [Pizzas_Reyna_Postman_Collection.json](Pizzas_Reyna_Postman_Collection.json) - Importar en Postman
   - [GUIA_POSTMAN.md](GUIA_POSTMAN.md) - Cómo usar Postman

3. **Solución de Problemas:**
   - [SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md) - Errores de autenticación
   - [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md) - Verificar backend

---

### 🧪 Tester / QA

1. **Setup:**
   - [GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md) - Iniciar el backend
   - [GUIA_POSTMAN.md](GUIA_POSTMAN.md) - Configurar Postman
   - [Pizzas_Reyna_Postman_Collection.json](Pizzas_Reyna_Postman_Collection.json) - Importar colección

2. **Testing:**
   - [REFERENCIA_RAPIDA_POSTMAN.md](REFERENCIA_RAPIDA_POSTMAN.md) - Guía rápida
   - [EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md) - Respuestas esperadas
   - `.\test-carrito.ps1` - Tests automatizados

3. **Referencia:**
   - [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md) - Todos los endpoints
   - [DIAGRAMA_FLUJO_API.md](DIAGRAMA_FLUJO_API.md) - Flujos de la aplicación

---

### 👨‍💼 Product Manager / Stakeholder

1. **Visión General:**
   - [README.md](README.md) - Qué hace el sistema
   - [DIAGRAMA_FLUJO_API.md](DIAGRAMA_FLUJO_API.md) - Cómo funciona

2. **Funcionalidades:**
   - [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md) - Endpoints disponibles
   - [EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md) - Datos que maneja

---

## 🔍 Búsqueda Rápida por Tema

### 🐳 Docker
- [GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md) - Sección "Con Docker"
- [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md) - Sección "Docker"
- [start-docker.ps1](start-docker.ps1) - Script de gestión

### 🔐 Autenticación / JWT
- [SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md) - Solución completa
- [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md) - Sección "Autenticación"
- [EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md) - Ejemplos de login

### 🛒 Carrito de Compras
- [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md) - Sección "Carrito"
- [test-carrito.ps1](test-carrito.ps1) - Tests automatizados
- [EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md) - Ejemplos de carrito

### 📦 Pedidos
- [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md) - Sección "Pedidos"
- [EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md) - Ejemplos de pedidos
- [DIAGRAMA_FLUJO_API.md](DIAGRAMA_FLUJO_API.md) - Flujo de pedidos

### 🍕 Pizzas / Catálogo
- [API_DOCUMENTATION_FLUTTER.md](API_DOCUMENTATION_FLUTTER.md) - Sección "Pizzas"
- [EJEMPLOS_RESPUESTAS_API.md](EJEMPLOS_RESPUESTAS_API.md) - Ejemplos de pizzas

### 🧪 Testing
- [test-carrito.ps1](test-carrito.ps1) - Test de carrito
- [test-login-real.ps1](test-login-real.ps1) - Test de login
- [GUIA_POSTMAN.md](GUIA_POSTMAN.md) - Testing con Postman
- [Pizzas_Reyna_Postman_Collection.json](Pizzas_Reyna_Postman_Collection.json) - Colección

### 🔧 Troubleshooting
- [SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md) - Error 403
- [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md) - Sección "Problemas Comunes"
- [GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md) - Sección "Troubleshooting"

---

## 📝 Convenciones de Documentación

### Iconos Usados
- 🚀 Inicio rápido / Getting started
- 🔧 Configuración / Setup
- 📱 Mobile / Flutter
- 🧪 Testing / QA
- 🐳 Docker
- 🔐 Seguridad / Autenticación
- 🛒 Carrito
- 📦 Pedidos
- 🍕 Pizzas / Productos
- 📊 Diagramas / Arquitectura
- 🔍 Búsqueda / Referencia
- 💡 Tips / Consejos
- ⚠️ Advertencias
- ✅ Éxito / Completado
- ❌ Error / Problema

### Formato de Código
```bash
# Comandos de terminal
./mvnw spring-boot:run
```

```java
// Código Java
public class Example {}
```

```dart
// Código Dart/Flutter
class Example {}
```

---

## 🆕 Documentos Recientes

1. **[SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md)** - Solución al error 403
2. **[GUIA_INICIO_RAPIDO.md](GUIA_INICIO_RAPIDO.md)** - Guía de inicio con Docker
3. **[COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md)** - Referencia de comandos
4. **[start-docker.ps1](start-docker.ps1)** - Script de gestión Docker
5. **[test-carrito.ps1](test-carrito.ps1)** - Tests automatizados

---

## 📞 Soporte

Si no encuentras lo que buscas:

1. Revisa el [README.md](README.md) principal
2. Busca en [COMANDOS_RAPIDOS.md](COMANDOS_RAPIDOS.md)
3. Consulta [SOLUCION_403_FORBIDDEN.md](SOLUCION_403_FORBIDDEN.md) para problemas comunes
4. Revisa los logs: `docker-compose logs -f backend`

---

## 🔄 Actualización de Documentación

Esta documentación se actualiza constantemente. Última actualización: **27 de Noviembre, 2024**

Para contribuir a la documentación:
1. Mantén el formato consistente
2. Usa los iconos apropiados
3. Incluye ejemplos prácticos
4. Actualiza este índice

---

¡Feliz desarrollo! 🍕🚀
