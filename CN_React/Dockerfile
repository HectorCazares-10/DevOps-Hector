# Imagen base
FROM node:18-alpine

# Directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm ci 

# Copiar codigo
COPY . .

# Puerto donde corre el frontend
EXPOSE 5173

# Comando para correr el proyecto
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]