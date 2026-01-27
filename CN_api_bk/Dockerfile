# Imagen base para node
FROM node:18-alpine

# Directorio de trabajo
WORKDIR /app

# Copiar los archivos de dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm install --production

# Copiar el resto del codigo del backend
COPY . .

# Puerto donde corre el backend
EXPOSE 3000

# Comando para ejecutar la aplicacion
CMD ["npm", "start"]
