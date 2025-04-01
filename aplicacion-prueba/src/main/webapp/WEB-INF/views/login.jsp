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

                <form action="${pageContext.request.contextPath}/auth/login" method="post">
                    <label for="email">Correo:</label>
                    <input type="email" id="email" name="email" required>
                    <br>

                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" name="password" required>
                    <br>
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <button type="submit">Ingresar</button>
                </form>
        </body>

        </html>