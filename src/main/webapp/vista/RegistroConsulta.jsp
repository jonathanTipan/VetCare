<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registrar Consulta</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <header class="navbar">
            <div class="container flex-container justify-space-between align-center">
                <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Veterinario</div>
                <nav>
                    <ul class="list-style-none nav-links flex-container align-center">
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/vista/HomeVeterinario.jsp">Home</a></li>

                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <main class="main-content">
            <section class="container margin-custom">
                <div class="card">
                    <h1 class="margin-custom text-dark">Registrar Atención Médica</h1>

                    <div class="alert alert-danger" style="${empty mensaje ? 'display:none' : ''}">
                        ${mensaje}
                    </div>

                    <% modelo.Consulta consulta=(modelo.Consulta) request.getAttribute("consulta"); %>
                        <% if (consulta==null) { %>
                            <div class="alert alert-danger">
                                <p>No se encontró la consulta seleccionada.</p>
                                <a class="btn btn-secondary"
                                    href="<%=request.getContextPath()%>/ControlConsulta?accion=ingresarModulo">Volver
                                    a Mi Agenda</a>
                            </div>
                            <% } else { %>
                                <div class="alert alert-info">
                                    <p><strong>Paciente:</strong>
                                        <%= consulta.getMascota() !=null ? consulta.getMascota().getNombre() : "-" %>
                                    </p>
                                    <p><strong>Motivo Original:</strong>
                                        <%= consulta.getMotivo() !=null ? consulta.getMotivo() : "-" %>
                                    </p>
                                </div>

                                <form action="<%=request.getContextPath()%>/ControlConsulta" method="post">

                                    <input type="hidden" name="idConsulta" value="<%= consulta.getId() %>">

                                    <div class="form-group"><label class="form-label">Síntomas</label>
                                        <textarea class="form-control" rows="3" name="sintomas" required
                                            oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                            oninput="this.setCustomValidity('')"><%= consulta.getSintomas() != null ? consulta.getSintomas() : "" %></textarea>
                                    </div>
                                    <div class="form-group"><label class="form-label">Diagnóstico</label>
                                        <textarea class="form-control" rows="3" name="diagnostico" required
                                            oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                            oninput="this.setCustomValidity('')"><%= consulta.getDiagnostico() != null ? consulta.getDiagnostico() : "" %></textarea>
                                    </div>
                                    <div class="form-group"><label class="form-label">Tratamiento</label>
                                        <textarea class="form-control" rows="3" name="tratamiento" required
                                            oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                            oninput="this.setCustomValidity('')"><%= consulta.getTratamiento() != null ? consulta.getTratamiento() : "" %></textarea>
                                    </div>
                                    <div class="form-group"><label class="form-label">Observaciones</label>
                                        <textarea class="form-control" rows="3" name="observaciones" required
                                            oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                            oninput="this.setCustomValidity('')"><%= consulta.getObservaciones() != null ? consulta.getObservaciones() : "" %></textarea>
                                    </div>

                                    <div class="form-group flex-container justify-space-between">
                                        <div>
                                            <button class="btn btn-primary" type="submit" name="accion"
                                                value="atenderConsulta">Finalizar Atención</button>
                                            <a class="btn btn-secondary"
                                                href="<%=request.getContextPath()%>/ControlConsulta?accion=ingresarModulo">Cancelar</a>
                                        </div>
                                        <button type="submit" name="accion" value="iniciarPrescripcion"
                                            class="btn btn-warning" id="btnReceta"
                                            style="background-color: #ff9800; color: white; opacity: 0.5; cursor: not-allowed; pointer-events: none;"
                                            formnovalidate>
                                            Prescribir Receta
                                        </button>
                                    </div>
                                </form>
                                <% } %>
                </div>
            </section>
        </main>



        <footer class="footer">
            <p>VetCare - Registrar Consulta</p>
        </footer>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const btnReceta = document.getElementById("btnReceta");

                // Fields to validate
                const sintomas = document.querySelector('textarea[name="sintomas"]');
                const diagnostico = document.querySelector('textarea[name="diagnostico"]');
                const tratamiento = document.querySelector('textarea[name="tratamiento"]');
                const observaciones = document.querySelector('textarea[name="observaciones"]');

                function validarFormularioAtencion() {
                    const isValid = sintomas.value.trim() !== "" &&
                        diagnostico.value.trim() !== "" &&
                        tratamiento.value.trim() !== "" &&
                        observaciones.value.trim() !== "";

                    if (isValid) {
                        btnReceta.style.pointerEvents = "auto";
                        btnReceta.style.opacity = "1";
                        btnReceta.style.cursor = "pointer";
                        btnReceta.classList.remove("disabled"); // Optional if using framework util
                    } else {
                        btnReceta.style.pointerEvents = "none";
                        btnReceta.style.opacity = "0.5";
                        btnReceta.style.cursor = "not-allowed";
                    }
                }

                // Add event listeners
                if (sintomas) sintomas.addEventListener("input", validarFormularioAtencion);
                if (diagnostico) diagnostico.addEventListener("input", validarFormularioAtencion);
                if (tratamiento) tratamiento.addEventListener("input", validarFormularioAtencion);
                if (observaciones) observaciones.addEventListener("input", validarFormularioAtencion);

                // Initial check
                validarFormularioAtencion();


                const modal = document.getElementById("modalReceta");
                const btnOpen = document.getElementById("btnReceta");
                const btnClose = document.getElementById("btnCancelarReceta");
                const form = document.getElementById("formReceta");

                // Open Modal logic... (Keeping existing logic if modal exists, though it seems unused in this file version)
                // Since the modal is not in this file, we remove the unused modal code to avoid errors or confusion, 
                // but if the user intends to link to another page (as per the href attribute), we don't need modal logic here.
                // The button is an anchor tag <a> linking to "iniciarPrescripcion".
            });
        </script>
    </body>

    </html>