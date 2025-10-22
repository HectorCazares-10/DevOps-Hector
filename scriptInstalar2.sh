#!/bin/bash
# Bienvenidos al imalalla auuauauaua 

echo " Actualizando paquetes "
sudo apt update -y && sudo apt upgrade -y

# =========================
# Instalar Node.js y npm
# =========================
if ! command -v node &> /dev/null; then
  echo "Instalando Node.js y npm"
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt install -y nodejs
else
  echo "Node.js ya está instalado (versión: $(node -v))"
fi

# =========================
# Instalar PostgreSQL
# =========================
if ! command -v psql &> /dev/null; then
  echo "Instalando PostgreSQL"
  sudo apt install -y postgresql postgresql-contrib
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
else
  echo "PostgreSQL ya está instalado (versión: $(psql --version))"
fi

# =========================
# Crear usuario y base de datos
# =========================
echo "Configurando base de datos"

# Creamos usuario si no existe
sudo -u postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='usuario1'" | grep -q 1 \
  || sudo -u postgres psql -c "CREATE USER usuario1 WITH PASSWORD 'usuario1';"

# Creamos base de datos si no existe
sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname='Proyecto'" | grep -q 1 \
  || sudo -u postgres psql -c "CREATE DATABASE Proyecto OWNER usuario1;"

# Creamos tabla si no existe
sudo -u postgres psql -d Proyecto -c "
CREATE TABLE IF NOT EXISTS users (
  ID SERIAL PRIMARY KEY,
  name VARCHAR(30),
  email VARCHAR(30)
);"

# Instalar dependencias del API

echo "nstalando dependencias del API"

# Verifica que exista la carpeta
if [ -d "CN_api_bk" ]; then
  cd CN_api_bk
  npm install
  echo "Levantando API en segundo plano"
  nohup npm start > ../api.log 2>&1 &
  cd ..
else
  echo "Carpeta CN_api_bk no encontrada."
fi


# Instalar dependencias del Rea
echo "nstalando dependencias del Frontend "

# Verifica que exista la carpeta
if [ -d "CN_React" ]; then
  cd CN_React
  npm install
  echo "Levantando React (dev mode)"
  nohup npm run dev > ../react.log 2>&1 &
  cd ..
else
  echo "Carpeta CN_React no encontrada."
fi

echo " Instalación completada correctamente "

