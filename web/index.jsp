<%@page import="org.jakc.stockpdt.entity.Site"%>
<%@page import="java.util.List"%>
<%@page import="org.jakc.stockpdt.controller.PeriodeController"%>
<%@page import="org.jakc.stockpdt.controller.SiteController"%>
<%@page import="org.jakc.stockpdt.util.HashingPassword"%>
<%@page import="org.jakc.stockpdt.entity.Employee"%>
<%@page import="org.jakc.stockpdt.controller.EmployeeController"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : Apr 18, 2012, 11:03:56 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stock System - Ranch Market</title>
        <script type="text/javascript">
            document.forms['form'].elements['username'].focus();            
        </script>
    </head>
    <body>                    
        <%     
            session.setAttribute("loginstatus", false);            
            session.removeAttribute("nik");
            session.removeAttribute("username");
            session.removeAttribute("siteid");
            session.removeAttribute("periodeid");
            session.removeAttribute("gondolaid");
            
            EmployeeController employeeController = new EmployeeController();
            SiteController siteController = new SiteController();                    
            List<Site> sites = siteController.getAll();
            HashingPassword hashingPassword = new HashingPassword();
            String message="";
            String username = request.getParameter("username");
            String password = request.getParameter("password");  
            String siteid = request.getParameter("siteid");
                     
            if(username != null && password != null){
                password = hashingPassword.generateHash(password);
                Employee employee = employeeController.CheckLogin(username, password);
                if(employee != null){
                    session.setAttribute("nik",employee.getNik());
                    session.setAttribute("username", employee.getFullname());
                    session.setAttribute("loginstatus",true);
                    session.setAttribute("siteid", siteid);
                    response.sendRedirect("periodelist.jsp");
                }else{
                    message="Username or Password Wrong!";
                }
            }
        %>

        
        <form id="form" action="index.jsp" method="POST">
            <table border="0">
                <tr>
                    <td>User ID</td>
                    <td>:</td>
                    <td><input type="text" name="username" value="" /></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>:</td>
                    <td><input type="password" name="password" value="" /></td>
                </tr>
                <tr>                    
                    <td>Site</td>                    
                    <td>:</td>                    
                    <td>
                        <select name="siteid">
                            <% 
                            for(Site s : sites){%>
                                <option value="<%=s.getSiteid()%>"><%=s.getBranchname() %> </option>
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
                        <input type="submit" value="Login" />
                    </td>
                </tr>
            </table>                
            <%=message%>
        </form>        
    </body>
</html>
