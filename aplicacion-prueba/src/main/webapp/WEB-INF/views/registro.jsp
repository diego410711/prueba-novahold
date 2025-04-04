<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Registro</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </head>

        <body class="d-flex justify-content-center align-items-center vh-100 bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card shadow-sm p-4">
                            <h2 class="text-center mb-4">Registro de Usuario</h2>

                            <%-- Mostrar error si existe --%>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger text-center">${error}</div>
                                </c:if>

                                <form id="registroForm">
                                    <div class="mb-3">
                                        <label for="nombre" class="form-label">Nombre:</label>
                                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email:</label>
                                        <input type="email" class="form-control" id="email" name="email" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label">Contraseña:</label>
                                        <input type="password" class="form-control" id="password" name="password"
                                            required>
                                    </div>

                                    <input type="hidden" id="csrfToken" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-primary w-100">Registrar</button>
                                </form>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                document.getElementById("registroForm").addEventListener("submit", function (event) {
                    event.preventDefault(); // Evita que la página se recargue

                    const nombre = document.getElementById("nombre").value;
                    const email = document.getElementById("email").value;
                    const password = document.getElementById("password").value;
                    const csrfToken = document.getElementById("csrfToken").value;

                    fetch(`${pageContext.request.contextPath}/api/auth/registro`, {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json",
                            "X-CSRF-TOKEN": csrfToken
                        },
                        body: JSON.stringify({ nombre, email, password })
                    })
                        .then(response => response.json())
                        .then(data => {
                            console.log("Respuesta del servidor:", data);
                            if (data.redirectUrl) {
                                window.location.href = `${pageContext.request.contextPath}/auth/login`;
                            } else if (data.message) {
                                alert(data.message);
                                window.location.href = `${pageContext.request.contextPath}/auth/login`;
                            } else {
                                alert("Registro exitoso. Ahora puedes iniciar sesión.");
                                window.location.href = `${pageContext.request.contextPath}/auth/login`;
                            }
                        })
                        .catch(error => {
                            console.error("Error en la petición: ", error);
                            alert("Ocurrió un error en el registro.");
                        });
                });
            </script>
        </body>

        </html>