package com.diegoardila.aplicacion_prueba.controllers;

import com.diegoardila.aplicacion_prueba.models.Usuario;
import com.diegoardila.aplicacion_prueba.services.UsuarioService;
import com.diegoardila.aplicacion_prueba.exceptions.UsuarioExistenteException;
import com.diegoardila.aplicacion_prueba.exceptions.RegistroUsuarioException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/login")
    public String mostrarLogin(Model model) {
        try {
            return "login"; // Devuelve la vista login.jsp
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar la página de login: " + e.getMessage());
            return "error"; // Puedes redirigir a una página de error.jsp
        }
    }

    @GetMapping("/registro")
    public String mostrarFormularioRegistro(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "registro";
    }

    @PostMapping("/registro")
    public String registrarUsuario(@ModelAttribute Usuario usuario, RedirectAttributes redirectAttributes) {
        try {
            usuarioService.registrarUsuario(usuario);
            return "redirect:/auth/login";
        } catch (UsuarioExistenteException e) {
            redirectAttributes.addFlashAttribute("error", "El usuario ya existe.");
            return "redirect:/auth/registro";
        } catch (RegistroUsuarioException e) {
            redirectAttributes.addFlashAttribute("error", "Error al registrar usuario. Inténtalo de nuevo.");
            return "redirect:/auth/registro";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ocurrió un error inesperado.");
            return "redirect:/auth/registro";
        }
    }

    @ExceptionHandler(Exception.class)
    public String manejarErroresGenerales(Exception e, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", "Error inesperado: " + e.getMessage());
        return "redirect:/auth/login";
    }

    @ControllerAdvice
    public class GlobalExceptionHandler {

        @ExceptionHandler(Exception.class)
        public String handleException(Exception e, Model model) {
            model.addAttribute("error", "Error interno: " + e.getMessage());
            return "error"; // Redirige a error.jsp
        }
    }

}
