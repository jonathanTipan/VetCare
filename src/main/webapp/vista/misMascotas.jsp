<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, modelo.Mascota" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Mis Mascotas</title>
            <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
        </head>

        <body class="font-main bg-secondary main-layout">
            <header class="navbar">
                <div class="container flex-container justify-space-between align-center">
                    <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Cliente</div>
                    <nav>
                        <ul class="list-style-none nav-links flex-container align-center">
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/vista/home-cliente.jsp">Home</a></li>
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/ControlMascota?accion=listar">Mis Mascotas</a>
                            </li>
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/ControlAgendamiento?accion=listar">Mis Citas</a>
                            </li>
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
                        <h1 class="text-dark">Mis Mascotas</h1>
                        <a class="btn btn-primary" href="<%=request.getContextPath()%>/vista/registrarMascota.jsp">Nueva
                            Mascota</a>
                    </div>

                    <div class="card bg-light">
                        <% if(request.getAttribute("mensaje") !=null) { %>
                            <div class="padding-custom" style="color: green; font-weight: bold;">
                                <%= request.getAttribute("mensaje") %>
                            </div>
                            <% } %>

                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nombre</th>
                                            <th>Especie</th>
                                            <th>Raza</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<Mascota> lista = (List<Mascota>) request.getAttribute("mascotas");
                                                if(lista != null && !lista.isEmpty()) {
                                                for(Mascota m : lista) {
                                                %>
                                                <tr>
                                                    <td>
                                                        <%= m.getId() %>
                                                    </td>
                                                    <td>
                                                        <%= m.getNombre() %>
                                                    </td>
                                                    <td>
                                                        <%= m.getEspecie() %>
                                                    </td>
                                                    <td>
                                                        <%= m.getRaza() %>
                                                    </td>
                                                    <td>
                                                        <a class="btn btn-secondary padding-vertical"
                                                            href="#">Editar</a>
                                                        <form action="<%=request.getContextPath()%>/ControlMascota"
                                                            method="post" style="display:inline;">
                                                            <input type="hidden" name="accion" value="eliminar">
                                                            <input type="hidden" name="id" value="<%= m.getId() %>">
                                                            <button class="btn btn-outline padding-vertical"
                                                                type="submit"
                                                                onclick="return confirm('¿Seguro?');">Eliminar</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                                <% } } else { %>
                                                    <tr>
                                                        <td colspan="5" class="text-center">No tienes mascotas
                                                            registradas.</td>
                                                    </tr>
                                                    <% } %>
                                    </tbody>
                                </table>
                    </div>
                </section>
            </main>
            <footer class="footer">
                <p>VetCare - Mis Mascotas</p>
            </footer>
        </body>

        </html>