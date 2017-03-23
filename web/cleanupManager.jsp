<%-- 
    Document   : cleanupManager
    Created on : 19 Mar, 2017, 9:15:17 PM
    Author     : cyber
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>
