<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, modelo.Consulta, java.text.SimpleDateFormat" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Gestión de Consultas</title>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
        </head>

        <body class="font-main bg-secondary main-layout">
            <header class="navbar">
                <div class="container flex-container justify-space-between align-center">
                    <div class="navbar-brand">Vet<span class="text-highlight">Care</span></div>
                    <nav>
                        <ul class="list-style-none nav-links flex-container align-center">
                            <% modelo.Usuario u=(modelo.Usuario) session.getAttribute("usuario"); if (u instanceof
                                modelo.Veterinario) { %>
                                <li><a class="no-decoration text-light"
                                        href="<%=request.getContextPath()%>/vista/HomeVeterinario.jsp">Home</a></li>
                                <% } else { %>
                                    <li><a class="no-decoration text-light"
                                            href="<%=request.getContextPath()%>/vista/HomeCliente.jsp">Home</a></li>
                                    <% } %>

                                        <li><a class="no-decoration text-light"
                                                href="<%=request.getContextPath()%>/ControlConsulta?accion=ingresarModulo">Agenda/Consultas</a>
                                        </li>
                                        <li><a class="no-decoration text-light"
                                                href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a>
                                        </li>
                        </ul>
                    </nav>
                </div>
            </header>

            <main class="container">
                <section class="card">
                    <div class="flex-container justify-space-between align-center">
                        <h1>Lista de Consultas</h1>
                    </div>

                    <% String mensaje=(String) request.getAttribute("mensaje"); if (mensaje==null) {
                        jakarta.servlet.http.HttpSession userSession=request.getSession(false); if (userSession !=null)
                        { mensaje=(String) userSession.getAttribute("mensaje"); if (mensaje !=null) {
                        userSession.removeAttribute("mensaje"); } } } if (mensaje !=null) { %>
                        <div class="alert alert-info">
                            <%= mensaje %>
                        </div>
                        <% } %>

                            <% List<Consulta> consultas = (List<Consulta>) request.getAttribute("consultas"); %>
                                    <% if (consultas==null || consultas.isEmpty()) { %>
                                        <div class="alert alert-info">
                                            <p>No hay consultas encontradas.</p>
                                        </div>
                                        <% } else { %>
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Fecha</th>
                                                        <th>Hora</th>
                                                        <th>Mascota</th>
                                                        <th>Veterinario</th>
                                                        <th>Motivo</th>
                                                        <th>Estado</th>
                                                        <th>Acciones</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% SimpleDateFormat dateFormat=new SimpleDateFormat("dd/MM/yyyy");
                                                        SimpleDateFormat timeFormat=new SimpleDateFormat("HH:mm"); for
                                                        (Consulta c : consultas) { %>
                                                        <tr>
                                                            <td>
                                                                <%= c.getFecha() !=null ?
                                                                    dateFormat.format(c.getFecha()) : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= c.getHora() !=null ? timeFormat.format(c.getHora())
                                                                    : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= c.getMascota() !=null ? c.getMascota().getNombre()
                                                                    : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= c.getVeterinario() !=null ?
                                                                    c.getVeterinario().getNombre() + " " +
                                                                    c.getVeterinario().getApellido() : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= c.getMotivo() !=null ? c.getMotivo() : "-" %>
                                                            </td>
                                                            <td>
                                                                <span class="<%= " AGENDADA".equals(c.getEstado())
                                                                    ? "text-highlight" : "text-muted" %>">
                                                                    <%= c.getEstado() !=null ? c.getEstado() : "-" %>
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <!-- Acciones para cliente -->
                                                                <% if (u instanceof modelo.Cliente && "AGENDADA"
                                                                    .equals(c.getEstado())) { %>
                                                                    <a class="btn btn-sm btn-secondary"
                                                                        href="<%=request.getContextPath()%>/ControlConsulta?accion=cancelarConsulta&id=<%= c.getId() %>">Cancelar
                                                                        Consulta</a>
                                                                    <% } %>

                                                                        <!-- Acciones para veterinario -->
                                                                        <% if (u instanceof modelo.Veterinario) { if
                                                                            ("AGENDADA".equals(c.getEstado())) { %>
                                                                            <a class="btn btn-sm btn-primary"
                                                                                href="<%=request.getContextPath()%>/ControlConsulta?accion=iniciarAtencion&idConsulta=<%= c.getId() %>">Registrar
                                                                                Consulta</a>
                                                                            <% } else if
                                                                                ("ATENDIDA".equals(c.getEstado())) { %>
                                                                                <span class="text-muted">Atendida</span>
                                                                                <!-- Optional: Link to see details or edit -->
                                                                                <% } } %>
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                                </tbody>
                                            </table>
                                            <% } %>

                                                <div class="form-group margin-custom">
                                                    <% if (u instanceof modelo.Veterinario) { %>
                                                        <a class="btn btn-secondary"
                                                            href="<%=request.getContextPath()%>/vista/HomeVeterinario.jsp">Volver</a>
                                                        <% } else { %>
                                                            <a class="btn btn-secondary"
                                                                href="<%=request.getContextPath()%>/vista/HomeCliente.jsp">Volver</a>
                                                            <% } %>
                                                </div>
                                                </div>
                </section>
            </main>

            <footer class="footer">
                <p>VetCare - Gestión de Consultas</p>
            </footer>
        </body>

        </html>