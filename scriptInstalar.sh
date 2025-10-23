
#!/bin/bash

#Bienvenidos al imalalla auauuauaua


# Actualizar paquetes
sudo apt update -y
sudo apt upgrade -y

# Instalar Node y npm
if ! command -v node &> /dev/null
then
	echo "Instalando Node.js y npm"
	sudo apt install -y nodejs npm
fi

# Instalar PostgreSql
if ! command -v psql &> /dev/null
then 
	echo "Instalando PostgreSql"
	sudo apt install -y postgresql postgresql-contrib
	sudo systemctl start postgresql
	sudo systemctl enable postgresql
fi

# Crear tablas y usuario en la base de datos

sudo -u postgres psql -c "CREATE USER usuario1 WITH PASSWORD 'usuario1';"
sudo -u postgres psql -c "CREATE DATABASE Proyecto OWNER usuario1;"
sudo -u postgres psql -c "
    CREATE TABLE users (
  ID SERIAL PRIMARY KEY,
  name VARCHAR(30),
  email VARCHAR(30));"

# Instalar dependencias necesarias del API
echo "Instalando las dependencias del API"
cd CN_api_bk
npm install

# levantar API en segundo plano
npm start &

# Instalar dependencias del React
cd CN_React
npm install

# levantar React 
npm run dev &

echo "Instalacion completada"

	
