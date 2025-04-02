<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Registro</title>
        </head>

        <body>
            <h2>Registro de Usuario</h2>

            <%-- Mostrar error si existe --%>
                <c:if test="${not empty error}">
                    <div style="color: red;">${error}</div>
                </c:if>

                <form id="registroForm">
                    <label>Nombre:</label>
                    <input type="text" id="nombre" name="nombre" required><br>

                    <label>Email:</label>
                    <input type="email" id="email" name="email" required><br>

                    <label>Contraseña:</label>
                    <input type="password" id="password" name="password" required><br>

                    <input type="hidden" id="csrfToken" value="${_csrf.token}" />
                    <button type="submit">Registrar</button>
                </form>

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
                                    window.location.href = `${pageContext.request.contextPath}${data.redirectUrl}`;
                                } else if (data.message) {
                                    alert(data.message);
                                    window.location.href = `${pageContext.request.contextPath}/login`;
                                } else {
                                    alert("Registro exitoso. Ahora puedes iniciar sesión.");
                                    window.location.href = `${pageContext.request.contextPath}/login`;
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