package com.diegoardila.aplicacion_prueba.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/home")
    public String home(Model model) {
        model.addAttribute("mensaje", "¡Bienvenido a la aplicación!");
        return "home"; // Se refiere a home.jsp en WEB-INF/views/
    }
}
