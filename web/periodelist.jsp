<%-- 
    Document   : periodelist
    Created on : May 10, 2012, 1:58:38 PM
    Author     : root
--%>

<%@page import="org.jakc.stockpdt.entity.Periode"%>
<%@page import="java.util.List"%>
<%@page import="org.jakc.stockpdt.controller.PeriodeController"%>
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
        
            PeriodeController periodeController = new PeriodeController();
            String siteid = (String) session.getAttribute("siteid");                        
            String username = (String) session.getAttribute("username");
            List<Periode> periodes =  periodeController.getBySites(siteid);                
        %>
        <form action="findgondola.jsp">
            Username : <%=username%> 
            <table>
                <tr>
                    <td>Periode</td>
                    <td>:</td>
                    <td>
                        <select name="periodeid">
                            <% 
                            for(Periode p : periodes){%>
                                <option value="<%=p.getPeriodeid() %>"><%=p.getPeriodename()%> - <%=p.getDescription()%></option>
                            <%
                            }
                            %> 
                        </select>                      
                    </td>                   
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" value="Next" />
                    </td>
                </tr>
                    
                    
            </table>
        </form>
    </body>
</html>

