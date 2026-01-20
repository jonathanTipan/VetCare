<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="modelo.Consulta" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Prescripción de Medicamentos</title>
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
                                    href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </header>

            <main class="container">
                <section class="card">
                    <h1>Prescripción de Medicamentos</h1>

                    <% Consulta consulta=(Consulta) request.getAttribute("consulta"); %>
                        <% if (consulta !=null) { %>
                            <div class="info-box">
                                <h3>Consulta #<%= consulta.getId() %>
                                </h3>
                                <p><strong>Diagnóstico:</strong>
                                    <%= consulta.getDiagnostico() %>
                                </p>
                            </div>
                            <% } %>

                                <form action="<%=request.getContextPath()%>/ControlRecetas" method="post">
                                    <input type="hidden" name="accion" value="registrarReceta">
                                    <input type="hidden" name="idConsulta"
                                        value="<%= consulta != null ? consulta.getId() : "" %>">

                                    <div class="form-group">
                                        <label class="form-label" for="medicamento">Medicamento</label>
                                        <input class="form-control" type="text" id="medicamento" name="medicamento"
                                            required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="dosis">Dosis</label>
                                        <input class="form-control" type="text" id="dosis" name="dosis" required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="frecuencia">Frecuencia</label>
                                        <input class="form-control" type="text" id="frecuencia" name="frecuencia"
                                            required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="duracion">Duración</label>
                                        <input class="form-control" type="text" id="duracion" name="duracion" required>
                                    </div>

                                    <div class="form-group">
                                        <button class="btn btn-primary" type="submit">Prescribir Medicamento</button>
                                        <a class="btn btn-outline"
                                            href="<%=request.getContextPath()%>/vista/HomeVeterinario.jsp">Cancelar</a>
                                    </div>
                                </form>
                </section>
            </main>
        </body>

        </html>