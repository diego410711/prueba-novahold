<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <html>

        <head>
            <title>Lista de Productos</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </head>

        <body class="d-flex justify-content-center align-items-center vh-100 bg-light">
            <style>
                .input-hidden {
                    display: none;
                }
            </style>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card shadow p-4">
                            <h3 class="text-center">Lista de Productos</h3>
                            <div class="d-grid">
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/productos/nuevo"
                                        class="btn btn-success btn-sm ">
                                        ➕ Agregar Producto
                                    </a>
                                </div>

                            </div>
                            <table class="table table-striped table-bordered table-hover">
                                <thead class="table-dark">
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
                        </div>
                    </div>
                </div>
            </div>

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
                                    console.error("ERROR: El producto no tiene ID:", producto);
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
                                editarBtn.classList.add("btn", "btn-warning", "btn-sm"); // Botón amarillo y pequeño
                                editarBtn.onclick = () => editarProducto(row, editarBtn);

                                // Botón Guardar
                                const guardarBtn = document.createElement("button");
                                guardarBtn.textContent = "Guardar";
                                guardarBtn.classList.add("btn", "btn-success", "btn-sm", "input-hidden"); // Botón verde y pequeño
                                guardarBtn.onclick = () => guardarProducto(row, guardarBtn);

                                // Botón Eliminar
                                const eliminarBtn = document.createElement("button");
                                eliminarBtn.textContent = "Eliminar";
                                eliminarBtn.classList.add("btn", "btn-danger", "btn-sm"); // Botón rojo y pequeño
                                eliminarBtn.onclick = () => eliminarProducto(row);


                                // Agregar acciones
                                accionesCell.appendChild(editarBtn);
                                accionesCell.appendChild(guardarBtn);
                                accionesCell.appendChild(document.createTextNode(" | "));
                                accionesCell.appendChild(eliminarBtn);

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

                function eliminarProducto(row) {
                    const id = row.querySelector("td:first-child span").textContent.trim(); // Asegurar que no haya espacios en blanco

                    if (!confirm("¿Seguro que deseas eliminar este producto?")) return;

                    fetch(`${pageContext.request.contextPath}/api/productos/eliminar`, {
                        method: "DELETE",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ id }) // Enviar el ID en el payload
                    })
                        .then(response => {
                            if (!response.ok) {
                                return response.text().then(errorMessage => {
                                    throw new Error(errorMessage || "Error desconocido al eliminar el producto.");
                                });
                            }
                            return response.text(); // Leer la respuesta como texto
                        })
                        .then(message => {
                            console.log(" Producto eliminado:", message);
                            alert("Producto eliminado correctamente.");
                            location.reload(); //  Recargar la página solo si fue exitoso
                        })
                        .catch(error => {
                            console.error("Error al eliminar el producto:", error);
                            alert("No se pudo eliminar el producto. Detalles: " + error.message);
                        });
                }

            </script>





        </body>

        </html>