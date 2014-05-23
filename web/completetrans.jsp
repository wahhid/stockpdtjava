<%-- 
    Document   : completetrans
    Created on : May 11, 2012, 9:43:04 AM
    Author     : root
--%>

<%@page import="org.jakc.stockpdt.entity.Transstock"%>
<%@page import="org.jakc.stockpdt.controller.GondolaController"%>
<%@page import="org.jakc.stockpdt.controller.TransstockController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            
            TransstockController transstockController = new TransstockController();
            Transstock transstock = (Transstock) session.getAttribute("transstock");            
            if(transstock.getTranscount() == 0){
                transstock.setTranscount(1);
            }else{
                transstock.setTranscount(2);
                transstock.setStatus(false);
            }
            transstockController.updateData(transstock);
            
            GondolaController controller = new GondolaController();
            String gondolaid = (String) session.getAttribute("gondolaid");
            controller.close(gondolaid,false);
            
            response.sendRedirect("findgondola.jsp");
        %>
    </body>
</html>
