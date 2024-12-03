# Etapa 1: Construcción de la aplicación
FROM maven:3.8.6-openjdk-18 AS builder
WORKDIR /app

# Copiar archivos necesarios para descargar dependencias
COPY ./pom.xml ./pom.xml

# Descargar dependencias para cachearlas
RUN mvn dependency:go-offline

# Copiar el código fuente de la aplicación
COPY ./src ./src


# Instalar dependencias de Stylus
COPY package.json package-lock.json ./
RUN npm install

# Copiar archivos Stylus y compilar a CSS
COPY src/main/resources/static/stylus/ ./src/main/resources/static/stylus/
RUN npm run build-css

# Construir la aplicación
RUN mvn clean package -DskipTests

# Etapa 2: Generar la imagen para producción
FROM openjdk:18-jdk-alpine
WORKDIR /app

# Copiar el JAR generado desde la etapa anterior
COPY --from=builder /app/target/*.jar app.jar

# Copiar recursos estáticos
COPY src/main/resources/static /app/resources/static

# Exponer el puerto en el que la aplicación se ejecutará
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
