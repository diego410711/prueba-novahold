package com.diegoardila.aplicacion_prueba.controllers;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.diegoardila.aplicacion_prueba.models.Usuario;
import com.diegoardila.aplicacion_prueba.services.UsuarioService;

@RestController
@RequestMapping("/api/auth")
public class AuthRestController {

    private final UsuarioService usuarioService;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;

    public AuthRestController(UsuarioService usuarioService, AuthenticationManager authenticationManager,
            PasswordEncoder passwordEncoder) {
        this.usuarioService = usuarioService;
        this.authenticationManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/login")
    public ResponseEntity<?> procesarLogin(@RequestBody LoginRequest loginRequest) {
        try {
            Usuario usuario = usuarioService.buscarPorEmail(loginRequest.getEmail());

            if (usuario == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("error", "Usuario no registrado."));
            }

            if (!passwordEncoder.matches(loginRequest.getPassword(), usuario.getPassword())) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of("error", "Contraseña incorrecta."));
            }

            // Autenticación manual validada arriba, puedes omitir AuthenticationManager si
            // no lo usas
            return ResponseEntity.ok(Map.of(
                    "message", "Inicio de sesión exitoso",
                    "user", usuario.getEmail(),
                    "redirectUrl", "/home"));

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Error inesperado: " + e.getMessage()));
        }
    }

    @PostMapping("/registro")
    public ResponseEntity<?> registrarUsuario(@RequestBody RegistroRequest registroRequest) {
        try {
            if (usuarioService.buscarPorEmail(registroRequest.getEmail()) != null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("error", "El correo ya está registrado."));
            }

            Usuario nuevoUsuario = new Usuario();
            nuevoUsuario.setNombre(registroRequest.getNombre());
            nuevoUsuario.setEmail(registroRequest.getEmail());
            nuevoUsuario.setPassword(registroRequest.getPassword()); // No encriptar aquí

            usuarioService.registrarUsuario(nuevoUsuario); // 🔥 Se encripta dentro del service

            return ResponseEntity.ok(Map.of(
                    "message", "Registro exitoso",
                    "redirectUrl", "/auth/login"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Error inesperado: " + e.getMessage()));
        }
    }

    public static class LoginRequest {
        private String email;
        private String password;

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }

    public static class RegistroRequest {
        private String nombre;
        private String email;
        private String password;

        public String getNombre() {
            return nombre;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }
}
