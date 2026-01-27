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
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/vista/HomeAdministrador.jsp">Home</a></li>

                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </header>
            <main class="main-content">
                <section class="container margin-custom">
                    <div class="card">
                        <div class="flex-container justify-space-between align-center margin-custom">
                            <h1 class="text-dark">Gestión de Veterinarios</h1>
                            <a class="btn btn-primary"
                                href="<%=request.getContextPath()%>/ControlVeterinario?accion=iniciarRegistro">Registrar
                                Veterinario</a>
                        </div>

                        <% String mensaje=(String) request.getSession().getAttribute("mensaje"); if (mensaje !=null) {
                            %>
                            <div class="alert alert-info">
                                <%= mensaje %>
                            </div>
                            <% request.getSession().removeAttribute("mensaje"); } %>

                                <% String mensajeConfirmacion=(String) request.getAttribute("mensajeConfirmacion");
                                    String cedulaDesactivar=(String) request.getAttribute("cedulaDesactivar"); if
                                    (mensajeConfirmacion !=null) { %>
                                    <div class="alert alert-warning">
                                        <p>
                                            <%= mensajeConfirmacion %>
                                        </p>
                                        <div class="flex-container" style="gap: 10px; margin-top: 10px;">
                                            <a href="<%=request.getContextPath()%>/ControlVeterinario?accion=desactivarVeterinario&cedula=<%=cedulaDesactivar%>"
                                                class="btn btn-danger">Confirmar</a>
                                            <a href="<%=request.getContextPath()%>/ControlVeterinario?accion=cancelar"
                                                class="btn btn-secondary">Cancelar</a>
                                        </div>
                                    </div>
                                    <% } %>

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
                                                <% List<Veterinario> lista = (List<Veterinario>)
                                                        request.getAttribute("veterinarios");
                                                        if(lista != null && !lista.isEmpty()) {
                                                        for(Veterinario v : lista) {
                                                        %>
                                                        <tr>
                                                            <td>
                                                                <%= v.getNombre() %>
                                                            </td>
                                                            <td>
                                                                <%= v.getCedula() !=null ? v.getCedula() : "N/A" %>
                                                            </td>
                                                            <td>
                                                                <%= v.getUsuario() %>
                                                            </td>
                                                            <td>
                                                                <span class="<%= " ACTIVO".equals(v.getEstado())
                                                                    ? "text-highlight" : "text-muted" %> font-bold">
                                                                    <%= v.getEstado() %>
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <div class="flex-container">
                                                                    <a href="<%=request.getContextPath()%>/ControlVeterinario?accion=iniciarEdicion&cedula=<%=v.getCedula()%>"
                                                                        class="btn btn-sm btn-outline">Editar</a>

                                                                    <% if(!"INACTIVO".equals(v.getEstado())) { %>
                                                                        <a href="<%=request.getContextPath()%>/ControlVeterinario?accion=iniciarDesactivacion&cedula=<%=v.getCedula()%>"
                                                                            class="btn btn-sm btn-danger">Desactivar</a>
                                                                        <% } %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <% } } else { %>
                                                            <tr>
                                                                <td colspan="5" class="text-center">No hay veterinarios
                                                                    registrados.
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