<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Agendar Consulta</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <header class="navbar">
            <div class="container flex-container justify-space-between align-center">
                <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Cliente</div>
                <nav>
                    <ul class="list-style-none nav-links flex-container align-center">
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/vista/HomeCliente.jsp">Home</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlMascota?accion=ingresarModulo">Mis
                                Mascotas</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlConsulta?accion=ingresarModulo">Mis
                                Consultas</a>
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
                    <h1 class="margin-custom text-dark">Agendar Consulta</h1>

                    <div class="alert alert-danger" style="${empty mensaje ? 'display:none' : ''}">
                        ${mensaje}
                    </div>

                    <% java.util.List<modelo.Mascota> mascotas = (java.util.List<modelo.Mascota>)
                            request.getAttribute("mascotas");
                            if (mascotas == null || mascotas.isEmpty()) {
                            %>
                            <div class="alert alert-warning">
                                <p>No tienes mascotas registradas. Debes registrar una mascota antes de agendar
                                    una consulta.</p>
                                <a href="<%=request.getContextPath()%>/ControlMascota?accion=iniciarRegistro"
                                    class="btn btn-primary">Registrar Mascota</a>
                            </div>
                            <% } else { %>
                                <form action="<%=request.getContextPath()%>/ControlConsulta" method="post">
                                    <input type="hidden" name="accion" value="agendarConsulta">
                                    <div class="form-group"><label class="form-label">Mascota</label>
                                        <select class="form-select" name="idMascota" required>
                                            <% for(modelo.Mascota m : mascotas) { %>
                                                <option value="<%=m.getId()%>">
                                                    <%=m.getNombre()%> (<%=m.getEspecie()%>)
                                                </option>
                                                <% } %>
                                        </select>
                                    </div>

                                    <div class="form-group"><label class="form-label">Veterinario</label>
                                        <select class="form-select" name="idVeterinario" required>
                                            <option value="">Seleccione un veterinario...</option>
                                            <% java.util.List<modelo.Veterinario> veterinarios = (java.util.List
                                                <modelo.Veterinario>) request.getAttribute("veterinarios");
                                                    if(veterinarios != null) {
                                                    for(modelo.Veterinario v : veterinarios) { %>
                                                    <option value="<%=v.getCedula()%>">
                                                        <%=v.getNombre()%>
                                                            <%=v.getApellido()%>
                                                    </option>
                                                    <% } } %>
                                        </select>
                                    </div>

                                    <div class="form-group"><label class="form-label">Fecha</label>
                                        <input class="form-control" type="date" name="fecha" required>
                                    </div>

                                    <div class="form-group"><label class="form-label">Hora</label>
                                        <select class="form-select" name="hora" required>
                                            <option value="">Seleccione una hora...</option>
                                            <option value="09:00">09:00</option>
                                            <option value="09:30">09:30</option>
                                            <option value="10:00">10:00</option>
                                            <option value="10:30">10:30</option>
                                            <option value="11:00">11:00</option>
                                            <option value="11:30">11:30</option>
                                            <option value="12:00">12:00</option>
                                            <option value="12:30">12:30</option>
                                            <option value="14:00">14:00</option>
                                            <option value="14:30">14:30</option>
                                            <option value="15:00">15:00</option>
                                            <option value="15:30">15:30</option>
                                            <option value="16:00">16:00</option>
                                            <option value="16:30">16:30</option>
                                            <option value="17:00">17:00</option>
                                            <option value="17:30">17:30</option>
                                            <option value="18:00">18:00</option>
                                        </select>
                                    </div>

                                    <div class="form-group"><label class="form-label">Motivo de consulta</label>
                                        <textarea class="form-control" rows="3" name="motivo" required></textarea>
                                    </div>
                                    <div class="form-group flex-container justify-space-between">
                                        <button class="btn btn-primary" type="submit">Confirmar</button>
                                        <a class="btn btn-secondary"
                                            href="<%=request.getContextPath()%>/ControlConsulta?accion=ingresarModulo">Cancelar</a>
                                    </div>
                                </form>
                                <% } %>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare - Agendar Consulta</p>
        </footer>
    </body>

    </html>