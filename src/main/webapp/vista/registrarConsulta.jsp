<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registrar Consulta</title>
        <link rel="stylesheet" href="../framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <header class="navbar">
            <div class="container flex-container justify-space-between align-center">
                <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Veterinario</div>
                <nav>
                    <ul class="list-style-none nav-links flex-container align-center">
                        <li><a class="no-decoration text-light" href="home-veterinario.html">Home</a></li>
                        <li><a class="no-decoration text-light" href="mi-agenda.html">Mi Agenda</a></li>
                        <li><a class="no-decoration text-light" href="mis-horarios.html">Mis Horarios</a></li>
                        <li><a class="no-decoration text-light" href="mi-perfil-veterinario.html">Mi Perfil</a></li>
                        <li><a class="no-decoration text-light" href="index.html">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <main class="main-content">
            <section class="container">
                <div class="card">
                    <h1 class="margin-custom">Registrar Consulta</h1>

                    <% if(request.getAttribute("mensaje") !=null) { %>
                        <div class="alert alert-info">
                            <%= request.getAttribute("mensaje") %>
                        </div>
                        <% } %>

                            <form action="<%=request.getContextPath()%>/ControlConsulta" method="post">
                                <!-- ID Cita is usually passed from a previous selection, assuming hidden here or passed via GET -->
                                <input type="hidden" name="idCita" value="1">

                                <div class="form-group"><label class="form-label">Sintomas</label>
                                    <textarea class="form-control" rows="3" name="sintomas" required></textarea>
                                </div>
                                <div class="form-group"><label class="form-label">Diagnóstico</label>
                                    <textarea class="form-control" rows="3" name="diagnostico" required></textarea>
                                </div>
                                <div class="form-group"><label class="form-label">Tratamiento</label>
                                    <textarea class="form-control" rows="3" name="tratamiento" required></textarea>
                                </div>

                                <div class="form-group">
                                    <button class="btn btn-primary" type="submit">Registrar Consulta</button>
                                    <a class="btn btn-secondary" href="mi-agenda.html">Cancelar</a>
                                </div>
                            </form>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>Registrar Consulta</p>
        </footer>
    </body>

    </html>