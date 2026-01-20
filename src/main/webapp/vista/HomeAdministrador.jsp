<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <title>Home Admin</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <header class="navbar">
            <div class="container flex-container justify-space-between align-center">
                <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Admin</div>
                <nav>
                    <ul class="list-style-none nav-links flex-container align-center">
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/vista/HomeAdministrador.jsp">Home</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlVeterinario?accion=ingresarModulo">Usuarios</a>
                        </li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>
        <main class="main-content">
            <section class="container margin-custom">
                <h1 class="text-dark">Panel Administrativo</h1>
                <div class="flex-container flex-wrap">
                    <div class="card card-light">
                        <h2>Gestión de Usuarios</h2>
                        <p>Administra clientes y veterinarios.</p>
                        <a class="btn btn-primary" style="margin-left: 0;"
                            href="<%=request.getContextPath()%>/ControlVeterinario?accion=ingresarModulo">Gestionar</a>
                    </div>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare Admin</p>
        </footer>
    </body>

    </html>