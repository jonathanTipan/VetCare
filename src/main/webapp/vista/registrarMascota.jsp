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
                <div class="card">
                    <h1 class="margin-custom text-light">Registrar Mascota</h1>

                    <% if(request.getAttribute("mensaje") !=null) { %>
                        <div class="padding-custom bg-highlight rounded-lg margin-custom"
                            style="background-color: #d4edda; color: #155724;">
                            <%= request.getAttribute("mensaje") %>
                        </div>
                        <% } %>

                            <form action="<%=request.getContextPath()%>/ControlMascota" method="post">
                                <div class="form-group"><label class="form-label">Nombre</label><input
                                        class="form-control" type="text" name="nombre" required></div>
                                <div class="form-group"><label class="form-label">Especie</label><input
                                        class="form-control" type="text" name="especie" required></div>
                                <div class="form-group"><label class="form-label">Raza</label><input
                                        class="form-control" type="text" name="raza" required></div>
                                <div class="form-group"><label class="form-label">Fecha nacimiento</label><input
                                        class="form-control" type="date" name="fechaNac"></div>
                                <div class="form-group"><label class="form-label">Peso (kg)</label><input
                                        class="form-control" type="number" step="0.1" name="peso"></div>

                                <div class="form-group">
                                    <button class="btn btn-primary" type="submit">Guardar</button>
                                    <a class="btn btn-secondary"
                                        href="<%=request.getContextPath()%>/ControlMascota?accion=listar">Cancelar</a>
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