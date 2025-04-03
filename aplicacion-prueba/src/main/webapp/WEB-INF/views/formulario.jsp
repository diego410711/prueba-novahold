<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Formulario de Producto</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </head>

        <body class="d-flex justify-content-center align-items-center vh-100 bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card shadow p-4">
                            <h3 class="text-center">Formulario de Producto</h3>
                            <form id="productoForm">
                                <input type="hidden" name="id" id="id" value="${producto.id}">

                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre:</label>
                                    <input type="text" id="nombre" name="nombre" class="form-control"
                                        value="${producto.nombre}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="descripcion" class="form-label">Descripción:</label>
                                    <textarea id="descripcion" name="descripcion" class="form-control"
                                        required>${producto.descripcion}</textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="precio" class="form-label">Precio:</label>
                                    <input type="number" step="0.01" id="precio" name="precio" class="form-control"
                                        value="${producto.precio}" required>
                                </div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">Guardar</button>
                                </div>
                            </form>
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Volver a la
                                    lista</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                document.getElementById("productoForm").addEventListener("submit", async function (event) {
                    event.preventDefault();

                    const producto = {
                        id: document.getElementById("id").value || null,
                        nombre: document.getElementById("nombre").value,
                        descripcion: document.getElementById("descripcion").value,
                        precio: parseFloat(document.getElementById("precio").value)
                    };

                    try {
                        const response = await fetch("${pageContext.request.contextPath}/api/productos/guardar", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json"
                            },
                            body: JSON.stringify(producto)
                        });

                        const data = await response.json();
                        if (response.ok) {
                            alert("Producto guardado exitosamente");
                            window.location.href = "${pageContext.request.contextPath}/home";
                        } else {
                            alert("Error: " + data.error);
                        }
                    } catch (error) {
                        console.error("Error al enviar:", error);
                        alert("Ocurrió un error al guardar el producto.");
                    }
                });
            </script>
        </body>

        </html>