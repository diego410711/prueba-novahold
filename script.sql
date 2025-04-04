CREATE DATABASE aplicacion_prueba;
USE aplicacion_prueba;

CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    nombre VARCHAR(255),
    password VARCHAR(255) NOT NULL
);

INSERT INTO usuarios (email, nombre, password) VALUES
('usuario1@example.com', 'Usuario Uno', 'password123'),
('usuario2@example.com', 'Usuario Dos', 'password456');

INSERT INTO productos (nombre, descripcion, precio) VALUES
('Producto A', 'Descripción del Producto A', 100.00),
('Producto B', 'Descripción del Producto B', 200.50),
('Producto C', 'Descripción del Producto C', 300.75);
