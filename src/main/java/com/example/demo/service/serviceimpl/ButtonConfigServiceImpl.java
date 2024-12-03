package com.example.demo.service.serviceimpl;

import com.example.demo.service.ButtonConfigService;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class ButtonConfigServiceImpl implements ButtonConfigService {


    @Override
    public Map<String, Object> createPrimaryButton(String label, String id) {
        return Map.of(
                "type", "button",
                "style", "btn-secondary",
                "label", label,
                "id", id,
                "disabled", true
        );
    }


    @Override
    public Map<String, Object> createDisabledButton(String label, String id) {
        return Map.of(
                "type", "button",
                "style", "btn-secondary",
                "label", label,
                "id", id,
                "disabled", true
        );
    }
}
