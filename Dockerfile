# Etapa 1: Construcción de la aplicación
FROM maven:3.8.6-openjdk-18 AS builder
WORKDIR /app

# Copiar el archivo de configuración de Maven
COPY ./pom.xml ./pom.xml

# Descargar dependencias para cachearlas
RUN mvn dependency:go-offline

# Copiar el código fuente de la aplicación
COPY ./src ./src

# Construir la aplicación
RUN mvn clean package -DskipTests

# Etapa 2: Generar CSS a partir de Stylus
FROM node:18-alpine AS stylus-builder
WORKDIR /app

# Copiar el archivo de bloqueo de dependencias para npm
COPY package-lock.json ./

# Instalar dependencias de Stylus
RUN npm ci

# Copiar los archivos Stylus
COPY src/main/resources/static/stylus/ ./stylus/

# Compilar Stylus a CSS
RUN npx stylus ./stylus/ -o ./css/

# Etapa 3: Generar la imagen para producción
FROM openjdk:18-jdk-alpine
WORKDIR /app

# Copiar el JAR generado desde la etapa Maven
COPY --from=builder /app/target/*.jar app.jar

# Copiar los archivos CSS generados por Stylus
COPY --from=stylus-builder /app/css/ ./resources/static/css/

# Exponer el puerto en el que la aplicación se ejecutará
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
