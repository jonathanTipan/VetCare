<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Agendar Cita</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <header class="navbar">
            <div class="container flex-container justify-space-between align-center">
                <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Cliente</div>
                <nav>
                    <ul class="list-style-none nav-links flex-container align-center">
                        <li><a class="no-decoration text-light" href="home-cliente.jsp">Home</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlMascota?accion=listar">Mis Mascotas</a></li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/ControlAgendamiento?accion=listar">Mis Citas</a>
                        </li>
                        <li><a class="no-decoration text-light"
                                href="<%=request.getContextPath()%>/AutenticarController?accion=logout">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <main class="main-content">
            <section class="container margin-custom">
                <div class="card bg-light">
                    <h1 class="margin-custom text-dark">Agendar Cita</h1>

                    <% if(request.getAttribute("mensaje") !=null) { %>
                        <div class="padding-custom bg-highlight rounded-lg margin-custom"
                            style="background-color: #d4edda; color: #155724;">
                            <%= request.getAttribute("mensaje") %>
                        </div>
                        <% } %>

                            <form action="<%=request.getContextPath()%>/ControlAgendamiento" method="post">
                                <div class="form-group"><label class="form-label">Mascota</label>
                                    <select class="form-select" name="idMascota" required>
                                        <% java.util.List<modelo.Mascota> mascotas = (java.util.List<modelo.Mascota>)
                                                request.getAttribute("mascotas");
                                                if(mascotas != null) {
                                                for(modelo.Mascota m : mascotas) {
                                                %>
                                                <option value="<%=m.getId()%>">
                                                    <%=m.getNombre()%>
                                                </option>
                                                <% } } %>
                                    </select>
                                </div>

                                <div class="form-group"><label class="form-label">Veterinario (Opcional)</label>
                                    <select class="form-select" name="idVeterinario">
                                        <option value="">Cualquiera</option>
                                        <% java.util.List<modelo.Veterinario> vets = (java.util.List<modelo.Veterinario>
                                                ) request.getAttribute("veterinarios");
                                                if(vets != null) {
                                                for(modelo.Veterinario v : vets) {
                                                %>
                                                <option value="<%=v.getId()%>">
                                                    <%=v.getNombre()%> (<%=v.getEspecialidad()%>)
                                                </option>
                                                <% } } %>
                                    </select>
                                </div>

                                <div class="form-group"><label class="form-label">Fecha</label>
                                    <input class="form-control" type="date" name="fecha" required>
                                </div>
                                <div class="form-group"><label class="form-label">Hora</label>
                                    <input class="form-control" type="time" name="hora" required>
                                </div>
                                <div class="form-group"><label class="form-label">Motivo de consulta</label>
                                    <textarea class="form-control" rows="3" name="motivo" required></textarea>
                                </div>
                                <div class="form-group">
                                    <button class="btn btn-primary" type="submit">Confirmar</button>
                                    <a class="btn btn-secondary"
                                        href="<%=request.getContextPath()%>/ControlAgendamiento?accion=listar">Cancelar</a>
                                </div>
                            </form>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>VetCare - Agendar Cita</p>
        </footer>
    </body>

    </html>