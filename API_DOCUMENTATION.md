"""
RAGNAROK Backend - API Documentation
=====================================

BASE URL: http://localhost:5000/api
"""

# ============================================
# AUTENTICACIÓN
# ============================================

POST /auth/registro
  Body: {
    "nombre": "Juan Pérez",
    "email": "juan@example.com",
    "password": "contraseña123"
  }
  Response: 201 - Token JWT + datos usuario

POST /auth/login
  Body: {
    "email": "juan@example.com",
    "password": "contraseña123"
  }
  Response: 200 - Token JWT + datos usuario

GET /auth/verificar
  Headers: Authorization: Bearer {token}
  Response: 200 - Datos del usuario autenticado

# ============================================
# CATÁLOGO DE SERVICIOS
# ============================================

GET /catalogo/categorias
  Response: 200 - Array de categorías

GET /catalogo/categorias/:id
  Response: 200 - Categoría con servicios relacionados

GET /catalogo/servicios
  Response: 200 - Array de todos los servicios

POST /catalogo/categorias (ADMIN)
  Headers: Authorization: Bearer {token}
  Body: {
    "nombre": "Puntas",
    "icono": "fa-bullseye",
    "descripcion": "Descripción opcional"
  }
  Response: 201 - Categoría creada

POST /catalogo/servicios (ADMIN)
  Headers: Authorization: Bearer {token}
  Body: {
    "nombre": "Bizcocho Max",
    "categoria": "id_categoría",
    "descripcion": "Descripción del servicio",
    "precio": 11500,
    "unidad": "ml",
    "imagen": "https://...",
    "caracteristicas": ["característica1", "característica2"],
    "recomendado": true
  }
  Response: 201 - Servicio creado

PUT /catalogo/servicios/:id (ADMIN)
  Headers: Authorization: Bearer {token}
  Body: { campos a actualizar }
  Response: 200 - Servicio actualizado

DELETE /catalogo/servicios/:id (ADMIN)
  Headers: Authorization: Bearer {token}
  Response: 200 - Servicio eliminado

# ============================================
# PRESUPUESTOS
# ============================================

POST /presupuestos
  Headers: Authorization: Bearer {token}
  Body: {
    "cliente": {
      "nombre": "Cliente",
      "rut": "12.345.678-9",
      "email": "cliente@example.com",
      "telefono": "+56912345678",
      "direccion": "Dirección completa"
    },
    "items": [
      {
        "nombre": "Bizcocho Max",
        "cantidad": 50,
        "unidad": "ml",
        "precioUnitario": 11500,
        "total": 575000
      }
    ],
    "subtotal": 575000,
    "iva": 109250,
    "total": 684250,
    "financiamiento": {
      "anticipo": 205275,
      "instalacion": 239487.5,
      "entrega": 239487.5
    }
  }
  Response: 201 - Presupuesto creado

GET /presupuestos
  Headers: Authorization: Bearer {token}
  Response: 200 - Presupuestos del usuario

GET /presupuestos/:id
  Headers: Authorization: Bearer {token}
  Response: 200 - Presupuesto específico

PATCH /presupuestos/:id/estado
  Headers: Authorization: Bearer {token}
  Body: { "estado": "aceptado" }
  Response: 200 - Estado actualizado

# ============================================
# PANEL ADMINISTRATIVO
# ============================================

GET /admin/estadisticas (ADMIN)
  Headers: Authorization: Bearer {token}
  Response: 200 - Estadísticas generales

GET /admin/configuracion (ADMIN)
  Headers: Authorization: Bearer {token}
  Response: 200 - Configuración actual

PUT /admin/configuracion (ADMIN)
  Headers: Authorization: Bearer {token}
  Body: { configuración a actualizar }
  Response: 200 - Configuración actualizada

GET /admin/usuarios (ADMIN)
  Headers: Authorization: Bearer {token}
  Response: 200 - Lista de usuarios

GET /admin/presupuestos (ADMIN)
  Headers: Authorization: Bearer {token}
  Response: 200 - Todos los presupuestos

# ============================================
# CHISTES (PUBLIC)
# ============================================

GET /jokes/random
  Response: 200 - Chiste aleatorio

GET /jokes/category/:category
  Params: general | programming | knock-knock | any
  Response: 200 - Chiste de la categoría

GET /jokes/multiple/:count
  Params: Número de chistes (max 10)
  Response: 200 - Array de chistes

POST /jokes/filtered
  Body: {
    "category": "programming",
    "type": "single"
  }
  Response: 200 - Chiste con filtros

# ============================================
# CLIENTES
# ============================================

POST /clientes/validar-rut
  Body: { "rut": "12.345.678-9" }
  Response: 200 - { valido: true/false }

# ============================================
# CONFIGURACIÓN PÚBLICA
# ============================================

GET /config/publica
  Response: 200 - Configuración pública

# ============================================
# HEALTH CHECK
# ============================================

GET /health
  Response: 200 - { status: "OK", timestamp }

# ============================================
# CÓDIGOS DE RESPUESTA
# ============================================

200 - OK
201 - Created
400 - Bad Request
401 - Unauthorized (falta token)
403 - Forbidden (no es admin)
404 - Not Found
500 - Internal Server Error

# ============================================
# EJEMPLO DE USO CON CURL
# ============================================

# Login
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"password123"}'

# Crear presupuesto
curl -X POST http://localhost:5000/api/presupuestos \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TOKEN_AQUI" \
  -d @presupuesto.json

# Obtener chiste
curl http://localhost:5000/api/jokes/random

# Obtener estadísticas (admin)
curl http://localhost:5000/api/admin/estadisticas \
  -H "Authorization: Bearer ADMIN_TOKEN"
