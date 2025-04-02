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
                                console.log("Id de productos:", producto.id);

                                const productoId = producto.id;
                                console.log("Variable de id", productoId);


                                if (!productoId) {
                                    console.error("❌ ERROR: El producto no tiene ID:", producto);
                                    return;
                                }

                                const row = document.createElement("tr");

                                // Crear celdas
                                const idCell = document.createElement("td");
                                idCell.textContent = productoId;
                                const idInput = document.createElement("input");
                                idInput.type = "text";
                                idInput.value = producto.id;
                                idInput.classList.add("input-hidden");

                                idCell.appendChild(idInput);


                                const nombreCell = document.createElement("td");
                                const nombreSpan = document.createElement("span");
                                nombreSpan.textContent = producto.nombre;
                                const nombreInput = document.createElement("input");
                                nombreInput.type = "text";
                                nombreInput.value = producto.nombre;
                                nombreInput.classList.add("input-hidden");

                                nombreCell.appendChild(nombreSpan);
                                nombreCell.appendChild(nombreInput);

                                const descripcionCell = document.createElement("td");
                                const descripcionSpan = document.createElement("span");
                                descripcionSpan.textContent = producto.descripcion;
                                const descripcionInput = document.createElement("input");
                                descripcionInput.type = "text";
                                descripcionInput.value = producto.descripcion;
                                descripcionInput.classList.add("input-hidden");

                                descripcionCell.appendChild(descripcionSpan);
                                descripcionCell.appendChild(descripcionInput);

                                const precioCell = document.createElement("td");
                                const precioSpan = document.createElement("span");
                                precioSpan.textContent = producto.precio;
                                const precioInput = document.createElement("input");
                                precioInput.type = "number";
                                precioInput.value = producto.precio;
                                precioInput.classList.add("input-hidden");

                                precioCell.appendChild(precioSpan);
                                precioCell.appendChild(precioInput);

                                const accionesCell = document.createElement("td");

                                // Botón Editar
                                const editarBtn = document.createElement("button");
                                editarBtn.textContent = "Editar";
                                editarBtn.onclick = () => editarProducto(editarBtn);

                                // Botón Guardar
                                const guardarBtn = document.createElement("button");
                                guardarBtn.textContent = "Guardar";
                                guardarBtn.classList.add("input-hidden");
                                guardarBtn.onclick = () => guardarProducto(guardarBtn);

                                // Enlace Eliminar
                                const eliminarLink = document.createElement("a");
                                eliminarLink.href = `${pageContext.request.contextPath}/productos/eliminar/${productoId}`;
                                eliminarLink.textContent = "Eliminar";
                                eliminarLink.onclick = () => confirm("¿Seguro que deseas eliminar este producto?");

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

                function editarProducto(button) {
                    const row = button.closest("tr");

                    row.querySelectorAll("span").forEach(span => span.style.display = "none");
                    row.querySelectorAll("input").forEach(input => input.style.display = "inline");

                    button.style.display = "none"; // Ocultar botón "Editar"
                    row.querySelector("button:nth-child(2)").style.display = "inline"; // Mostrar "Guardar"
                }
                function guardarProducto(button) {
                    const row = button.closest("tr");
                    const inputs = row.querySelectorAll("input");
                    const id = inputs[0].value;
                    const nombre = inputs[1].value;
                    const descripcion = inputs[2].value;
                    const precio = parseFloat(inputs[3].value);

                    fetch(`${pageContext.request.contextPath}/api/productos/actualizar`, { // Cambia la URL a un endpoint genérico
                        method: "PUT",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify({ id, nombre, descripcion, precio }) // Agrega el ID al payload
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error("Error en la actualización");
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log("Producto actualizado:", data);

                            // Mostrar valores actualizados en la tabla
                            const spans = row.querySelectorAll("span");
                            spans[0].textContent = nombre;
                            spans[1].textContent = descripcion;
                            spans[2].textContent = precio;

                            // Restaurar la vista normal
                            row.querySelectorAll("span").forEach(span => span.style.display = "inline");
                            row.querySelectorAll("input").forEach(input => input.style.display = "none");

                            row.querySelector("button:nth-child(1)").style.display = "inline"; // Mostrar "Editar"
                            row.querySelector("button:nth-child(2)").style.display = "none"; // Ocultar "Guardar"
                        })
                        .catch(error => {
                            console.error("Error al actualizar producto:", error);
                            alert("No se pudo actualizar el producto.");
                        });
                }


            </script>



        </body>

        </html>