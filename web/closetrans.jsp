<%-- 
    Document   : closetrans
    Created on : Apr 24, 2012, 1:43:25 PM
    Author     : root
--%>

<%@page import="org.jakc.stockpdt.controller.GondolaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stock System - Ranch Market</title>
    </head>
    <body>
        <%
            if(session.getAttribute("loginstatus") != null){
                boolean loginstatus = (Boolean) session.getAttribute("loginstatus");
                if(!loginstatus){
                    response.sendRedirect("index.jsp");
                }                   
            }else{
                response.sendRedirect("index.jsp");
            }

            
            GondolaController controller = new GondolaController();
            String gondolaid = (String) session.getAttribute("gondolaid");
            controller.close(gondolaid,false);
            response.sendRedirect("findgondola.jsp");
        %>
    </body>
</html>
