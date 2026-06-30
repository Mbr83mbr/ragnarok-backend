#!/bin/bash

# Script de instalación y configuración de RAGNAROK Backend

echo "🚀 RAGNAROK Backend - Setup Script"
echo "=================================="

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js no está instalado. Por favor instala Node.js v14+"
    exit 1
fi

echo "✅ Node.js $(node --version) detectado"

# Instalar dependencias
echo "📦 Instalando dependencias..."
npm install

# Crear archivo .env si no existe
if [ ! -f .env ]; then
    echo "📝 Creando archivo .env..."
    cp .env.example .env
    echo "⚠️  Por favor edita .env con tus configuraciones"
fi

# Crear carpetas necesarias
mkdir -p uploads pdf-temp logs

echo ""
echo "✨ Setup completado!"
echo ""
echo "Para iniciar el servidor:"
echo "  npm run dev     (Desarrollo con nodemon)"
echo "  npm start       (Producción)"
echo ""
echo "Para usar Docker:"
echo "  docker-compose up -d"
echo ""
