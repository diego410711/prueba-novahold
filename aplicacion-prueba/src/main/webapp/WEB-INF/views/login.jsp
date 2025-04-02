<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <html>

        <head>
            <title>Login</title>
        </head>

        <body>
            <h2>Iniciar Sesión</h2>

            <%-- Mostrar error si existe --%>
                <c:if test="${not empty error}">
                    <div style="color: red;">${error}</div>
                </c:if>

                <form id="loginForm">
                    <label for="email">Correo:</label>
                    <input type="email" id="email" name="email" required>
                    <br>

                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" name="password" required>
                    <br>
                    <input type="hidden" id="csrfToken" value="${_csrf.token}" />
                    <button type="submit">Ingresar</button>
                </form>

                <script>
                    document.getElementById('loginForm').addEventListener('submit', function (event) {
                        event.preventDefault(); // Evitar el envío tradicional

                        const email = document.getElementById('email').value;
                        const password = document.getElementById('password').value;
                        const csrfToken = document.getElementById('csrfToken').value;

                        fetch("${pageContext.request.contextPath}/api/auth/login", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json",
                                "X-CSRF-TOKEN": csrfToken
                            },
                            body: JSON.stringify({ email, password })
                        })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error("Error en la autenticación.");
                                }
                                return response.json();
                            })
                            .then(data => {
                                console.log("Respuesta del servidor:", data);
                                if (data.redirectUrl) {
                                    let redirectPath = "${pageContext.request.contextPath}" + data.redirectUrl;
                                    console.log("Redirigiendo a:", redirectPath); // Verifica que la URL generada es correcta
                                    window.location.href = redirectPath;
                                } else {
                                    alert("Error: " + data.message);
                                }
                            })
                            .catch(error => console.error("Error en la petición: ", error));
                    });
                </script>

        </body>

        </html>