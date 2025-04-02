package com.diegoardila.aplicacion_prueba.services;

import org.springframework.stereotype.Service;

import com.diegoardila.aplicacion_prueba.models.Producto;
import com.diegoardila.aplicacion_prueba.repository.ProductoRepository;

@Service
public class ProductoService {

    private final ProductoRepository productoRepository;

    public ProductoService(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public Producto guardarProducto(Producto producto) {
        return productoRepository.save(producto);
    }
}
