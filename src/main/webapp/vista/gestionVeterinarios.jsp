<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, modelo.Veterinario" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Gestión de Veterinarios</title>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
        </head>

        <body class="font-main bg-secondary main-layout">
            <header class="navbar">
                <div class="container flex-container justify-space-between align-center">
                    <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Admin</div>
                    <nav>
                        <ul class="list-style-none nav-links flex-container align-center">
                            <li><a class="no-decoration text-light" href="home-admin.jsp">Home</a></li>
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/ControlUsuario?accion=listar">Gestión de
                                    Veterinarios</a></li>
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
                        <h1 class="text-dark">Gestión de Veterinarios</h1>
                        <a class="btn btn-primary" href="<%=request.getContextPath()%>/ControlUsuario?accion=formulario"
                            style="background-color: var(--color-highlight); color: var(--color-dark);">Registrar
                            Veterinario</a>
                    </div>

                    <div class="card">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Identificación</th>
                                    <th>Usuario</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Veterinario> lista = (List<Veterinario>) request.getAttribute("veterinarios");
                                        if(lista != null && !lista.isEmpty()) {
                                        for(Veterinario v : lista) {
                                        %>
                                        <tr>
                                            <td>
                                                <%= v.getNombre() %>
                                            </td>
                                            <td>
                                                <%= v.getIdentificacion() !=null ? v.getIdentificacion() : "N/A" %>
                                            </td>
                                            <td>
                                                <%= v.getUsuario() %>
                                            </td>
                                            <td>
                                                <span class="<%= " ACTIVO".equals(v.getEstado()) ? "text-highlight"
                                                    : "text-muted" %> font-bold">
                                                    <%= v.getEstado() %>
                                                </span>
                                            </td>
                                            <td>
                                                <a href="<%=request.getContextPath()%>/ControlUsuario?accion=formulario&id=<%=v.getId()%>"
                                                    class="btn btn-secondary padding-vertical"
                                                    style="background-color: #e0e0e0; color: #333;">Editar</a>

                                                <% if(!"INACTIVO".equals(v.getEstado())) { %>
                                                    <a href="<%=request.getContextPath()%>/ControlUsuario?accion=desactivar&id=<%=v.getId()%>"
                                                        class="btn btn-outline padding-vertical"
                                                        onclick="return confirm('¿Desactivar este veterinario?');">Desactivar</a>
                                                    <% } %>
                                            </td>
                                        </tr>
                                        <% } } else { %>
                                            <tr>
                                                <td colspan="5" class="text-center">No hay veterinarios registrados.
                                                </td>
                                            </tr>
                                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </section>
            </main>
            <footer class="footer">
                <p>VetCare - Admin</p>
            </footer>
        </body>

        </html>