<%-- 
    Document   : calevent_source
    Created on : 11 Mar, 2017, 8:50:51 PM
    Author     : cyber
--%>

<%@page 
    contentType="application/json" 
    pageEncoding="UTF-8" 
    import="javax.json.*,
    java.sql.*,
    java.util.*"
%>
<%
    Connection con=null;
    Statement stmt=null;
    ResultSet rs=null;
    Map<String,?> jconfig=null;
                    //SET CALENDAR//
                    try{
                        Class.forName("com.mysql.jdbc.Driver");  
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rubberband","root","");  
                    stmt=con.createStatement();
                    rs=stmt.executeQuery("SELECT * FROM Events WHERE isDelete=0");
                    out.print("[");
                    while(rs.next()){
                         JsonBuilderFactory buildfactory = Json.createBuilderFactory(jconfig);
                         JsonObject jobj = buildfactory.createObjectBuilder().add("id",rs.getInt(1)).add("title",rs.getString(2)).add("start",rs.getString(3)).add("end",rs.getString(4)).add("allDay",rs.getBoolean(5)).build();                                                              
                         if(rs.isFirst()){
                             out.print(jobj);
                         }
                         else{
                            out.print(","+jobj);
                         }
                         
                        out.flush();
                    }
                    out.print("]");
                    }
                    catch(Exception e){
                        System.out.println("EXCEPTION "+e);
                    }
%>
