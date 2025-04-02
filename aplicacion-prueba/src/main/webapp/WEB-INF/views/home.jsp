<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <html>

        <head>
            <title>Lista de Productos</title>
            <link rel="stylesheet" href="/css/styles.css">
        </head>

        <body>
            <style>
                .input-hidden {
                    display: none;
                }
            </style>

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
                document.addEventListener("DOMContentLoaded", () => {
                    fetch(`${pageContext.request.contextPath}/api/productos`)
                        .then(response => response.json())
                        .then(data => {
                            console.log("Datos de productos:", data);

                            const tbody = document.getElementById("productos-table-body");
                            tbody.innerHTML = "";

                            data.forEach(producto => {
                                console.log("Id de producto:", producto.id);

                                if (!producto.id) {
                                    console.error("❌ ERROR: El producto no tiene ID:", producto);
                                    return;
                                }

                                const row = document.createElement("tr");

                                // Crear celdas correctamente alineadas
                                const idCell = crearCelda(producto.id, "text", true);
                                const nombreCell = crearCelda(producto.nombre, "text");
                                const descripcionCell = crearCelda(producto.descripcion, "text");
                                const precioCell = crearCelda(producto.precio, "number");

                                // Celda de acciones
                                const accionesCell = document.createElement("td");

                                // Botón Editar
                                const editarBtn = document.createElement("button");
                                editarBtn.textContent = "Editar";
                                editarBtn.onclick = () => editarProducto(row, editarBtn);

                                // Botón Guardar
                                const guardarBtn = document.createElement("button");
                                guardarBtn.textContent = "Guardar";
                                guardarBtn.classList.add("input-hidden");
                                guardarBtn.onclick = () => guardarProducto(row, guardarBtn);

                                // Enlace Eliminar
                                const eliminarLink = document.createElement("a");
                                eliminarLink.href = `${pageContext.request.contextPath}/productos/eliminar/${producto.id}`;
                                eliminarLink.textContent = "Eliminar";
                                eliminarLink.onclick = () => confirm("¿Seguro que deseas eliminar este producto?");

                                // Agregar acciones
                                accionesCell.appendChild(editarBtn);
                                accionesCell.appendChild(guardarBtn);
                                accionesCell.appendChild(document.createTextNode(" | "));
                                accionesCell.appendChild(eliminarLink);

                                // Agregar celdas a la fila
                                row.appendChild(idCell);
                                row.appendChild(nombreCell);
                                row.appendChild(descripcionCell);
                                row.appendChild(precioCell);
                                row.appendChild(accionesCell);

                                tbody.appendChild(row);
                            });
                        })
                        .catch(error => console.error("Error al cargar los productos:", error));
                });

                function crearCelda(valor, tipo, soloLectura = false) {
                    const cell = document.createElement("td");

                    // Crear el elemento span para mostrar el valor por defecto
                    const span = document.createElement("span");
                    span.textContent = valor;

                    // Crear el input para edición
                    const input = document.createElement("input");
                    input.type = tipo;
                    input.value = valor;
                    input.classList.add("input-hidden");

                    if (soloLectura) {
                        input.readOnly = true;
                    }

                    cell.appendChild(span);
                    cell.appendChild(input);
                    return cell;
                }

                function editarProducto(row, button) {
                    row.querySelectorAll("span").forEach(span => span.style.display = "none");
                    row.querySelectorAll("input:not([readonly])").forEach(input => input.style.display = "inline");

                    button.style.display = "none"; // Ocultar "Editar"
                    row.querySelector("button:nth-child(2)").style.display = "inline"; // Mostrar "Guardar"
                }
                function guardarProducto(row, button) {
                    const id = row.querySelector("input[readonly]").value; // ID fijo
                    const inputs = row.querySelectorAll("input:not([readonly])");

                    const nombre = inputs[0].value;
                    const descripcion = inputs[1].value;
                    const precio = parseFloat(inputs[2].value);

                    fetch(`${pageContext.request.contextPath}/api/productos/actualizar`, {
                        method: "PUT",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ id, nombre, descripcion, precio })
                    })
                        .then(response => {
                            if (!response.ok) throw new Error("Error en la actualización");
                            return response.json();
                        })
                        .then(data => {
                            console.log("Producto actualizado:", data);

                            // 🔄 Recargar la página automáticamente
                            location.reload();
                        })
                        .catch(error => {
                            console.error("Error al actualizar producto:", error);
                            alert("No se pudo actualizar el producto.");
                        });
                }

            </script>





        </body>

        </html>