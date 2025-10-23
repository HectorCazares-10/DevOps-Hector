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
if ! sudo systemctl is-activeif ! sudo systemctl is-active --quiet postgresql; then
  info "Iniciando servicio PostgreSQL..."
  sudo systemctl start postgresql
  sudo systemctl enable postgresql
else
  success "PostgreSQL se esta ejecutando"
fi

# Configuracion de la base de datos
