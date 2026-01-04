<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registrar Mascota</title>
        <link rel="stylesheet" href="../framework.css"> <!-- Adjusted path assuming framework.css is in webapp root -->
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
                    <h1 class="margin-custom">Registrar Mascota</h1>

                    <% if(request.getAttribute("mensaje") !=null) { %>
                        <div class="alert alert-info">
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
                                <div class="form-group"><label class="form-label">Sexo</label>
                                    <select class="form-select" name="sexo">
                                        <option value="M">Macho</option>
                                        <option value="H">Hembra</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <button class="btn btn-primary" type="submit">Guardar</button>
                                    <a class="btn btn-secondary" href="mis-mascotas.html">Cancelar</a>
                                </div>
                            </form>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>Registrar Mascota</p>
        </footer>
    </body>

    </html>