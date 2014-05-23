<%-- 
    Document   : notitransstock
    Created on : May 11, 2012, 3:24:15 PM
    Author     : root
--%>

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
            
            String username = (String) session.getAttribute("username"); 
            out.println("Username : " + username + "<br/>");
            out.println("Collect Data Close<br/>");
            out.println("<a href=findgondola.jsp>Back</a>");
        %>
        
    </body>
</html>
