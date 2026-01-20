<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, modelo.Mascota, jakarta.servlet.http.HttpSession" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Gestión de Mascotas</title>
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
                                    Mascotas</a>
                            </li>
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/ControlCita?accion=ingresarModulo">Mis Citas</a>
                            </li>
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </header>

            <main class="main-content">
                <section class="container">
                    <div class="card">
                        <div class="flex-container justify-space-between align-center margin-custom">
                            <h1 class="text-dark">Mis Mascotas</h1>
                            <a class="btn btn-primary"
                                href="<%=request.getContextPath()%>/ControlMascota?accion=iniciarRegistro">Registrar
                                Mascota</a>
                        </div>


                        <% String mensaje=(String) request.getAttribute("mensaje"); if (mensaje==null) { HttpSession
                            userSession=request.getSession(false); if (userSession !=null) { mensaje=(String)
                            userSession.getAttribute("mensaje"); if (mensaje !=null) {
                            userSession.removeAttribute("mensaje"); } } } if (mensaje !=null) { %>
                            <div class="alert alert-info">
                                <%= mensaje %>
                            </div>
                            <% } %>

                                <% List<Mascota> mascotas = (List<Mascota>) request.getAttribute("mascotas"); %>
                                        <% if (mascotas==null || mascotas.isEmpty()) { %>
                                            <div class="alert alert-info">
                                                <p>No tienes mascotas registradas.</p>
                                            </div>
                                            <% } else { %>
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Nombre</th>
                                                            <th>Especie</th>
                                                            <th>Raza</th>
                                                            <th>Fecha de Nacimiento</th>
                                                            <th>Sexo</th>
                                                            <th>Peso (kg)</th>
                                                            <th>Acciones</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for (Mascota m : mascotas) { %>
                                                            <tr>
                                                                <td>
                                                                    <%= m.getNombre() %>
                                                                </td>
                                                                <td>
                                                                    <%= m.getEspecie() %>
                                                                </td>
                                                                <td>
                                                                    <%= m.getRaza() !=null ? m.getRaza() : "-" %>
                                                                </td>
                                                                <td>
                                                                    <%= m.getFechaNacimiento() !=null ? new
                                                                        java.text.SimpleDateFormat("dd/MM/yyyy").format(m.getFechaNacimiento())
                                                                        : "-" %>
                                                                </td>
                                                                <td>
                                                                    <%= m.getSexo() !=null ? m.getSexo() : "-" %>
                                                                </td>
                                                                <td>
                                                                    <%= m.getPeso()> 0 ? String.format("%.2f",
                                                                        m.getPeso()) : "-" %>
                                                                </td>
                                                                <td>
                                                                    <div class="flex-container">
                                                                        <a class="btn btn-sm btn-outline"
                                                                            href="<%=request.getContextPath()%>/ControlMascota?accion=iniciarEdicion&id=<%= m.getId() %>">Editar</a>
                                                                        <a class="btn btn-sm btn-danger"
                                                                            href="<%=request.getContextPath()%>/ControlMascota?accion=eliminarMascota&id=<%= m.getId() %>"
                                                                            onclick="return confirm('¿Está seguro de eliminar esta mascota?')">Eliminar</a>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                                    </tbody>
                                                </table>
                                                <% } %>
                    </div>
                </section>
            </main>
            <footer class="footer">
                <p>VetCare - Gestión de Mascotas</p>
            </footer>
        </body>

        </html>