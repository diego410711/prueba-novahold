<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <title>Formulario de Producto</title>
        <link rel="stylesheet" href="/css/styles.css">
    </head>

    <body>
        <h1>${producto.id == null ? "Nuevo Producto" : "Editar Producto"}</h1>
        <form action="/productos/guardar" method="post">
            <input type="hidden" name="id" value="${producto.id}">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" value="${producto.nombre}" required>
            <br>
            <label for="descripcion">Descripción:</label>
            <textarea id="descripcion" name="descripcion" required>${producto.descripcion}</textarea>
            <br>
            <label for="precio">Precio:</label>
            <input type="number" step="0.01" id="precio" name="precio" value="${producto.precio}" required>
            <br>
            <button type="submit">Guardar</button>
        </form>
        <a href="/productos">Volver a la lista</a>
    </body>

    </html>