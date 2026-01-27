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
                    <% Veterinario v=(Veterinario) request.getAttribute("veterinario"); boolean isEdit=(v !=null); %>

                        <div class="card">
                            <h1 class="margin-custom text-light">
                                <%= isEdit ? "Editar Veterinario" : "Registrar Veterinario" %>
                            </h1>

                            <div class="alert alert-danger" style="${empty mensaje ? 'display:none' : ''}">
                                ${mensaje}
                            </div>

                            <form action="<%=request.getContextPath()%>/ControlVeterinario" method="post">
                                <input type="hidden" name="accion" value="<%= isEdit ? " editarVeterinario"
                                    : "registrarVeterinario" %>">
                                <% if(isEdit) { %>
                                    <input type="hidden" name="id" value="<%= v.getCedula() %>">
                                    <% } %>

                                        <div class="form-group">
                                            <label class="form-label text-light">Cédula</label>
                                            <input class="form-control" type="text" name="cedula"
                                                value="<%= isEdit && v.getCedula() != null ? v.getCedula() : "" %>"
                                                required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Nombre</label>
                                            <input class="form-control" type="text" name="nombre"
                                                value="<%= isEdit ? v.getNombre() : "" %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Apellido</label>
                                            <input class="form-control" type="text" name="apellido"
                                                value="<%= isEdit ? v.getApellido() : "" %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Usuario</label>
                                            <input class="form-control" type="text" name="usuario"
                                                value="<%= isEdit ? v.getUsuario() : "" %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Especialidad</label>
                                            <select class="form-control" name="especialidad" required
                                                oninvalid="this.setCustomValidity('Por favor, seleccione una especialidad')"
                                                oninput="this.setCustomValidity('')">
                                                <option value="">Seleccione...</option>
                                                <option value="Medicina General" <%=isEdit && "Medicina General"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Medicina General
                                                </option>
                                                <option value="Cirugía" <%=isEdit && "Cirugía"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Cirugía</option>
                                                <option value="Medicina Interna" <%=isEdit && "Medicina Interna"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Medicina Interna
                                                </option>
                                                <option value="Dermatología" <%=isEdit && "Dermatología"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Dermatología
                                                </option>
                                                <option value="Cardiología" <%=isEdit && "Cardiología"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Cardiología
                                                </option>
                                                <option value="Neurología" <%=isEdit && "Neurología"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Neurología
                                                </option>
                                                <option value="Oftalmología" <%=isEdit && "Oftalmología"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Oftalmología
                                                </option>
                                                <option value="Odontología" <%=isEdit && "Odontología"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Odontología
                                                </option>
                                                <option value="Oncología" <%=isEdit && "Oncología"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Oncología</option>
                                                <option value="Ortopedia y Traumatología" <%=isEdit
                                                    && "Ortopedia y Traumatología" .equals(v.getEspecialidad())
                                                    ? "selected" : "" %>>Ortopedia y Traumatología</option>
                                                <option value="Fisioterapia" <%=isEdit && "Fisioterapia"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Fisioterapia
                                                </option>
                                                <option value="Etología" <%=isEdit && "Etología"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Etología</option>
                                                <option value="Animales Exóticos" <%=isEdit && "Animales Exóticos"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Animales Exóticos
                                                </option>
                                                <option value="Imagenología" <%=isEdit && "Imagenología"
                                                    .equals(v.getEspecialidad()) ? "selected" : "" %>>Imagenología
                                                </option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Número Licencia</label>
                                            <input class="form-control" type="text" name="numeroLicencia"
                                                value="<%= isEdit && v.getNumeroLicencia() != null ? v.getNumeroLicencia() : "" %>"
                                                required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Teléfono</label>
                                            <input class="form-control" type="text" name="telefono"
                                                value="<%= isEdit && v.getTelefono() != null ? v.getTelefono() : "" %>"
                                                required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label text-light">Contraseña <%= isEdit
                                                    ? "(Dejar en blanco para no cambiar)" : "" %></label>
                                            <input class="form-control" type="password" name="clave" <%=isEdit ? ""
                                                : "required" %>
                                            oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                            oninput="this.setCustomValidity('')">
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
                </section>
            </main>
            <footer class="footer">
                <p>VetCare - Admin</p>
            </footer>
        </body>

        </html>