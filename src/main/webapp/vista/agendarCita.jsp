<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Agendar Cita</title>
        <link rel="stylesheet" href="../framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <header class="navbar">
            <div class="container flex-container justify-space-between align-center">
                <div class="navbar-brand">Vet<span class="text-highlight">Care</span> | Cliente</div>
                <nav>
                    <ul class="list-style-none nav-links flex-container align-center">
                        <li><a class="no-decoration text-light" href="home-cliente.html">Home</a></li>
                        <li><a class="no-decoration text-light" href="mis-mascotas.html">Mis Mascotas</a></li>
                        <li><a class="no-decoration text-light" href="mis-citas.html">Mis Citas</a></li>
                        <li><a class="no-decoration text-light" href="perfil-cliente.html">Mi Perfil</a></li>
                        <li><a class="no-decoration text-light" href="index.html">Salir</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <main class="main-content">
            <section class="container">
                <div class="card">
                    <h1 class="margin-custom">Agendar Cita</h1>

                    <% if(request.getAttribute("mensaje") !=null) { %>
                        <div class="alert alert-info">
                            <%= request.getAttribute("mensaje") %>
                        </div>
                        <% } %>

                            <form action="<%=request.getContextPath()%>/ControlAgendamiento" method="post">
                                <div class="form-group"><label class="form-label">Mascota</label>
                                    <select class="form-select" name="mascota">
                                        <option value="1">Firulais</option>
                                        <option value="2">Michi</option>
                                    </select>
                                </div>
                                <div class="form-group"><label class="form-label">Fecha</label><input
                                        class="form-control" type="date" name="fecha" required></div>
                                <div class="form-group"><label class="form-label">Hora</label><input
                                        class="form-control" type="time" name="hora" required></div>
                                <div class="form-group"><label class="form-label">Motivo de consulta</label><textarea
                                        rows="3" name="motivo"></textarea></div>
                                <div class="form-group">
                                    <button class="btn btn-primary" type="submit">Confirmar</button>
                                    <a class="btn btn-secondary text-center" href="mis-citas.html">Cancelar</a>
                                </div>
                            </form>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>Agendar Cita</p>
        </footer>
    </body>

    </html>