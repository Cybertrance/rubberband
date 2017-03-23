<%-- 
    Document   : connectionManager
    Created on : 18 Mar, 2017, 5:19:38 PM
    Author     : cyber
--%>

<%@page 
    contentType="text/html" 
    pageEncoding="UTF-8" 
    import="java.sql.*"
%>

<%        
    Connection con=null;
    if(con!=null){
        System.out.println("Redirect");
        return;
    }
    try{
        Class.forName("com.mysql.jdbc.Driver");  
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rubberband","root","");                                                
    }
    catch(SQLException se){
        pageContext.forward("page_500.html");
        return;
    }
    
    if(con!=null){
        
        session.setAttribute("dbConnection",con);        
        
    }
%>

