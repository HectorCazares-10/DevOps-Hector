bin/bash

echo "Desinstalar proyecto"

# Deterner los procesos Node.js 
pkill -f "node"
pkill -f "vite"

# Eliminar los node_modules de las carpetas
rm -rf CN_api_bk/node_modules
rm -rf CN_React/node_modules

# Eliminar base de datos y usuarios
sudo -u postgres psql -c "DROP DATABASE IF EXISTS Proyecto;"
sudo -u postgres psql -c "DROP USER IF EXISTS usuario1"
echo "Base de datos eliminado"

echo "Desinstalar Node.js y PostgreSQL"
sudo apt remove --purge -y nodejs npm postgresql postgresql-contrib
sudo apt autoremove -y

echo "Desinstalacion terminada" #hola
