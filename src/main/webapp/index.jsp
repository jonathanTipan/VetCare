<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% // Simple logic: if user logged in, go to generic home or role specific. // Else go to login.jsp
        if(session.getAttribute("usuario")==null) { response.sendRedirect("login.jsp"); } else { String rol=(String)
        session.getAttribute("rol"); if("CLIENTE".equals(rol)) { response.sendRedirect("vista/home-cliente.jsp"); } else
        if("VETERINARIO".equals(rol)) { response.sendRedirect("vista/home-veterinario.jsp"); } else
        if("ADMIN".equals(rol)) { response.sendRedirect("vista/home-admin.jsp"); } else { session.invalidate();
        response.sendRedirect("login.jsp"); } } %>