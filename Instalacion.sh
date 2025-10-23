#!/bin/bash

# Script de instalacion para levantar el proyecto

# Variables de configuracion
DB_NAME="database_bk"
DB_USER="user1"
DB_PASS="user1"
REPO_API="https://github.com/evil2014/CN_api_bk.git"
REPO_FRONT="https://github.com/evil2014/CN_React.git"

# Colores
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
ENDCOLOR="\e[0m"

# Funciones para mensajes de colores 
function info() { echo -e "${YELLOW}[INFO]${ENDCOLOR} $1"; }
function success() { echo -e "${GREEN}[OK]${ENDCOLOR} $1"; }
function error() { echo -e "${RED}[ERROR]${ENDCOLOR} $1"; }

# Instalacion de las dependencias (git, Node.js, nginx, PostgreSQL)
sudo apt update -y
sudo apt install -y git curl nginx postgresql postgresql-contrib

# Verificacion de la base de datos PostgreSQL
if ! sudo systemctl is-active --quiet postgresql; then
  info "Iniciando servicio PostgreSQL..."
  sudo systemctl start postgresql
  sudo systemctl enable postgresql
else
  success "PostgreSQL se esta ejecutando"
fi

# Configuracion de la base de datos
sudo -u postgres psql -c "ALTER USER $DB_USER WITH PASSWORD '$DB_PASS';"

# Verifica y crea la base de datos
EXISTE_BD=$(sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'")
if [ "$EXISTE_BD" != "1" ]; then
  info "Creando base de datos '$DB_NAME'..."
  sudo -u postgres createdb $DB_NAME
else
  success "La base de datos '$DB_NAME' ya existe."
fi

# Crear tabla y agregar datos
sudo -u postgres psql -d $DB_NAME -c "CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  email VARCHAR(30)
);"

COUNT=$(sudo -u postgres psql -d $DB_NAME -tAc "SELECT COUNT(*) FROM users;")
if [ "$COUNT" -eq 0 ]; then
  info "Insertando datos iniciales..."
  sudo -u postgres psql -d $DB_NAME -c "INSERT INTO users (name, email) VALUES
    ('Hector', 'hector@gmail.com'),
    ('Eduardo', 'eduardo@gmail.com'),
    ('Keyla', 'keyla@gmail.com');"
else
  success "La tabla users ya contiene datos."
fi

# Instalacion de Node.js
if ! command -v node >/dev/null 2>&1; then
  info "Instalando Node.js..."
  curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash -
  sudo apt install -y nodejs
else
  success "Node.js ya está instalado."
fi

# Clonar e instalar el backend
info "Instalando CN_api_bk..."
if [ ! -d "CN_api_bk" ]; then
  git clone $REPO_API
  cd CN_api_bk || exit
else
  info "Directorio CN_api_bk ya existe, actualizando dependencias..."
  cd CN_api_bk || exit
fi
npm install
cd ..

# Clonar e instalar el frontend
info "Instalando CN_React..."
if [ ! -d "CN_React" ]; then
  git clone $REPO_FRONT
  cd CN_React || exit
else
  info "Directorio CN_React ya existe, actualizando dependencias..."
  cd CN_React || exit
fi
npm install
cd ..

# Finalizar instalacion
success "Instalación y configuración completadas correctamente"
