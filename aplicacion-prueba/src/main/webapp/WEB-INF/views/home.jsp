<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <title>Lista de Productos</title>
        <link rel="stylesheet" href="/css/styles.css">
    </head>

    <body>
        <h1>Lista de Productos</h1>
        <a href="/productos/nuevo">Agregar Producto</a>
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
            <tbody>
                <c:forEach var="producto" items="${productos}">
                    <tr>
                        <td>${producto.id}</td>
                        <td>${producto.nombre}</td>
                        <td>${producto.descripcion}</td>
                        <td>${producto.precio}</td>
                        <td>
                            <a href="/productos/editar/${producto.id}">Editar</a>
                            <a href="/productos/eliminar/${producto.id}"
                                onclick="return confirm('¿Seguro que deseas eliminar este producto?')">Eliminar</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>

    </html>