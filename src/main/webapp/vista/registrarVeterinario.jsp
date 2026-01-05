<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="modelo.Veterinario" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Registrar Veterinario</title>
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
                    <% Veterinario v=(Veterinario) request.getAttribute("veterinario"); boolean isEdit=(v !=null); %>

                        <div class="card">
                            <h1 class="margin-custom text-light">
                                <%= isEdit ? "Editar Veterinario" : "Registrar Veterinario" %>
                            </h1>

                            <form action="<%=request.getContextPath()%>/ControlUsuario" method="post">
                                <% if(isEdit) { %>
                                    <input type="hidden" name="id" value="<%= v.getId() %>">
                                    <% } %>

                                        <div class="form-group">
                                            <label class="form-label text-light">Nombre</label>
                                            <input class="form-control" type="text" name="nombre"
                                                value="<%= isEdit ? v.getNombre() : "" %>" required>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Identificación</label>
                                            <input class="form-control" type="text" name="identificacion"
                                                value="<%= isEdit && v.getIdentificacion() != null ? v.getIdentificacion() : "" %>"
                                                required>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Usuario</label>
                                            <input class="form-control" type="text" name="usuario"
                                                value="<%= isEdit ? v.getUsuario() : "" %>" required>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Especialidad</label>
                                            <input class="form-control" type="text" name="especialidad"
                                                value="<%= isEdit && v.getEspecialidad() != null ? v.getEspecialidad() : "" %>"
                                                required>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Teléfono</label>
                                            <input class="form-control" type="text" name="telefono"
                                                value="<%= isEdit && v.getTelefono() != null ? v.getTelefono() : "" %>">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Contraseña <%= isEdit
                                                    ? "(Dejar en blanco para no cambiar)" : "" %></label>
                                            <input class="form-control" type="password" name="clave" <%=isEdit ? ""
                                                : "required" %>>
                                        </div>

                                        <div class="form-group margin-top-custom">
                                            <button class="btn btn-primary" type="submit"
                                                style="background-color: var(--color-highlight); color: var(--color-dark);">Guardar</button>
                                            <a class="btn btn-secondary"
                                                href="<%=request.getContextPath()%>/ControlUsuario?accion=listar">Cancelar</a>
                                        </div>
                            </form>
                        </div>
                </section>
            </main>
            <footer class="footer">
                <p>VetCare - Admin</p>
            </footer>
        </body>

        </html>