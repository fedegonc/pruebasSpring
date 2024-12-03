# Usa una imagen base de Node.js
FROM node:16 AS builder

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de configuración
COPY package.json ./package.json
COPY package-lock.json ./package-lock.json

# Instala las dependencias
RUN npm install

# Copia el resto del código fuente
COPY . .

# Construye la aplicación (si es necesario)
RUN npm run build

# Imagen final
FROM node:16

WORKDIR /app

# Copia desde la etapa anterior
COPY --from=builder /app .

# Comando para iniciar la aplicación
CMD ["npm", "start"]
