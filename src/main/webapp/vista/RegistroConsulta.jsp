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
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/vista/HomeVeterinario.jsp">Home</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlConsulta?accion=ingresarModulo">Mi Agenda</a>
                        </li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <main class="main-content">
            <section class="container margin-custom">
                <div class="card">
                    <h1 class="margin-custom text-dark">Registrar Atención Médica</h1>

                    <div class="alert alert-danger" style="${empty mensaje ? 'display:none' : ''}">
                        ${mensaje}
                    </div>

                    <% modelo.Consulta consulta=(modelo.Consulta) request.getAttribute("consulta"); %>
                        <% if (consulta==null) { %>
                            <div class="alert alert-danger">
                                <p>No se encontró la consulta seleccionada.</p>
                                <a class="btn btn-secondary"
                                    href="<%=request.getContextPath()%>/ControlConsulta?accion=ingresarModulo">Volver
                                    a Mi Agenda</a>
                            </div>
                            <% } else { %>
                                <div class="alert alert-info">
                                    <p><strong>Paciente:</strong>
                                        <%= consulta.getMascota() !=null ? consulta.getMascota().getNombre() : "-" %>
                                    </p>
                                    <p><strong>Motivo Original:</strong>
                                        <%= consulta.getMotivo() !=null ? consulta.getMotivo() : "-" %>
                                    </p>
                                </div>

                                <form action="<%=request.getContextPath()%>/ControlConsulta" method="post">
                                    <input type="hidden" name="accion" value="registrarAtencion">
                                    <input type="hidden" name="idConsulta" value="<%= consulta.getId() %>">

                                    <div class="form-group"><label class="form-label">Síntomas</label>
                                        <textarea class="form-control" rows="3" name="sintomas"
                                            required><%= consulta.getSintomas() != null ? consulta.getSintomas() : "" %></textarea>
                                    </div>
                                    <div class="form-group"><label class="form-label">Diagnóstico</label>
                                        <textarea class="form-control" rows="3" name="diagnostico"
                                            required><%= consulta.getDiagnostico() != null ? consulta.getDiagnostico() : "" %></textarea>
                                    </div>
                                    <div class="form-group"><label class="form-label">Tratamiento</label>
                                        <textarea class="form-control" rows="3" name="tratamiento"
                                            required><%= consulta.getTratamiento() != null ? consulta.getTratamiento() : "" %></textarea>
                                    </div>
                                    <div class="form-group"><label class="form-label">Observaciones</label>
                                        <textarea class="form-control" rows="3"
                                            name="observaciones"><%= consulta.getObservaciones() != null ? consulta.getObservaciones() : "" %></textarea>
                                    </div>

                                    <div class="form-group flex-container justify-space-between">
                                        <button class="btn btn-primary" type="submit">Finalizar Atención</button>
                                        <a class="btn btn-secondary"
                                            href="<%=request.getContextPath()%>/ControlConsulta?accion=ingresarModulo">Cancelar</a>
                                    </div>
                                </form>
                                <% } %>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare - Registrar Consulta</p>
        </footer>
    </body>

    </html>