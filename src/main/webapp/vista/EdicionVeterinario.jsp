<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="modelo.Veterinario" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Editar Veterinario</title>
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
                                    href="<%=request.getContextPath()%>/ControlVeterinario?accion=ingresarModulo">Gestión
                                    de
                                    Veterinarios</a></li>
                            <li><a class="no-decoration text-light"
                                    href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </header>
            <main class="main-content">
                <section class="container margin-custom">
                    <% Veterinario v=(Veterinario) request.getAttribute("veterinario"); %>
                        <% if (v==null) { %>
                            <div class="alert alert-error">Veterinario no encontrado.</div>
                            <div class="form-group margin-top-custom">
                                <a class="btn btn-secondary"
                                    href="<%=request.getContextPath()%>/ControlVeterinario?accion=ingresarModulo">Volver</a>
                            </div>
                            <% } else { %>
                                <div class="card">
                                    <h1 class="margin-custom text-light">Editar Veterinario</h1>

                                    <div class="alert alert-danger" style="${empty mensaje ? 'display:none' : ''}">
                                        ${mensaje}
                                    </div>

                                    <form action="<%=request.getContextPath()%>/ControlVeterinario" method="post">
                                        <input type="hidden" name="accion" value="editarVeterinario">
                                        <input type="hidden" name="cedula" value="<%= v.getCedula() %>">

                                        <div class="form-group">
                                            <label class="form-label text-light">Cédula (No
                                                editable)</label>
                                            <input class="form-control" type="text" name="cedula_display"
                                                value="<%= v.getCedula() %>" disabled>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Nombre</label>
                                            <input class="form-control" type="text" name="nombre"
                                                value="<%= v.getNombre() %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Apellido</label>
                                            <input class="form-control" type="text" name="apellido"
                                                value="<%= v.getApellido() %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Usuario</label>
                                            <input class="form-control" type="text" name="usuario"
                                                value="<%= v.getUsuario() %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Especialidad</label>
                                            <input class="form-control" type="text" name="especialidad"
                                                value="<%= v.getEspecialidad() %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Número Licencia</label>
                                            <input class="form-control" type="text" name="numeroLicencia"
                                                value="<%= v.getNumeroLicencia() %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Teléfono</label>
                                            <input class="form-control" type="text" name="telefono"
                                                value="<%= v.getTelefono() %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Contraseña (Dejar en blanco
                                                para no
                                                cambiar)</label>
                                            <input class="form-control" type="password" name="clave">
                                        </div>

                                        <div class="flex-container" style="margin-top: 20px; gap: 10px;">
                                            <button class="btn btn-primary" type="submit"
                                                style="flex: 1; margin: 0;">Guardar</button>
                                            <a class="btn btn-secondary"
                                                href="<%=request.getContextPath()%>/ControlVeterinario?accion=ingresarModulo"
                                                style="flex: 1; text-align: center; margin: 0;">Cancelar</a>
                                        </div>
                                    </form>
                                </div>
                                <% } %>
                </section>
            </main>
            <footer class="footer">
                <p>VetCare - Admin</p>
            </footer>
        </body>

        </html>