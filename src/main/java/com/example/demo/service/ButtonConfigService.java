package com.example.demo.service;

import java.util.Map;

public interface ButtonConfigService {
    Map<String, Object> createPrimaryButton(String label, String id);
    Map<String, Object> createDisabledButton(String label, String id);
}
