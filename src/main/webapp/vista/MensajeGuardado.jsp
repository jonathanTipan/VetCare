<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <title>Guardado</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <main class="container">
            <section class="card">
                <div class="alert alert-success">
                    <h1>✓ Guardado Exitoso</h1>
                    <p>
                        <%= request.getAttribute("mensaje") !=null ? request.getAttribute("mensaje")
                            : "Los datos se guardaron correctamente." %>
                    </p>
                </div>

                <div class="form-group">
                    <a class="btn btn-primary" href="<%=request.getAttribute(" redirectUrl") !=null ?
                        request.getAttribute("redirectUrl") : "javascript:history.back()" %>">Continuar</a>
                </div>
            </section>
        </main>
    </body>

    </html>