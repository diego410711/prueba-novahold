<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <html>

        <head>
            <title>Lista de Productos</title>
            <link rel="stylesheet" href="/css/styles.css">
        </head>

        <body>
            <h1>Lista de Productos</h1>
            <a href="${pageContext.request.contextPath}/productos/nuevo">Agregar Producto</a>
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="productos-table-body">
                    <!-- Los productos se insertarán aquí dinámicamente -->
                </tbody>
            </table>

            <script>
                fetch("${pageContext.request.contextPath}/api/productos")
                    .then(response => response.json())
                    .then(data => {
                        const tbody = document.getElementById("productos-table-body");
                        tbody.innerHTML = ""; // Limpiar contenido anterior

                        data.forEach(producto => {
                            const row = document.createElement("tr");

                            const idCell = document.createElement("td");
                            idCell.textContent = producto.id;

                            const nombreCell = document.createElement("td");
                            nombreCell.textContent = producto.nombre;

                            const descripcionCell = document.createElement("td");
                            descripcionCell.textContent = producto.descripcion;

                            const precioCell = document.createElement("td");
                            precioCell.textContent = producto.precio;

                            const accionesCell = document.createElement("td");
                            accionesCell.innerHTML = `
                <a href="/productos/editar/${producto.id}">Editar</a>
                <a href="/productos/eliminar/${producto.id}" onclick="return confirm('¿Seguro que deseas eliminar este producto?')">Eliminar</a>
            `;

                            row.appendChild(idCell);
                            row.appendChild(nombreCell);
                            row.appendChild(descripcionCell);
                            row.appendChild(precioCell);
                            row.appendChild(accionesCell);

                            tbody.appendChild(row);
                        });
                    })
                    .catch(error => console.error("Error al cargar los productos:", error));
            </script>
        </body>

        </html>