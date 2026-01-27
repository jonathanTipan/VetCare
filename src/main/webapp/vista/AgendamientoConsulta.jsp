<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Agendar Consulta</title>
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
                                href="<%=request.getContextPath()%>/ControlAutenticacion?accion=logout">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <main class="main-content">
            <section class="container margin-custom">
                <div class="card">
                    <h1 class="margin-custom text-dark">Agendar Consulta</h1>

                    <div class="alert alert-danger" style="${empty mensaje ? 'display:none' : ''}">
                        ${mensaje}
                    </div>

                    <% java.util.List<modelo.Mascota> mascotas = (java.util.List<modelo.Mascota>)
                            request.getAttribute("mascotas");
                            if (mascotas == null || mascotas.isEmpty()) {
                            %>
                            <div class="alert alert-warning">
                                <p>No tienes mascotas registradas. Debes registrar una mascota antes de agendar
                                    una consulta.</p>
                                <a href="<%=request.getContextPath()%>/ControlMascota?accion=iniciarRegistro"
                                    class="btn btn-primary">Registrar Mascota</a>
                            </div>
                            <% } else { %>
                                <form action="<%=request.getContextPath()%>/ControlConsulta" method="post">
                                    <input type="hidden" name="accion" value="agendarConsulta">


                                    <div class="form-group"><label class="form-label">Veterinario</label>
                                        <select class="form-select" name="idVeterinario" id="idVeterinario" required
                                            oninvalid="this.setCustomValidity('Por favor, seleccione un veterinario')"
                                            oninput="this.setCustomValidity('')">
                                            <option value="">Seleccione un veterinario...</option>
                                            <% java.util.List<modelo.Veterinario> veterinarios = (java.util.List
                                                <modelo.Veterinario>) request.getAttribute("veterinarios");
                                                    if(veterinarios != null) {
                                                    for(modelo.Veterinario v : veterinarios) { %>
                                                    <option value="<%=v.getCedula()%>">
                                                        <%=v.getNombre()%>
                                                            <%=v.getApellido()%>
                                                    </option>
                                                    <% } } %>
                                        </select>
                                    </div>

                                    <div class="form-group"><label class="form-label">Fecha</label>
                                        <input class="form-control" type="date" name="fecha" id="fecha" required
                                            oninvalid="this.setCustomValidity('Por favor, seleccione una fecha')"
                                            oninput="this.setCustomValidity('')">
                                    </div>

                                    <div class="form-group"><label class="form-label">Hora</label>
                                        <div class="flex-container">
                                            <button type="button" class="btn btn-secondary"
                                                id="btnVerHorarios">Seleccionar Hora</button>
                                            <input type="text" name="hora" id="hora" class="form-control"
                                                style="width: 120px; margin-left: 10px; display: inline-block; background-color: white; cursor: pointer;"
                                                readonly required placeholder="--:--"
                                                oninvalid="this.setCustomValidity('Por favor, seleccione una hora')"
                                                oninput="this.setCustomValidity('')"
                                                onclick="document.getElementById('btnVerHorarios').click();">
                                        </div>
                                    </div>

                                    <div class="form-group"><label class="form-label">Mascota</label>
                                        <select class="form-select" name="idMascota" required
                                            oninvalid="this.setCustomValidity('Por favor, seleccione una mascota')"
                                            oninput="this.setCustomValidity('')">
                                            <% for(modelo.Mascota m : mascotas) { %>
                                                <option value="<%=m.getId()%>">
                                                    <%=m.getNombre()%> (<%=m.getEspecie()%>)
                                                </option>
                                                <% } %>
                                        </select>
                                    </div>

                                    <!-- Modal Structure -->
                                    <div id="modalHorarios" class="modal"
                                        style="display:none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4);">
                                        <div class="modal-content"
                                            style="background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 80%; max-width: 500px; border-radius: 8px;">
                                            <div class="flex-container justify-space-between align-center">
                                                <h2>Selecciona un Horario</h2>
                                                <span class="close"
                                                    style="color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer;">&times;</span>
                                            </div>
                                            <hr>
                                            <div id="listaHorarios" class="margin-custom"></div>
                                        </div>
                                    </div>

                                    <div class="form-group"><label class="form-label">Motivo de consulta</label>
                                        <textarea class="form-control" rows="3" name="motivo" required
                                            oninvalid="this.setCustomValidity('Por favor, complete este campo')"
                                            oninput="this.setCustomValidity('')"></textarea>
                                    </div>
                                    <div class="form-group flex-container justify-space-between">
                                        <button class="btn btn-primary" type="submit">Guardar</button>
                                        <a class="btn btn-secondary"
                                            href="<%=request.getContextPath()%>/ControlConsulta?accion=cancelar">Cancelar</a>
                                    </div>
                                </form>
                                <% } %>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare - Agendar Consulta</p>
        </footer>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const fechaInput = document.getElementById("fecha");
                const vetSelect = document.getElementById("idVeterinario");
                const horaInput = document.getElementById("hora");
                const btnVerHorarios = document.getElementById("btnVerHorarios");

                const modal = document.getElementById("modalHorarios");
                const closeModal = document.querySelector(".close");
                const listaHorarios = document.getElementById("listaHorarios");

                // 1. Initial State: Disable Date and Button
                fechaInput.disabled = true;
                btnVerHorarios.disabled = true;

                // 2. When Vet is selected, enable Date
                vetSelect.addEventListener("change", function () {
                    if (this.value) {
                        fechaInput.disabled = false;
                    } else {
                        fechaInput.disabled = true;
                        fechaInput.value = "";
                        btnVerHorarios.disabled = true;
                        resetHora();
                    }
                });

                // 3. When Date is selected, enable Button
                fechaInput.addEventListener("change", function () {
                    if (this.value && vetSelect.value) {
                        btnVerHorarios.disabled = false;
                    } else {
                        btnVerHorarios.disabled = true;
                    }
                    resetHora();
                });

                function resetHora() {
                    horaInput.value = "";
                }

                // 4. Button Click: Fetch and Open Modal
                btnVerHorarios.addEventListener("click", function () {
                    const fecha = fechaInput.value;
                    const idVet = vetSelect.value;



                    listaHorarios.innerHTML = '<p>Cargando disponibilidad...</p>';
                    modal.style.display = "block";

                    const url = "ControlConsulta?accion=buscarDisponibilidad&fecha=" + encodeURIComponent(fecha) + "&idVeterinario=" + encodeURIComponent(idVet);

                    fetch(url)
                        .then(response => response.json())
                        .then(data => {


                            listaHorarios.innerHTML = '';
                            if (data.length === 0 || (data.length === 1 && data[0].startsWith("Error"))) {
                                const msg = (data.length === 1 && data[0].startsWith("Error")) ? data[0] : "No hay horarios disponibles para esta fecha.";
                                listaHorarios.innerHTML = `<p class="text-danger">${msg}</p>`;
                            } else {
                                const container = document.createElement("div");
                                container.className = "flex-container flex-wrap";
                                container.style.gap = "10px"; // Custom gap

                                data.forEach(hora => {
                                    const btn = document.createElement("button");
                                    btn.type = "button";
                                    btn.className = "btn btn-outline-primary";
                                    btn.textContent = hora;
                                    btn.onclick = function () {
                                        seleccionarHora(hora);
                                    };
                                    container.appendChild(btn);
                                });
                                listaHorarios.appendChild(container);
                            }
                        })
                        .catch(err => {
                            console.error(err);
                            listaHorarios.innerHTML = '<p class="text-danger">Error al cargar horarios.</p>';
                        });
                });

                function seleccionarHora(hora) {
                    horaInput.value = hora;
                    modal.style.display = "none";
                }

                // Modal Close Logic
                closeModal.onclick = function () {
                    modal.style.display = "none";
                }

                window.onclick = function (event) {
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                }

                // Form Validation on Submit
                const form = document.querySelector("form");
                form.addEventListener("submit", function (event) {
                    if (!horaInput.value) {
                        event.preventDefault();
                        horaInput.setCustomValidity('Por favor, seleccione una hora');
                        horaInput.reportValidity();
                    }
                });
            });
        </script>
    </body>

    </html>