package com.diegoardila.aplicacion_prueba.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.diegoardila.aplicacion_prueba.models.Usuario;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @GetMapping("/login")
    public String mostrarLogin(@RequestParam(value = "error", required = false) String error, Model model) {
        if (error != null) {
            model.addAttribute("error", "Credenciales incorrectas. Inténtalo de nuevo.");
        }
        return "login"; // Retorna la vista login.jsp
    }

    @GetMapping("/registro")
    public String mostrarFormularioRegistro(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "registro"; // Retorna la vista registro.jsp
    }
}
