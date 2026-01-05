<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
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
                                href="<%=request.getContextPath()%>/ControlMascota?accion=listar">Mis Mascotas</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlAgendamiento?accion=listar">Mis Citas</a>
                        </li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/AutenticarController?accion=logout">Salir</a></li>
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
                        <a class="btn btn-primary" href="<%=request.getContextPath()%>/ControlMascota?accion=listar">Ver
                            Mascotas</a>
                    </div>
                    <div class="card card-light">
                        <h2>Agendar Cita</h2>
                        <p>Programa una nueva cita con el veterinario.</p>
                        <a class="btn btn-primary"
                            href="<%=request.getContextPath()%>/vista/agendarCita.jsp">Agendar</a>
                    </div>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare Cliente</p>
        </footer>
    </body>

    </html>