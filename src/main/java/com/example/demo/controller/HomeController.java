package com.example.demo.controller;

import com.example.demo.models.ButtonConfig;
import com.example.demo.service.ButtonConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    @Autowired
    ButtonConfigService buttonConfigService;


    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("brandText", "Gregario Tallados");
        model.addAttribute("link", "/home");
        return "pages/home";
    }

    @GetMapping("/test")
    public ModelAndView testPage() {
        ModelAndView modelAndView = new ModelAndView("pages/test");
        modelAndView.addObject("title", "Test Page");
        return modelAndView;
    }
    @GetMapping("/home")
    public String hola(Model model) {
        model.addAttribute("title", "Home Page"); // Pasar el título dinámico
        return "pages/home"; // Renderizar la página "home.html"
    }
}
