package com.diegoardila.aplicacion_prueba.controllers;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/error")
public class CustomErrorController implements ErrorController {

    @GetMapping
    public String handleError(HttpServletRequest request, Model model) {
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        Throwable exception = (Throwable) request.getAttribute("javax.servlet.error.exception");

        model.addAttribute("statusCode", statusCode);
        model.addAttribute("errorMessage", exception != null ? exception.getMessage() : "Error desconocido");

        return "error"; // Debes tener un archivo JSP llamado error.jsp
    }
}
