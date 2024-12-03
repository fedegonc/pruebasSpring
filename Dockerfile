# Etapa 1: Construcción de dependencias Node.js (opcional)
FROM node:16 AS node_builder
WORKDIR /app

# Copiar los archivos necesarios para manejar dependencias
COPY package.json ./
COPY package-lock.json ./

# Instalar dependencias de Node.js
RUN npm install

# Etapa 2: Construcción del proyecto Java con Maven
FROM openjdk:18-jdk-alpine as builder
WORKDIR /app

# Instalar Maven
RUN apk add --no-cache maven

# Copiar los archivos de configuración y código fuente
COPY ./pom.xml ./pom.xml
COPY ./src ./src

# Copiar dependencias Node.js construidas en la etapa anterior (opcional)
COPY --from=node_builder /app/node_modules ./node_modules

# Construir el proyecto Java
RUN mvn clean package -DskipTests

# Etapa 3: Imagen final para ejecutar la aplicación
FROM openjdk:18-jdk-alpine
WORKDIR /app

# Copiar el archivo JAR generado por Maven
COPY --from=builder /app/target/*.jar app.jar

# Exponer el puerto donde la aplicación se ejecutará
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
