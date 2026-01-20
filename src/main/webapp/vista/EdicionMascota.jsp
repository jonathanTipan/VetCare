<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="modelo.Mascota" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Editar Mascota</title>
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
                                    Mascotas</a></li>
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
                        <h1 class="margin-custom text-dark">Editar Mascota</h1>

                        <% Mascota mascota=(Mascota) request.getAttribute("mascota"); %>
                            <% if (mascota==null) { %>
                                <div class="alert alert-error">Mascota no encontrada</div>
                                <% } else { %>
                                    <form action="<%=request.getContextPath()%>/ControlMascota" method="post">
                                        <input type="hidden" name="accion" value="editarMascota">
                                        <input type="hidden" name="id" value="<%= mascota.getId() %>">

                                        <div class="form-group">
                                            <label class="form-label" for="nombre">Nombre</label>
                                            <input class="form-control" type="text" id="nombre" name="nombre"
                                                value="<%= mascota.getNombre() %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="especie">Especie</label>
                                            <input class="form-control" type="text" id="especie" name="especie"
                                                value="<%= mascota.getEspecie() %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="raza">Raza</label>
                                            <input class="form-control" type="text" id="raza" name="raza"
                                                value="<%= mascota.getRaza() != null ? mascota.getRaza() : "" %>"
                                                required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="fechaNac">Fecha de Nacimiento</label>
                                            <input class="form-control" type="date" id="fechaNac" name="fechaNacimiento"
                                                value='<%= mascota.getFechaNacimiento() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(mascota.getFechaNacimiento()) : "" %>'
                                                required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="sexo">Sexo</label>
                                            <select class="form-control" id="sexo" name="sexo" required
                                                oninvalid="this.setCustomValidity('Por favor, seleccione una opción')"
                                                oninput="this.setCustomValidity('')">
                                                <option value="">Seleccione...</option>
                                                <option value="Macho" <%="Macho" .equals(mascota.getSexo()) ? "selected"
                                                    : "" %>>Macho</option>
                                                <option value="Hembra" <%="Hembra" .equals(mascota.getSexo())
                                                    ? "selected" : "" %>>Hembra</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label" for="peso">Peso (kg)</label>
                                            <input class="form-control" type="number" step="0.1" id="peso" name="peso"
                                                value="<%= mascota.getPeso() > 0 ? mascota.getPeso() : "" %>" required
                                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                                oninput="this.setCustomValidity('')">
                                        </div>

                                        <div class="flex-container justify-space-between" style="margin-top: 20px;">
                                            <button class="btn btn-primary" type="submit"
                                                style="width: 48%; margin: 0;">Guardar</button>
                                            <a class="btn btn-secondary"
                                                href="<%=request.getContextPath()%>/ControlMascota?accion=cancelar"
                                                style="width: 48%; text-align: center; margin: 0;">Cancelar</a>
                                        </div>
                                    </form>
                                    <% } %>
                    </div>
                </section>
            </main>
        </body>

        </html>