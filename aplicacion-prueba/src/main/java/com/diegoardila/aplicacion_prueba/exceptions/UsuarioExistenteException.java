package com.diegoardila.aplicacion_prueba.exceptions;

public class UsuarioExistenteException extends RuntimeException {
    public UsuarioExistenteException(String message) {
        super(message);
    }
}
