# 📋 RAGNAROK Backend - Guía de Inicio Rápido

## 🚀 Instalación Rápida (5 minutos)

### Opción 1: Sin Docker (Desarrollo Local)

```bash
# 1. Clonar repositorio
git clone https://github.com/Mbr83mbr/ragnarok-backend.git
cd ragnarok-backend

# 2. Instalar dependencias
npm install

# 3. Configurar variables
cp .env.example .env

# 4. Editar .env con datos de MongoDB
nano .env

# 5. Iniciar servidor
npm run dev
```

**URL**: http://localhost:5000

---

### Opción 2: Con Docker (Recomendado)

```bash
# 1. Clonar repositorio
git clone https://github.com/Mbr83mbr/ragnarok-backend.git
cd ragnarok-backend

# 2. Iniciar con Docker Compose
docker-compose up -d

# 3. Verificar que está corriendo
curl http://localhost:5000/health
```

**URL**: http://localhost:5000

---

## 🧪 Testear la API

### 1. Registrarse

```bash
curl -X POST http://localhost:5000/api/auth/registro \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan Pérez",
    "email": "juan@test.com",
    "password": "password123"
  }'
```

**Respuesta esperada:**
```json
{
  "mensaje": "Usuario registrado exitosamente",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "usuario": {
    "id": "507f1f77bcf86cd799439011",
    "nombre": "Juan Pérez",
    "email": "juan@test.com"
  }
}
```

### 2. Login

```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "juan@test.com",
    "password": "password123"
  }'
```

### 3. Obtener Servicios

```bash
curl http://localhost:5000/api/catalogo/servicios
```

### 4. Obtener Chistes (Sin autenticación)

```bash
# Chiste aleatorio
curl http://localhost:5000/api/jokes/random

# De categoría específica
curl http://localhost:5000/api/jokes/category/programming

# Múltiples chistes
curl http://localhost:5000/api/jokes/multiple/3
```

### 5. Crear Presupuesto

```bash
curl -X POST http://localhost:5000/api/presupuestos \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TU_TOKEN_AQUI" \
  -d '{
    "cliente": {
      "nombre": "Cliente Ejemplo",
      "rut": "12.345.678-9",
      "email": "cliente@example.com",
      "direccion": "Calle Principal 123"
    },
    "items": [
      {
        "nombre": "Servicio 1",
        "cantidad": 10,
        "unidad": "ml",
        "precioUnitario": 1000,
        "total": 10000
      }
    ],
    "subtotal": 10000,
    "iva": 1900,
    "total": 11900,
    "financiamiento": {
      "anticipo": 3570,
      "instalacion": 4165,
      "entrega": 4165
    }
  }'
```

---

## 📊 Endpoints Principales

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| POST | `/api/auth/registro` | Registrar usuario |
| POST | `/api/auth/login` | Iniciar sesión |
| GET | `/api/catalogo/servicios` | Listar servicios |
| POST | `/api/presupuestos` | Crear presupuesto |
| GET | `/api/presupuestos` | Mis presupuestos |
| GET | `/api/jokes/random` | Chiste aleatorio |
| GET | `/api/admin/estadisticas` | Estadísticas (admin) |

---

## 🔧 Configuración MongoDB

### Opción 1: MongoDB Atlas (Cloud)

1. Ve a [mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas)
2. Crea cuenta gratis
3. Crea un cluster
4. Copia la connection string
5. Pega en `.env`:

```env
MONGODB_URI=mongodb+srv://usuario:contraseña@cluster.mongodb.net/ragnarok
```

### Opción 2: MongoDB Local

```bash
# Instalar MongoDB (en macOS)
brew tap mongodb/brew
brew install mongodb-community

# Iniciar servicio
brew services start mongodb-community

# En .env
MONGODB_URI=mongodb://localhost:27017/ragnarok
```

---

## 🐳 Comandos Docker útiles

```bash
# Iniciar servicios
docker-compose up -d

# Ver logs
docker-compose logs -f backend

# Detener servicios
docker-compose down

# Reconstruir imagen
docker-compose up -d --build

# Acceder a MongoDB dentro de Docker
docker-compose exec mongodb mongosh
```

---

## 📱 Integración con Frontend RAGNAROK

```javascript
// En el frontend
const API_URL = 'http://localhost:5000/api';

// Login
async function login(email, password) {
  const res = await fetch(`${API_URL}/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password })
  });
  const data = await res.json();
  localStorage.setItem('token', data.token);
  return data;
}

// Crear presupuesto
async function crearPresupuesto(presupuesto) {
  const token = localStorage.getItem('token');
  const res = await fetch(`${API_URL}/presupuestos`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    },
    body: JSON.stringify(presupuesto)
  });
  return res.json();
}

// Obtener chistes
async function obtenerChiste() {
  const res = await fetch(`${API_URL}/jokes/random`);
  return res.json();
}
```

---

## 🔐 Variables de Entorno Importantes

```env
# Base de datos
MONGODB_URI=mongodb+srv://...

# Seguridad
JWT_SECRET=clave_super_segura_minimo_32_caracteres
JWT_EXPIRE=7d

# CORS - frontend
CORS_ORIGIN=http://localhost:3000,https://tudominio.com

# Puerto
PORT=5000
NODE_ENV=development
```

---

## 🚨 Troubleshooting

### Error: "Connection refused"
```bash
# Verifica que MongoDB está corriendo
docker-compose ps

# O si usas MongoDB local
brew services list | grep mongodb
```

### Error: "CORS"
Actualiza `CORS_ORIGIN` en `.env` con la URL correcta del frontend

### Error: "Token inválido"
- Verifica que `JWT_SECRET` sea igual en todos lados
- Regenera un nuevo token

### Puerto 5000 en uso
```bash
# Cambiar puerto en .env
PORT=5001

# O liberar puerto
lsof -i :5000
kill -9 <PID>
```

---

## 📚 Documentación Completa

Ver `API_DOCUMENTATION.md` para lista completa de endpoints

---

## 🎉 ¡Listo!

Tu backend RAGNAROK está corriendo. Ahora:

1. ✅ Conecta el frontend
2. ✅ Prueba los endpoints
3. ✅ Personaliza según necesites

¿Preguntas? Abre un issue en GitHub.

