<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <title>Home Veterinario</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <header class="navbar">
            <div class="container flex-container justify-space-between align-center">
                <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Veterinario</div>
                <nav>
                    <ul class="list-style-none nav-links flex-container align-center">
                        <li><a class="no-decoration text-light" href="home-veterinario.jsp">Home</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlAgendamiento?accion=agenda">Mi Agenda</a>
                        </li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/AutenticarController?accion=logout">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>
        <main class="main-content">
            <section class="container margin-custom">
                <h1 class="text-dark">Panel Veterinario - ${usuario.nombre}</h1>
                <div class="flex-container flex-wrap">
                    <div class="card card-light">
                        <h2>Citas Pendientes</h2>
                        <p>Revisa las citas agendadas para hoy.</p>
                        <a class="btn btn-primary"
                            href="<%=request.getContextPath()%>/ControlAgendamiento?accion=agenda">Ver Agenda</a>
                    </div>
                    <div class="card card-light">
                        <h2>Registrar Consulta</h2>
                        <p>Atender un paciente manualmente.</p>
                        <a class="btn btn-primary"
                            href="<%=request.getContextPath()%>/vista/registrarConsulta.jsp">Nueva Consulta</a>
                    </div>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare Veterinario</p>
        </footer>
    </body>

    </html>