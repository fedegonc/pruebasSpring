package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    @GetMapping("/")
    public ModelAndView homePage() {
        ModelAndView modelAndView = new ModelAndView("pages/home");
        modelAndView.addObject("title", "Home Page");
        return modelAndView;
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
