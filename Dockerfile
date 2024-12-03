# Etapa 1: Instalar dependencias Stylus
FROM node:16 AS stylus-builder
WORKDIR /app

COPY package.json ./
RUN npm install stylus

# Etapa 2: Construcción del proyecto Java
FROM openjdk:18-jdk-alpine as builder
WORKDIR /app

# Instalar Maven
RUN apk add --no-cache maven

COPY ./pom.xml ./pom.xml
COPY ./src ./src

RUN mvn clean package -DskipTests

# Etapa 3: Imagen final para ejecutar el proyecto
FROM openjdk:18-jdk-alpine
WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar
COPY --from=stylus-builder /app/node_modules ./node_modules

# Exponer el puerto
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
