<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Registro</title>
    </head>

    <body>
        <h2>Registro de Usuario</h2>
        <form action="/auth/registro" method="post">
            <label>Nombre:</label>
            <input type="text" name="nombre" required><br>
            <label>Email:</label>
            <input type="email" name="email" required><br>
            <label>Contraseña:</label>
            <input type="password" name="password" required><br>
            <button type="submit">Registrar</button>
        </form>
    </body>

    </html>