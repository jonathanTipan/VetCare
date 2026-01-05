<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registrar Consulta</title>
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
                <div class="card bg-light">
                    <h1 class="margin-custom text-dark">Registrar Consulta</h1>

                    <% if(request.getAttribute("mensaje") !=null) { %>
                        <div class="padding-custom bg-highlight rounded-lg margin-custom"
                            style="background-color: #d4edda; color: #155724;">
                            <%= request.getAttribute("mensaje") %>
                        </div>
                        <% } %>

                            <form action="<%=request.getContextPath()%>/ControlConsulta" method="post">
                                <!-- ID Cita passed from listing -->
                                <input type="hidden" name="idCita" value="<%= request.getParameter(" idCita") !=null ?
                                    request.getParameter("idCita") : "" %>">

                                <div class="form-group"><label class="form-label">Síntomas</label>
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
                                    <a class="btn btn-secondary"
                                        href="<%=request.getContextPath()%>/ControlAgendamiento?accion=agenda">Cancelar</a>
                                </div>
                            </form>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare - Registrar Consulta</p>
        </footer>
    </body>

    </html>