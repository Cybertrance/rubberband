<%-- 
    Document   : employeeDatatableSource
    Created on : 20 Mar, 2017, 12:13:01 AM
    Author     : cyber
--%>

<%@page contentType="text/html" 
        pageEncoding="UTF-8"
        import="java.sql.*,
        javax.json.*,
        java.util.*"
        %>
<%!        
    Connection con=null;
    Statement stmt=null;
    ResultSet rs=null;
    PreparedStatement ps=null;    
%>

<%        
    Map<String,?> jconfig=null;                    
                    try{
                        Class.forName("com.mysql.jdbc.Driver");  
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rubberband","root","");  
                    stmt=con.createStatement();
                    rs=stmt.executeQuery("SELECT UID,NAME,CONTACT FROM Users WHERE TYPE=1");
                    out.print("{\"data\": [");
                    while(rs.next()){
                                                                    
                         if(rs.isFirst()){
                             out.print("[");
                        out.print("\""+Integer.toString(rs.getInt("UID"))+"\",\""+rs.getString("NAME")+"\",\""+rs.getString("CONTACT")+"\"");
                        out.print("]");       
                         }
                         else{
                            out.print(",[");
                        out.print("\""+Integer.toString(rs.getInt("UID"))+"\",\""+rs.getString("NAME")+"\",\""+rs.getString("CONTACT")+"\"");
                        out.print("]");       
                         }
                         
                        out.flush();
                    }
                    out.print("]}");
                    }
                    catch(SQLException e){
                        System.out.println("EXCEPTION "+e);
                    }
%>