<%-- 
    Document   : resultgondola
    Created on : May 10, 2012, 4:32:52 PM
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
            
            GondolaController gondolaController = new GondolaController();
            TransstockController transstockController = new TransstockController();                                  
            String nik = (String) session.getAttribute("nik");
            String username = (String) session.getAttribute("username");                         
            String siteid = (String) session.getAttribute("siteid");
            String periodeid = (String) session.getAttribute("periodeid");
            String periodename = periodeid.substring(5);
            String gondolaname = "";            
            String progress = "";
            String status = "";
            String operator = "";                                    
            String gondolaid = siteid + request.getParameter("gondolaid");           
            Gondola gondola = gondolaController.findBySite(siteid, gondolaid);
            if(gondola!=null){                
                session.setAttribute("gondolaid", gondolaid);               
                gondolaname = gondola.getGondolaname();
                Transstock transstock = transstockController.findTransstock(siteid, periodeid, gondolaid);
                if(transstock == null){
                    progress = "New";
                }else{
                    if(gondola.getProgress() == 0){
                        progress = "Counted";
                    }else{
                        progress = "Completed";
                    }
                }
                if(gondola.getStatus()){
                    status = "In Use";
                }else{
                    status = "Not Use";
                }
                out.println("Username : " + username);               
                out.println("<table border=1>");
                out.println("<tr>");
                out.println("<td>Site</td><td>:</td>");                
                out.println("<td>");
                out.println(siteid);
                out.println("</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Periode</td><td>:</td>");                
                out.println("<td>");
                out.println(periodename);
                out.println("</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Gondola Name</td><td>:</td>");                
                out.println("<td>");
                out.println(gondolaname);
                out.println("</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Progress</td><td>:</td>");                
                out.println("<td>");
                out.println(progress);                
                out.println("</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Status</td><td>:</td>");                
                out.println("<td>");
                out.println(status);                
                out.println("</td>");
                out.println("</tr>");                
                out.println("<tr>");
                out.println("<td>User</td><td>:</td>");                
                out.println("<td>");
                out.println(nik);
                out.println("</td>");
                out.println("</tr>");   
                out.println("<tr>");
                out.println("<td></td><td></td>");                
                out.println("<td>");
                if(gondola.getStatus()){
                    out.println("Start");
                }else{
                    out.print("<a href=findtransstock.jsp>Start</a>");                               
                }                
                out.println("</td>");
                out.println("</tr>"); 
                out.println("</table>");
                out.println("<a href=findgondola.jsp>Back</a>");
            }else{
                out.println("Username : " + username + "<br/>");
                out.println("Gondola Not Found <br/>");
                out.println("<a href=findgondola.jsp>Back</a>");
            }            
        %>
    </body>
</html>
