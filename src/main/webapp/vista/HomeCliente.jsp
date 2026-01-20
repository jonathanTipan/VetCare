<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Cliente</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <header class="navbar">
            <div class="container flex-container justify-space-between align-center">
                <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Cliente</div>
                <nav>
                    <ul class="list-style-none nav-links flex-container align-center">
                        <li><a class="no-decoration text-light" href="home-cliente.jsp">Home</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlMascota?accion=ingresarModulo">Mis
                                Mascotas</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlCita?accion=ingresarModulo">Mis Citas</a>
                        </li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>
        <main class="main-content">
            <section class="container margin-custom">
                <h1 class="text-dark">Bienvenido, ${usuario.nombre}</h1>
                <div class="flex-container flex-wrap">
                    <div class="card card-light">
                        <h2>Mis Mascotas</h2>
                        <p>Gestiona la información de tus mascotas.</p>
                        <a class="btn btn-primary" style="margin-left: 0;"
                            href="<%=request.getContextPath()%>/ControlMascota?accion=ingresarModulo">Ver
                            Mascotas</a>
                    </div>
                    <div class="card card-light">
                        <h2>Agendar Consulta</h2>
                        <p>Programa una nueva consulta con el veterinario.</p>
                        <a class="btn btn-primary" style="margin-left: 0;"
                            href="<%=request.getContextPath()%>/ControlConsulta?accion=iniciarAgendamiento">Agendar</a>
                    </div>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare Cliente</p>
        </footer>
    </body>

    </html>