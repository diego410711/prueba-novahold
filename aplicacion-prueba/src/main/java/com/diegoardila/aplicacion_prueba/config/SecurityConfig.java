package com.diegoardila.aplicacion_prueba.config;

import java.util.Collections;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.diegoardila.aplicacion_prueba.services.UsuarioService;

@Configuration
public class SecurityConfig {

        private final UsuarioService usuarioService;

        public SecurityConfig(UsuarioService usuarioService) {
                this.usuarioService = usuarioService;
        }

        @Bean
        public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
                http
                                .csrf().disable() // Desactiva CSRF para peticiones desde frontend (activar si usas
                                                  // formularios)
                                .authorizeHttpRequests(auth -> auth
                                                .antMatchers("/", "/home", "/auth/login", "/auth/registro").permitAll() // Vistas
                                                                                                                        // JSP
                                                                                                                        // permitidas
                                                .antMatchers("/api/auth/**").permitAll() // APIs públicas
                                                .antMatchers("/css/**", "/js/**", "/images/**").permitAll() // Recursos
                                                                                                            // estáticos
                                                .anyRequest().authenticated())
                                .sessionManagement(session -> session
                                                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)) // Permite
                                                                                                           // sesiones
                                                                                                           // en vistas
                                                                                                           // JSP
                                .formLogin(login -> login
                                                .loginPage("/auth/login") // Página de login
                                                .defaultSuccessUrl("/home", true) // Redirige a home tras login exitoso
                                                .permitAll())
                                .logout(logout -> logout
                                                .logoutUrl("/auth/logout")
                                                .logoutSuccessUrl("/auth/login")
                                                .permitAll())
                                .httpBasic(); // Permite autenticación básica para APIs

                return http.build();
        }

        @Bean
        public AuthenticationManager authenticationManager(UserDetailsService userDetailsService,
                        PasswordEncoder passwordEncoder) {
                DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
                authProvider.setUserDetailsService(userDetailsService);
                authProvider.setPasswordEncoder(passwordEncoder);
                return new ProviderManager(Collections.singletonList(authProvider));
        }

        @Bean
        public UserDetailsService userDetailsService() {
                return usuarioService;
        }
}
