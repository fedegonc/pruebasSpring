package com.example.demo.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // Genera automáticamente Getters, Setters, toString, equals, y hashCode
@AllArgsConstructor // Genera un constructor con todos los campos
@NoArgsConstructor  // Genera un constructor vacío
public class ButtonConfig {
    private String type;
    private String style;
    private String label;
    private String id;
    private boolean disabled;
}