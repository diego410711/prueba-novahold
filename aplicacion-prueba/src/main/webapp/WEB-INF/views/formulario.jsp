<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <form id="productoForm">
            <input type="hidden" name="id" id="id" value="${producto.id}">

            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" value="${producto.nombre}" required>
            <br>

            <label for="descripcion">Descripción:</label>
            <textarea id="descripcion" name="descripcion" required>${producto.descripcion}</textarea>
            <br>

            <label for="precio">Precio:</label>
            <input type="number" step="0.01" id="precio" name="precio" value="${producto.precio}" required>
            <br>

            <button type="submit">Guardar</button>
        </form>

        <a href="/productos">Volver a la lista</a>

        <!-- JavaScript para enviar datos con fetch -->
        <script>
            document.getElementById("productoForm").addEventListener("submit", async function (event) {
                event.preventDefault(); // Evita la recarga de la página

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
                        window.location.href = "${pageContext.request.contextPath}/home"; // Redirige a la lista de productos
                    } else {
                        alert("Error: " + data.error);
                    }
                } catch (error) {
                    console.error("Error al enviar:", error);
                    alert("Ocurrió un error al guardar el producto.");
                }
            });
        </script>