# Etapa 1: Construcción de la aplicación con Maven
FROM maven:3.8.6-openjdk-18 AS builder
WORKDIR /app

# Copiar el archivo de configuración de Maven
COPY pom.xml ./pom.xml

# Descargar dependencias para cachearlas
RUN mvn dependency:go-offline

# Copiar el código fuente de la aplicación
COPY ./src ./src

# Construir la aplicación
RUN mvn clean package -DskipTests

# Etapa 2: Generación de CSS con Stylus
FROM node:18-alpine AS stylus-builder
WORKDIR /app

# Copiar archivo package.json y package-lock.json
COPY package.json ./package.json
COPY package-lock.json ./package-lock.json

# Instalar dependencias de Stylus
RUN npm install

# Copiar archivos Stylus
COPY src/main/resources/static/stylus/ ./stylus/

# Compilar Stylus a CSS
RUN npm run build-css

# Etapa 3: Imagen de producción
FROM openjdk:18-jdk-alpine
WORKDIR /app

# Copiar el JAR generado desde la etapa Maven
COPY --from=builder /app/target/*.jar app.jar

# Copiar los archivos CSS generados desde la etapa Stylus
COPY --from=stylus-builder /app/src/main/resources/static/css/ ./resources/static/css/

# Exponer el puerto en el que la aplicación se ejecutará
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
