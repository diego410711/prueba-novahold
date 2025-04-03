<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f9fa;
        }

        .login-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <h2 class="text-center mb-4">Iniciar Sesión</h2>

        <!-- Mostrar error si existe -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form id="loginForm">
            <div class="mb-3">
                <label for="email" class="form-label">Correo:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Contraseña:</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>

            <input type="hidden" id="csrfToken" value="${_csrf.token}" />

            <button type="submit" class="btn btn-primary w-100">Ingresar</button>
        </form>
    </div>

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
                        console.log("Redirigiendo a:", redirectPath);
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