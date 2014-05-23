<%-- 
    Document   : findtransstock
    Created on : May 10, 2012, 6:37:37 PM
    Author     : root
--%>

<%@page import="org.jakc.stockpdt.controller.GondolaController"%>
<%@page import="java.util.Date"%>
<%@page import="org.jakc.stockpdt.controller.TransstockController"%>
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

            TransstockController transstockController = new TransstockController();
            GondolaController gondolaController = new GondolaController();
            
            String nik = (String) session.getAttribute("nik");
            String username = (String) session.getAttribute("username");
            String gondolaid = (String) session.getAttribute("gondolaid");            
            String siteid = (String) session.getAttribute("siteid");
            String periodeid = (String) session.getAttribute("periodeid");
            //Set Gondola In Use
            gondolaController.close(gondolaid,true);
            
            Transstock transstock = new Transstock();            
            if(siteid != null && periodeid != null){
                transstock = transstockController.findTransstock(siteid, periodeid, gondolaid);
                if(transstock == null){
                    Transstock o  = new Transstock();
                    o.setSiteid(siteid);
                    o.setPeriodeid(periodeid);
                    o.setNik(nik);
                    o.setGondolaid(gondolaid);
                    o.setStatus(true);
                    o.setCreatedby(nik);
                    o.setCreateddate(new Date(System.currentTimeMillis()));
                    o.setUpdatedby(nik);
                    o.setUpdateddate(new Date(System.currentTimeMillis()));                     
                    o = transstockController.insertData(o);
                    session.setAttribute("transstock", o);                         
                    response.sendRedirect("inputdata.jsp");
                }else{
                    if(transstock.getStatus()){
                        session.setAttribute("transstock", transstock);
                        response.sendRedirect("inputdata.jsp");
                    }else{
                        response.sendRedirect("notitransstock.jsp");
                    }
                }
            }
        %>
    </body>
</html>
