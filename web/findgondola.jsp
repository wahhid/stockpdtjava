<%-- 
    Document   : findgondola
    Created on : May 10, 2012, 3:22:25 PM
    Author     : root
--%>

<%@page import="org.jakc.stockpdt.entity.Transstock"%>
<%@page import="org.jakc.stockpdt.controller.TransstockController"%>
<%@page import="org.jakc.stockpdt.entity.Gondola"%>
<%@page import="org.jakc.stockpdt.controller.GondolaController"%>
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
            String periodeid = null;
            if((String) session.getAttribute("periodeid") == null){
                 periodeid = request.getParameter("periodeid");
                 session.setAttribute("periodeid", periodeid);                                
            }else{
               periodeid = (String) session.getAttribute("periodeid");
            }            
            String periodename = periodeid.substring(4);
            String siteid = (String) session.getAttribute("siteid");
            
            
        %>
        Username : <%=username%> 
        <form method="POST" action="resultgondola.jsp" >            
            <table border="1" width="25%">
                <tr>
                    <td>Site ID</td>
                    <td>:</td>
                    <td><%=siteid%></td>
                </tr>
                <tr>
                    <td>Periode ID</td>
                    <td>:</td>
                    <td><%=periodename%></td>
                </tr>
                
                <tr>
                    <td>Gondola ID</td>
                    <td>:</td>
                    <td><input type="text" name="gondolaid" value="" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td><input type="submit" value="Find" /></td>
                </tr>
            </table> 
            <a href="index.jsp">Logout</a>
       </form>                
    </body>
</html>

