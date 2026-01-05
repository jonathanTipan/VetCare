<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, modelo.Usuario" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Gestión de Usuarios</title>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
        </head>

        <body class="font-main bg-secondary main-layout">
            <header class="navbar">
                <div class="container flex-container justify-space-between align-center">
                    <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Admin</div>
                    <nav>
                        <ul class="list-style-none nav-links flex-container align-center">
                            <li><a class="no-decoration text-light" href="vista/home-admin.jsp">Home</a></li>
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/ControlUsuario?accion=listar">Usuarios</a></li>
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/AutenticarController?accion=logout">Salir</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </header>
            <main class="main-content">
                <section class="container margin-custom">
                    <h1 class="text-dark">Gestión de Usuarios</h1>

                    <div class="card bg-light">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Usuario</th>
                                    <th>Rol</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Usuario> lista = (List<Usuario>) request.getAttribute("usuarios");
                                        if(lista != null && !lista.isEmpty()) {
                                        for(Usuario user : lista) {
                                        %>
                                        <tr>
                                            <td>
                                                <%= user.getId() %>
                                            </td>
                                            <td>
                                                <%= user.getNombre() %>
                                            </td>
                                            <td>
                                                <%= user.getUsuario() %>
                                            </td>
                                            <td>
                                                <%= user.getRol() %>
                                            </td>
                                            <td>
                                                <%= user.getEstado() %>
                                            </td>
                                            <td>
                                                <!-- Placeholder actions -->
                                                <button class="btn btn-secondary padding-vertical">Editar</button>
                                            </td>
                                        </tr>
                                        <% } } else { %>
                                            <tr>
                                                <td colspan="6" class="text-center">No hay usuarios registrados.</td>
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