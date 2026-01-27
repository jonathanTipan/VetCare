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



                    <form action="<%=request.getContextPath()%>/ControlConsulta" method="post">
                        <% Consulta consulta=(Consulta) request.getAttribute("consulta"); %>
                            <input type="hidden" name="accion" value="registrarReceta">
                            <input type="hidden" name="idConsulta"
                                value="<%= consulta != null ? consulta.getId() : "" %>">

                            <!-- Hidden fields to persist attention data -->
                            <input type="hidden" name="sintomas"
                                value="<%= consulta != null && consulta.getSintomas() != null ? consulta.getSintomas() : "" %>">
                            <input type="hidden" name="diagnostico"
                                value="<%= consulta != null && consulta.getDiagnostico() != null ? consulta.getDiagnostico() : "" %>">
                            <input type="hidden" name="tratamiento"
                                value="<%= consulta != null && consulta.getTratamiento() != null ? consulta.getTratamiento() : "" %>">
                            <input type="hidden" name="observaciones"
                                value="<%= consulta != null && consulta.getObservaciones() != null ? consulta.getObservaciones() : "" %>">

                            <div class="form-group">
                                <label class="form-label" for="medicamento">Medicamento</label>
                                <input class="form-control" type="text" id="medicamento" name="medicamento" required
                                    oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                    oninput="this.setCustomValidity('')">
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="dosis">Dosis</label>
                                <input class="form-control" type="text" id="dosis" name="dosis" required
                                    oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                    oninput="this.setCustomValidity('')">
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="frecuencia">Frecuencia</label>
                                <input class="form-control" type="text" id="frecuencia" name="frecuencia" required
                                    oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                    oninput="this.setCustomValidity('')">
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="duracion">Duración</label>
                                <input class="form-control" type="text" id="duracion" name="duracion" required
                                    oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                    oninput="this.setCustomValidity('')">
                            </div>

                            <div class="form-group">
                                <button class="btn btn-primary" type="submit">Prescribir Medicamento</button>
                                <button class="btn btn-outline" type="submit" name="accion" value="cancelarPrescripcion"
                                    formnovalidate>Cancelar</button>
                            </div>
                    </form>
                </section>
            </main>
        </body>

        </html>