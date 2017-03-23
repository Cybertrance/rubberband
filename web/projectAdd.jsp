<%-- 
    Document   : projectAdd
    Created on : 23 Mar, 2017, 11:16:37 PM
    Author     : cyber
--%>

<%@page 
    contentType="text/html" 
    pageEncoding="UTF-8" 
    import="java.sql.*"
%>
<%!
Connection con=null;
Statement stmt=null;
PreparedStatement ps=null;
PreparedStatement ps2=null;
ResultSet rs=null;
ResultSet rs2=null;
%>
<%
    Class.forName("com.mysql.jdbc.Driver");  
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rubberband","root","");        
    //con=(Connection)session.getAttribute("dbConnection");
 %>
<%
int tluid=0;                                            
                                                try{
                                                    ps=con.prepareStatement("SELECT UID FROM USERS WHERE NAME LIKE ?");
                                                    ps.setString(1, request.getParameter("project_lead"));
                                                    rs=ps.executeQuery();
                                                    while(rs.next()){
                                                        tluid=rs.getInt("UID");
                                                    }
                                                }
                                                catch(SQLException e){
                                                    System.out.println("SQL: "+e);                                                    
                                                }
                                            try{
                                                ps=con.prepareStatement("INSERT INTO PROJECTS(PNAME,INAME,ISTRENGTH,CONTACTNAME,CONTACT,USERID,INCHARGE,STATUS) VALUES (?,?,?,?,?,?,?,?)");
                                                ps.setString(1,request.getParameter("project_name"));
                                                ps.setString(2,request.getParameter("institution_name"));
                                                ps.setString(3,request.getParameter("institution_str"));
                                                ps.setString(4,request.getParameter("contact_name"));
                                                ps.setString(5,request.getParameter("contact"));
                                                ps.setInt(6,Integer.parseInt(session.getAttribute("userid").toString()));
                                                ps.setInt(7, tluid);
                                                ps.setInt(8,0);
                                                ps.execute();                                                                                            
                                            }
                                            catch(SQLException se){
                                                System.out.println("SQL: "+se);                                                
                                            }  
                                            response.sendRedirect("projects.jsp");
%>
