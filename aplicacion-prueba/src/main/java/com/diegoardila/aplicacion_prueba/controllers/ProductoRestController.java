package com.diegoardila.aplicacion_prueba.controllers;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.diegoardila.aplicacion_prueba.models.Producto;
import com.diegoardila.aplicacion_prueba.services.ProductoService;

@RestController
@RequestMapping("/api/productos")
public class ProductoRestController {

    private final ProductoService productoService;

    public ProductoRestController(ProductoService productoService) {
        this.productoService = productoService;
    }

    @PostMapping("/guardar")
    public ResponseEntity<?> guardarProducto(@RequestBody Producto producto) {
        try {
            Producto productoGuardado = productoService.guardarProducto(producto);
            return ResponseEntity.ok(Map.of("message", "Producto guardado", "producto", productoGuardado));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "Error al guardar: " + e.getMessage()));
        }
    }
}
