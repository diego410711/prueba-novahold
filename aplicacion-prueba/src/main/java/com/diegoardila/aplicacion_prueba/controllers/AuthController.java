package com.diegoardila.aplicacion_prueba.controllers;

import com.diegoardila.aplicacion_prueba.models.Usuario;
import com.diegoardila.aplicacion_prueba.services.UsuarioService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
public class AuthController {

    private final UsuarioService usuarioService;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;

    public AuthController(UsuarioService usuarioService, AuthenticationManager authenticationManager,
            PasswordEncoder passwordEncoder) {
        this.usuarioService = usuarioService;
        this.authenticationManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/login")
    public String mostrarLogin(@RequestParam(value = "error", required = false) String error, Model model) {
        if (error != null) {
            model.addAttribute("error", "Credenciales incorrectas. Inténtalo de nuevo.");
        }
        return "login"; // Muestra login.jsp
    }

    @PostMapping("/login")
    public String procesarLogin(@RequestParam String email,
            @RequestParam String password,
            RedirectAttributes redirectAttributes) {
        try {
            // Buscar usuario en la base de datos
            Usuario usuario = usuarioService.buscarPorEmail(email);
            if (usuario == null) {
                throw new UsernameNotFoundException("Usuario no registrado.");
            }

            // Validar la contraseña
            if (!passwordEncoder.matches(password, usuario.getPassword())) {
                throw new BadCredentialsException("Contraseña incorrecta.");
            }

            // Autenticar usuario con Spring Security
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(email, password));

            if (authentication.isAuthenticated()) {
                return "redirect:/home"; // Redirigir al home si la autenticación es exitosa
            } else {
                redirectAttributes.addFlashAttribute("error", "Error en la autenticación.");
                return "redirect:/auth/login";
            }
        } catch (UsernameNotFoundException e) {
            redirectAttributes.addFlashAttribute("error", "Usuario no registrado.");
            return "redirect:/auth/login";
        } catch (BadCredentialsException e) {
            redirectAttributes.addFlashAttribute("error", "Contraseña incorrecta.");
            return "redirect:/auth/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error inesperado: " + e.getMessage());
            return "redirect:/auth/login";
        }
    }

    @GetMapping("/registro")
    public String mostrarFormularioRegistro(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "registro"; // Muestra registro.jsp
    }

    @PostMapping("/registro")
    public String registrarUsuario(@ModelAttribute Usuario usuario, RedirectAttributes redirectAttributes) {
        try {
            usuarioService.registrarUsuario(usuario);
            return "redirect:/auth/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error al registrar usuario: " + e.getMessage());
            return "redirect:/auth/registro";
        }
    }

    @GetMapping("/logout")
    public String logout(RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("success", "Sesión cerrada correctamente.");
        return "redirect:/auth/login";
    }
}
