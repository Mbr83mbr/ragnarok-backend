# 🚀 RAGNAROK Backend API

## Descripción
Backend profesional para el sistema de presupuestos técnicos RAGNAROK. API REST completa con autenticación JWT, MongoDB y gestión de cotizaciones.

## Características
✅ **API REST completa** con 6 módulos principales  
✅ **Autenticación JWT** segura  
✅ **MongoDB** integrado con Mongoose  
✅ **Sistema de cotizaciones** con histórico  
✅ **Gestión de usuarios y roles** (usuario/admin)  
✅ **Configuración dinámica** sincronizada  
✅ **Validación de datos** completa (RUT, emails, etc)  
✅ **Seguridad** (CORS, Helmet, bcrypt)  
✅ **Manejo de errores** centralizado  
✅ **Documentado** y listo para producción  

## Requisitos Previos
- **Node.js** v14 o superior
- **MongoDB** Atlas (cloud) o local
- **npm** o **yarn**

## Instalación Rápida

### 1. Clonar el repositorio
```bash
git clone https://github.com/Mbr83mbr/ragnarok-backend.git
cd ragnarok-backend
```

### 2. Instalar dependencias
```bash
npm install
```

### 3. Configurar variables de entorno
```bash
cp .env.example .env
```

Edita el archivo `.env` con tus valores:
```env
PORT=5000
MONGODB_URI=mongodb+srv://usuario:contraseña@cluster.mongodb.net/ragnarok
JWT_SECRET=tu_clave_super_segura_aqui
CORS_ORIGIN=http://localhost:3000
```

### 4. Iniciar servidor
```bash
# Desarrollo (con nodemon)
npm run dev

# Producción
npm start
```

El servidor estará disponible en: `http://localhost:5000`

## 📡 Endpoints Principales

### Autenticación (`/api/auth`)
```
POST   /api/auth/registro      - Registrar nuevo usuario
POST   /api/auth/login         - Iniciar sesión
GET    /api/auth/verificar     - Verificar token (requiere JWT)
```

### Catálogo (`/api/catalogo`)
```
GET    /api/catalogo/categorias           - Obtener todas las categorías
GET    /api/catalogo/categorias/:id       - Obtener categoría con servicios
GET    /api/catalogo/servicios            - Obtener todos los servicios
POST   /api/catalogo/categorias           - Crear categoría (admin)
POST   /api/catalogo/servicios            - Crear servicio (admin)
PUT    /api/catalogo/servicios/:id        - Actualizar servicio (admin)
DELETE /api/catalogo/servicios/:id        - Eliminar servicio (admin)
```

### Presupuestos (`/api/presupuestos`)
```
POST   /api/presupuestos              - Crear presupuesto (requiere JWT)
GET    /api/presupuestos              - Listar presupuestos del usuario
GET    /api/presupuestos/:id          - Obtener presupuesto específico
PATCH  /api/presupuestos/:id/estado   - Cambiar estado de presupuesto
```

### Admin (`/api/admin`)
```
GET    /api/admin/estadisticas        - Estadísticas generales (admin)
GET    /api/admin/configuracion       - Obtener configuración (admin)
PUT    /api/admin/configuracion       - Actualizar configuración (admin)
GET    /api/admin/usuarios            - Listar usuarios (admin)
GET    /api/admin/presupuestos        - Listar todos presupuestos (admin)
```

### Clientes (`/api/clientes`)
```
POST   /api/clientes/validar-rut      - Validar RUT chileno
```

### Config (`/api/config`)
```
GET    /api/config/publica            - Obtener configuración pública
```

## 🔐 Autenticación

### Ejemplo de Login
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "usuario@example.com",
    "password": "contraseña123"
  }'
```

**Respuesta:**
```json
{
  "mensaje": "Login exitoso",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "usuario": {
    "id": "507f1f77bcf86cd799439011",
    "nombre": "Juan Pérez",
    "email": "usuario@example.com",
    "role": "usuario"
  }
}
```

### Usar el Token
Incluye el token en el header `Authorization`:
```bash
curl -X GET http://localhost:5000/api/presupuestos \
  -H "Authorization: Bearer tu_token_aqui"
```

## 📊 Ejemplo: Crear Presupuesto

```bash
curl -X POST http://localhost:5000/api/presupuestos \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer tu_token" \
  -d '{
    "cliente": {
      "nombre": "Juan de Dios Pérez",
      "rut": "12.345.678-9",
      "email": "cliente@example.com",
      "telefono": "+569 12345678",
      "direccion": "Calle Principal 123, Santiago"
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
  }'
```

## 🏗️ Estructura de Carpetas

```
ragnarok-backend/
├── src/
│   ├── models/              # Esquemas MongoDB (Usuario, Presupuesto, etc)
│   ├── routes/              # Rutas de API (auth, catalogo, admin, etc)
│   ├── middleware/          # Middlewares (autenticación, errores)
│   ├── app.js              # Configuración Express
│
├── server.js                # Punto de entrada
├── .env.example             # Variables de entorno template
├── .gitignore               # Archivos a ignorar en Git
├── package.json             # Dependencias y scripts
└── README.md                # Este archivo
```

## 🔗 Integración con Frontend

El frontend RAGNAROK puede conectarse así:

```javascript
const API_URL = 'http://localhost:5000/api';

// Login
const response = await fetch(`${API_URL}/auth/login`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ email, password })
});

const data = await response.json();
localStorage.setItem('token', data.token);

// Crear presupuesto
const presupuesto = await fetch(`${API_URL}/presupuestos`, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${localStorage.getItem('token')}`
  },
  body: JSON.stringify(presupuestoData)
});
```

## 📚 Documentación de Modelos

### Usuario
```javascript
{
  nombre: String,           // Requerido
  email: String,            // Único, requerido
  password: String,         // Hash bcrypt
  role: String,             // 'usuario' o 'admin'
  activo: Boolean,          // true por defecto
  createdAt: Date,
  updatedAt: Date
}
```

### Presupuesto
```javascript
{
  numero: String,           // RAG-000001
  cliente: {
    nombre: String,
    rut: String,
    email: String,
    telefono: String,
    direccion: String
  },
  items: [{ ... }],
  subtotal: Number,
  iva: Number,
  total: Number,
  financiamiento: {
    anticipo: Number,
    instalacion: Number,
    entrega: Number
  },
  estado: String,           // 'borrador', 'emitido', 'aceptado', etc
  createdAt: Date
}
```

## 🚨 Manejo de Errores

La API devuelve errores consistentes:

```json
{
  "error": "Mensaje descriptivo del error",
  "timestamp": "2024-01-15T10:30:45.123Z"
}
```

**Códigos de estado comunes:**
- `200` - Éxito
- `201` - Creado
- `400` - Solicitud inválida
- `401` - No autenticado
- `403` - Acceso denegado
- `404` - No encontrado
- `500` - Error interno

## 🔄 Flujo de Trabajo Típico

1. **Usuario se registra/logea** → Obtiene token JWT
2. **Frontend almacena el token** en localStorage
3. **Usuario crea presupuesto** → API lo guarda en DB
4. **Admin gestiona configuración** → Se sincroniza en tiempo real
5. **Usuario descarga PDF** → Backend genera PDF

## 📝 Variables de Entorno Importantes

```env
# Base de datos
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/ragnarok

# Seguridad
JWT_SECRET=clave_super_segura_minimo_32_caracteres
JWT_EXPIRE=7d

# CORS (permite acceso desde el frontend)
CORS_ORIGIN=http://localhost:3000,https://tudominio.com

# Admin
ADMIN_PASSWORD=admin123
```

## 🚀 Deploy a Producción

### Render.com (Recomendado)
1. Push a GitHub
2. Conecta repo en Render
3. Configura variables de entorno
4. Deploy automático

### Heroku
```bash
heroku login
heroku create ragnarok-backend
git push heroku main
```

## 🐛 Troubleshooting

**Error: "Connection refused"**
- Verifica que MongoDB esté corriendo
- Chequea MONGODB_URI en .env

**Error: "Token inválido"**
- El JWT_SECRET debe ser consistente
- Regenera un nuevo token

**Error: CORS**
- Actualiza CORS_ORIGIN en .env
- Asegúrate que el frontend está en la lista

## 📞 Soporte

Para problemas o sugerencias, abre un issue en GitHub.

## 📄 Licencia

ISC

## 👨‍💻 Autor

**Mbr83mbr** - Desarrollo y mantenimiento

---

**Última actualización:** Enero 2024  
**Versión:** 1.0.0
