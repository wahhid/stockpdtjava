<%-- 
    Document   : collectdata
    Created on : Apr 22, 2012, 10:11:46 PM
    Author     : root
--%>

<%@page import="org.jakc.stockpdt.entity.Periode"%>
<%@page import="org.jakc.stockpdt.controller.PeriodeController"%>
<%@page import="org.jakc.stockpdt.entity.Transseq"%>
<%@page import="org.jakc.stockpdt.controller.TransseqController"%>
<%@page import="org.jakc.stockpdt.entity.Product"%>
<%@page import="org.jakc.stockpdt.controller.ProductController"%>
<%@page import="java.util.Date"%>
<%@page import="org.jakc.stockpdt.entity.Transstock"%>
<%@page import="org.jakc.stockpdt.controller.TranstockdetailController"%>
<%@page import="org.jakc.stockpdt.entity.Transtockdetail"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
            
            String errmessage="";
            TranstockdetailController  controller = new TranstockdetailController();
            TransseqController transseqController = new TransseqController();
            ProductController productController = new ProductController();
            PeriodeController periodeController = new PeriodeController();
            
            String siteid = (String) session.getAttribute("siteid");
            String periodeid = (String) session.getAttribute("periodeid");
            String gondolaid = (String) session.getAttribute("gondolaid");
                       
            Transstock transstock = (Transstock) session.getAttribute("transstock");
            Periode periode = periodeController.getByPeriodeid(periodeid);
            int currentsession = 0;
            String periodename=null;
            if(periode != null){
                currentsession = periode.getPeriodesession();
                periodename = periode.getPeriodename();
            }else{
                response.sendRedirect("index.jsp");
            }
            
            String nik = (String) session.getAttribute("nik");
            String ean = (String) session.getAttribute("ean");   
            Product product = productController.getProductByID(ean);
            String productname="Not Found";
            if(product != null){
                productname = product.getProductname();
            }                      
            Transtockdetail transtockdetail = controller.find(transstock.getTransid(), ean);        
            double qty=0;
            String quantity=null;
            if(request.getParameter("quantity") != null && !request.getParameter("quantity").isEmpty()){  
                quantity = request.getParameter("quantity");
                System.out.println("Quantity not null");                         
                if(Double.parseDouble(quantity) > 0){
                    if(transtockdetail != null){                                               
                       if(transtockdetail.getStatus() == true){                  
                           if(currentsession == 1){
                                transtockdetail.setQty1(Double.parseDouble(quantity));
                                transtockdetail.setQty2(Double.parseDouble(quantity));
                           }
                           if(currentsession == 2){
                                transtockdetail.setQty2(Double.parseDouble(quantity));
                           }
                           transtockdetail.setStatus(true);
                           transtockdetail.setTransdate(new Date(System.currentTimeMillis()));
                           transtockdetail.setUpdatedby(nik);
                           transtockdetail.setUpdateddate(new Date(System.currentTimeMillis()));                                        
                           controller.updateData(transtockdetail);
                       }                                     
                    }else{                    
                        Transtockdetail o = new Transtockdetail();                        
                        Transseq transseq = transseqController.getLast(siteid, periodeid, gondolaid);                    
                        if(transseq != null){
                            //Transseq Exist
                            transseq.setSequence(transseq.getSequence() + 1);                                              
                            transseqController.update(transseq);                                                                       
                            o.setSequence(transseq.getSequence());                        
                            o.setTransid(transstock.getTransid());                                                          
                            o.setProductid(ean);                                                                                         
                            o.setTransdate(new Date(System.currentTimeMillis()));                        
                            o.setQty1(Double.parseDouble(quantity));
                            o.setQty2(Double.parseDouble(quantity));
                            o.setStatus(true);
                            o.setCreatedby(nik);
                            o.setCreateddate(new Date(System.currentTimeMillis()));
                            o.setUpdatedby(nik);
                            o.setUpdateddate(new Date(System.currentTimeMillis()));    
                            controller.insertData(o);                                                                                     
                        }else{
                            Transseq newtransseq = new Transseq();
                            newtransseq.setSiteid(siteid);
                            newtransseq.setPeriodeid(periodeid);
                            newtransseq.setGondolaid(gondolaid);
                            newtransseq.setSequence(0); 
                            transseqController.create(newtransseq);           
                            newtransseq.setSequence(newtransseq.getSequence() + 1);                                              
                            transseqController.update(newtransseq);                                                                         
                            o.setSequence(newtransseq.getSequence());                                               
                            o.setTransid(transstock.getTransid());                                                          
                            o.setProductid(ean);                                                                                         
                            o.setTransdate(new Date(System.currentTimeMillis()));                        
                            o.setQty1(Double.parseDouble(quantity));
                            o.setQty2(Double.parseDouble(quantity));
                            o.setStatus(true);
                            o.setCreatedby(nik);
                            o.setCreateddate(new Date(System.currentTimeMillis()));
                            o.setUpdatedby(nik);
                            o.setUpdateddate(new Date(System.currentTimeMillis()));    
                            controller.insertData(o);                                                   
                        }
                    }           
                    response.sendRedirect("inputdata.jsp");                    
                }else{
                    errmessage = "Quantity number invalid";
                }                                                                  
            }else{
                if(transtockdetail != null){
                    qty = transtockdetail.getQty2();
                }else{
                    errmessage = "Quantity number invalid";                    
                    qty = 0;
                }
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
                    <td>Product</td>
                    <td><%=productname%></td>
                </tr>
                <tr>
                    <td>Quantity</td>                    
                    <td><input type="text" name="quantity" value="<%
                        if(qty==0){
                            out.print("");
                        }else{
                            out.print(qty);
                        }
                            %>
                    
                    " /></td>                    
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Submit" /></td>
                </tr>             
            </table>        
            <%=errmessage%><br/>    
            <a href="inputdata.jsp">Back</a>
        </form>
    </body>
</html>
