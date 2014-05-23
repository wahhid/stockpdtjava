<%-- 
    Document   : inputdata
    Created on : May 22, 2012, 11:00:32 AM
    Author     : root
--%>

<%@page import="org.jakc.stockpdt.entity.Periode"%>
<%@page import="org.jakc.stockpdt.controller.PeriodeController"%>
<%@page import="org.jakc.stockpdt.entity.Transstock"%>
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
                                   
            Transstock transstock = (Transstock) session.getAttribute("transstock");
            int transcount = transstock.getTranscount();
            
            String periodeid = (String) session.getAttribute("periodeid");
            Periode periode = periodeController.getByPeriodeid(periodeid);
            
            
            int currentsession=0;
            String periodename=null;
            if(periode != null){
                currentsession = periode.getPeriodesession();
                periodename = periode.getPeriodename();
            }else{
                response.sendRedirect("index.jsp");
            }
            if(request.getParameter("ean") != null){                                   
                String ean = request.getParameter("ean");
                System.out.println("Ean : " + ean);                              
               if(ean.length() > 0){
                   session.setAttribute("ean", ean);
                   response.sendRedirect("collectdata.jsp");
               }
            }else{
                System.out.println("Ean null");
            }
        %>
        
        <form method="POST">
            <table border="1">
                <tr>
                    <td>Site</td>
                    <td><%=session.getAttribute("siteid") %></td>
                </tr>
                <tr>
                    <td>Periode</td>
                    <td><%=periodename %></td>
                </tr>
                <tr>
                    <td>Ean</td>
                    <td><input type="text" name="ean" value=""/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Submit"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><a href="closetrans.jsp">Close Transaction</a></td>
                </tr>
                <tr>
                    <td></td>
                    <td>Session <%=currentsession %></td>
                </tr>                   
            </table>                             
        </form>        
    </body>
</html>
