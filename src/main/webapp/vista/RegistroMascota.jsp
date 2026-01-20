<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registrar Mascota</title>
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
                                href="<%=request.getContextPath()%>/ControlCita?accion=ingresarModulo">Mis Citas</a>
                        </li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <main class="main-content">
            <section class="container margin-custom">
                <div class="card">
                    <h1 class="margin-custom text-dark">Registrar Mascota</h1>

                    <div class="alert alert-danger" style="${empty mensaje ? 'display:none' : ''}">
                        ${mensaje}
                    </div>

                    <form action="<%=request.getContextPath()%>/ControlMascota" method="post">
                        <input type="hidden" name="accion" value="registrarMascota">
                        <div class="form-group"><label class="form-label">Nombre</label><input class="form-control"
                                type="text" name="nombre" required
                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                oninput="this.setCustomValidity('')"></div>
                        <div class="form-group"><label class="form-label">Especie</label><input class="form-control"
                                type="text" name="especie" required
                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                oninput="this.setCustomValidity('')"></div>
                        <div class="form-group"><label class="form-label">Raza</label><input class="form-control"
                                type="text" name="raza" required
                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                oninput="this.setCustomValidity('')"></div>
                        <div class="form-group"><label class="form-label">Fecha nacimiento</label><input
                                class="form-control" type="date" name="fechaNacimiento" required
                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                oninput="this.setCustomValidity('')"></div>
                        <div class="form-group"><label class="form-label">Peso (kg)</label><input class="form-control"
                                type="number" step="0.1" name="peso" required
                                oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                oninput="this.setCustomValidity('')"></div>
                        <div class="form-group">
                            <label class="form-label">Sexo</label>
                            <select class="form-control" name="sexo" required
                                oninvalid="this.setCustomValidity('Por favor, seleccione una opción')"
                                oninput="this.setCustomValidity('')">
                                <option value="">Seleccione...</option>
                                <option value="Macho">Macho</option>
                                <option value="Hembra">Hembra</option>
                            </select>
                        </div>

                        <div class="flex-container" style="margin-top: 20px; gap: 10px;">
                            <button class="btn btn-primary" type="submit" style="flex: 1; margin: 0;">Guardar</button>
                            <a class="btn btn-secondary"
                                href="<%=request.getContextPath()%>/ControlMascota?accion=ingresarModulo"
                                style="flex: 1; text-align: center; margin: 0;">Cancelar</a>
                        </div>
                    </form>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare - Registro de Mascotas</p>
        </footer>
    </body>

    </html>