package com.diegoardila.aplicacion_prueba.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/productos")
public class ProductoController {
    @GetMapping("/nuevo")
    public String home(Model model) {
        model.addAttribute("mensaje", "¡Bienvenido a la aplicación!");
        return "formulario"; // Se refiere a formulario.jsp en WEB-INF/views/
    }
}
