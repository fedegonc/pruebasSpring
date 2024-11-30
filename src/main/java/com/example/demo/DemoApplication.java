package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication app = new SpringApplication(DemoApplication.class);

		// Hook para cerrar recursos al detener la aplicación
		Runtime.getRuntime().addShutdownHook(new Thread(() -> {
			System.out.println("Cerrando recursos...");
		}));

		app.run(args);
	}

}

