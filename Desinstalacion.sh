#!/bin/bash

# Script de desinstalacion

# Colores
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
ENDCOLOR="\e[0m"

# Mensajes de colores
function info() { echo -e "${YELLOW}[INFO]${ENDCOLOR} $1"; }
function success() { echo -e "${GREEN}[OK]${ENDCOLOR} $1"; }
function error() { echo -e "${RED}[ERROR]${ENDCOLOR} $1"; }

# Eliminar las carpetas del proyecto
info "Eliminando carpetas del proyecto..."
for repo in CN_api_bk CN_React; do
    if [ -d "$repo" ]; then
        rm -rf "$repo"
        success "$repo eliminado correctamente."
    else
        info "$repo no existe, se omite."
    fi
done

# Eliminar paquetes instalados
info "Desinstalando paquetes instalados (git, Node.js, nginx, PostgreSQL, curl)"
sudo apt remove -y git nodejs nginx postgresql postgresql-contrib curl >/dev/null 2>&1
sudo apt autoremove -y >/dev/null 2>&1
sudo apt clean >/dev/null 2>&1
success "Paquetes desinstalados correctamente."

# Eliminar los archivos y cache
info "Eliminando cachés y archivos temporales de Node.js..."
sudo rm -rf /usr/local/lib/node_modules
rm -rf ~/.npm ~/.nvm
sudo rm -rf /var/www/html
success "Cachés y archivos temporales eliminados."

# Limpieza del servicio de la base de datos
info "Verificando servicio de PostgreSQL..."
if systemctl is-active --quiet postgresql; then
    info "PostgreSQL sigue activo. No se detendrá para preservar bases de datos."
else
    info "PostgreSQL no está corriendo, nada que hacer."
fi

# Finalizacion
success "Desinstalación completa del proyecto CN"
