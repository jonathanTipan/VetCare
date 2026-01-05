<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, modelo.Cita, modelo.Usuario" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Mis Citas</title>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
        </head>

        <body class="font-main bg-secondary main-layout">
            <% Usuario u=(Usuario) session.getAttribute("usuario"); String rol=(String) session.getAttribute("rol");
                String homeLink=request.getContextPath() + "/vista/home-cliente.jsp" ; if("VETERINARIO".equals(rol))
                homeLink=request.getContextPath() + "/vista/home-veterinario.jsp" ; %>
                <header class="navbar">
                    <div class="container flex-container justify-space-between align-center">
                        <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | <%= rol %>
                        </div>
                        <nav>
                            <ul class="list-style-none nav-links flex-container align-center">
                                <li><a class="no-decoration text-light" href="<%=homeLink%>">Home</a></li>
                                <% if("CLIENTE".equals(rol)) { %>
                                    <li><a class="no-decoration text-light"
                                            href="<%=request.getContextPath()%>/ControlMascota?accion=listar">Mis
                                            Mascotas</a></li>
                                    <li><a class="no-decoration text-light"
                                            href="<%=request.getContextPath()%>/ControlAgendamiento?accion=listar">Mis
                                            Citas</a></li>
                                    <% } else if("VETERINARIO".equals(rol)) { %>
                                        <li><a class="no-decoration text-light"
                                                href="<%=request.getContextPath()%>/ControlAgendamiento?accion=agenda">Mi
                                                Agenda</a></li>
                                        <% } %>
                                            <li><a class="no-decoration text-light"
                                                    href="<%=request.getContextPath()%>/AutenticarController?accion=logout">Salir</a>
                                            </li>
                            </ul>
                        </nav>
                    </div>
                </header>
                <main class="main-content">
                    <section class="container margin-custom">
                        <div class="flex-container justify-space-between align-center margin-custom">
                            <h1 class="text-dark">
                                <%= "VETERINARIO" .equals(rol) ? "Agenda de Citas" : "Mis Citas" %>
                            </h1>
                            <% if("CLIENTE".equals(rol)) { %>
                                <a class="btn btn-primary"
                                    href="<%=request.getContextPath()%>/ControlAgendamiento?accion=formulario">Agendar
                                    Cita</a>
                                <% } %>
                        </div>

                        <div class="card">
                            <table class="table text-light">
                                <thead>
                                    <tr>
                                        <% if("VETERINARIO".equals(rol)) { %>
                                            <th>Hora</th>
                                            <th>Mascota</th>
                                            <th>Cliente</th>
                                            <th>Motivo</th>
                                            <th>Acciones</th>
                                            <% } else { %>
                                                <th>Fecha</th>
                                                <th>Hora</th>
                                                <th>Mascota</th>
                                                <th>Motivo</th>
                                                <th>Estado</th>
                                                <% } %>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Cita> lista = (List<Cita>) request.getAttribute("citas");
                                            if(lista != null && !lista.isEmpty()) {
                                            for(Cita c : lista) {
                                            %>
                                            <tr>
                                                <% if("VETERINARIO".equals(rol)) { %>
                                                    <td>
                                                        <%= c.getHora() %>
                                                    </td>
                                                    <td>
                                                        <%= (c.getMascota() !=null) ? c.getMascota().getNombre() : "N/A"
                                                            %>
                                                    </td>
                                                    <td>
                                                        <%= (c.getMascota() !=null && c.getMascota().getCliente()
                                                            !=null) ? c.getMascota().getCliente().getNombre() : "N/A" %>
                                                    </td>
                                                    <td>
                                                        <%= c.getMotivo() %>
                                                    </td>
                                                    <td>
                                                        <% if(!"ATENDIDA".equals(c.getEstado())) { %>
                                                            <a class="btn btn-primary padding-vertical"
                                                                style="background-color: var(--color-highlight); color: var(--color-dark);"
                                                                href="<%=request.getContextPath()%>/ControlConsulta?accion=formulario&idCita=<%=c.getIdCita()%>">Atender
                                                                Consulta</a>
                                                            <% } else { %>
                                                                <span class="text-muted">Finalizada</span>
                                                                <% } %>
                                                    </td>
                                                    <% } else { %>
                                                        <td>
                                                            <%= c.getFecha() %>
                                                        </td>
                                                        <td>
                                                            <%= c.getHora() %>
                                                        </td>
                                                        <td>
                                                            <%= (c.getMascota() !=null) ? c.getMascota().getNombre()
                                                                : "N/A" %>
                                                        </td>
                                                        <td>
                                                            <%= c.getMotivo() %>
                                                        </td>
                                                        <td><span class="text-highlight font-bold">
                                                                <%= c.getEstado() %>
                                                            </span></td>
                                                        <% } %>
                                            </tr>
                                            <% } } else { %>
                                                <tr>
                                                    <td colspan="5" class="text-center">No hay citas registradas.</td>
                                                </tr>
                                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </section>
                </main>
                <footer class="footer">
                    <p>VetCare - Citas</p>
                </footer>
        </body>

        </html>