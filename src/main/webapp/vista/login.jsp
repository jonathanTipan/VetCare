<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VetCare - Login</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/framework.css">
    </head>

    <body class="font-main bg-secondary main-layout">
        <header class="navbar">
            <div class="container flex-container justify-space-between align-center">

                <div class="navbar-brand">
                    Vet<span class="text-highlight">Care</span> | Sistema de Citas
                </div>
                <nav>
                    <ul class="list-style-none nav-links flex-container align-center">
                        <!-- Links just for demo, real login should be the only way effectively -->
                        <li><span class="text-light">Bienvenido</span></li>
                    </ul>
                </nav>

            </div>
        </header>

        <main class="main-content">
            <section class="container flex-container justify-center align-center" style="min-height: 70vh;">
                <div class="card" style="max-width: 420px; width: 100%;">
                    <form action="<%=request.getContextPath()%>/ControlAutenticacion" method="post">
                        <h1 class="text-center margin-custom">Login</h1>
                        <p class="text-center text-muted margin-custom">
                            Inicia sesión para gestionar citas, mascotas e historial clínico.
                        </p>

                        <% String mensaje=(String) request.getAttribute("mensaje"); if (mensaje !=null) { %>
                            <div class="alert alert-danger">
                                <%= mensaje %>
                            </div>
                            <% } %>

                                <input type="hidden" name="accion" value="ingresar">

                                <div class="form-group">
                                    <label class="form-label" for="usuario">Usuario</label>
                                    <input class="form-control" type="text" id="usuario" name="usuario" required>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="clave">Contraseña</label>
                                    <input class="form-control" type="password" id="clave" name="clave" required>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="rol">Rol</label>
                                    <select class="form-control" id="rol" name="rol" required>
                                        <option value="">Seleccione un rol</option>
                                        <% java.util.List<String> roles = (java.util.List<String>)
                                                request.getAttribute("roles");
                                                if (roles != null) {
                                                for(String rol : roles) {
                                                %>
                                                <option value="<%= rol %>">
                                                    <%= rol %>
                                                </option>
                                                <% } } %>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <button class="btn btn-primary" type="submit">Entrar</button>
                                    <!-- <a class="btn btn-outline" href="recuperar-password.html">Olvidé mi contraseña</a> -->
                                </div>
                    </form>
                </div>
            </section>
        </main>
        <footer class="footer">
            <p>Proyecto académico - Sistema de citas veterinarias</p>
        </footer>

    </body>

    </html>