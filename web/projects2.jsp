<%-- 
    Document   : projects2
    Created on : 12 Mar, 2017, 2:30:34 PM
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
    con=(Connection)session.getAttribute("dbConnection");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>BAND Information System | Projects</title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-select-bs/css/select.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-select-bs/css/select.dataTables.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="custom/css/custom.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
          <jsp:include page="sidebar.jsp"></jsp:include>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">                        
            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Un-Approved Projects</h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <!-- start project list -->
                    <table id="datatable-uprojects" class="table table-striped projects">
                      <thead>
                        <tr>
                          <th style="width: 1%">#</th>
                          <th>Project Name</th>
                          <th>Registering User</th>
                          <th>Contact</th>
                          <th style="width: 15%">Action</th>
                        </tr>
                      </thead>
                      <%
                        ps=con.prepareStatement("SELECT * FROM projects WHERE STATUS=-1");
                        ps2=con.prepareStatement("SELECT NAME FROM users WHERE UID=?");
                        rs=ps.executeQuery();
                    %>
                      <tbody>
                          <%
                            int i=1;                            
                            while(rs.next()){
                                ps2.setInt(1, rs.getInt("USERID"));
                                rs2=ps2.executeQuery();
                                String uname=null;
                                while(rs2.next()){
                                    uname=rs2.getString("NAME");
                                }
                                String pdate=rs.getString("DATE").substring(0, 10);
                                String pstatus=null;
                                if(rs.getInt("status")==-1){
                                    pstatus="<button type=\"button\" class=\"btn btn-warning btn-xs\">Pending</button>";
                                }
                                else if(rs.getInt("status")==0){
                                    pstatus="<button type=\"button\" class=\"btn btn-success btn-xs\">Approved</button>";
                                }
                                else if(rs.getInt("status")==-2){
                                    pstatus="<button type=\"button\" class=\"btn btn-error btn-xs\">Not Approved</button>";
                                }
                                %><tr id="proj-<%=rs.getInt("PID")%>">
                                    <td><%=i%></td>
                                    <td>
                                        <%=rs.getString("PNAME")%>
                                        <br />
                                        <small>Added on <%=pdate%></small>
                                      </td>
                                      <td><%=uname%></td>
                                      <td><%=rs.getString("CONTACT")%></td>
                                    <td>
                                        <ul class="list-inline">
                                            <li>
                                                <button type="button" class="discard-btn btn btn-danger btn-xs">Discard</button>
                                            </li>
                                            <li>
                                                <button type="button" class="approve-btn btn btn-success btn-xs">Approve</button>
                                            </li>
                                        </ul>  
                                    </td>
                                    
                                </tr><%
                                i++;
                            }
                          %>                        
                      </tbody>
                    </table>
                    <!-- end project list -->
                    <%
                            if(request.getParameter("project-id")!=null&&request.getParameter("operation").toString().equals("1")){
                                int pid=Integer.parseInt(request.getParameter("project-id").substring(5));
                                String tl=request.getParameter("team-leader");
                                int tluid=0;
                                try{
                                    ps=con.prepareStatement("SELECT UID FROM USERS WHERE NAME LIKE ?");
                                    ps.setString(1, tl);
                                    rs=ps.executeQuery();
                                    while(rs.next()){
                                        tluid=rs.getInt("UID");
                                    }
                                }
                                catch(SQLException e){
                                    System.out.println("SQL: "+e);
                                }
                                try{
                                    ps=con.prepareStatement("UPDATE projects SET STATUS=0,INCHARGE=? WHERE PID=?");
                                    ps.setInt(1,tluid);
                                    ps.setInt(2,pid);
                                    ps.execute();                                    
                                }
                                catch(SQLException e){
                                    System.out.println("SQL: "+e);
                                }
                            }
                            if(request.getParameter("project-id")!=null&&request.getParameter("operation").toString().equals("2")){
                                int pid=Integer.parseInt(request.getParameter("project-id").substring(5));
                                try{
                                    ps=con.prepareStatement("UPDATE projects SET STATUS=-2 WHERE PID=?");
                                    ps.setInt(1,pid);
                                    ps.execute();                                    
                                }
                                catch(SQLException e){
                                    System.out.println("SQL: "+e);
                                }
                            }
                    %>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
                  <div id="project_modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2">Select Team Lead</h4>
                        </div>
                        <div class="modal-body">
                            <%
                                stmt=con.createStatement();
                                rs=stmt.executeQuery("SELECT NAME FROM users WHERE TYPE=1");
                            %>
                            <form class="form-horizontal form-label-left">
                                <div class="item form-group">                                  
                                  <div class="col-md-12 col-sm-12 col-xs-12">
                                      <select id="sel-team-lead" class="select2_multiple form-control" required>
                                        <option>Choose Member</option>
                                        <%while(rs.next()){
                                            %>
                                            <option><%=rs.getString("NAME")%></option>
                                        <%
                                        }%>
                                      </select>
                                  </div>
                                </div>
                                <div class="modal-footer">
                                    <button id="team-lead-close" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button id="team-lead-save" type="button" class="btn btn-primary">Save</button>
                                  </div>
                            </form>
                        </div>
                        

                      </div>
                    </div>
                  </div>
                  <div id="p_modal" data-toggle="modal" data-target="#project_modal"></div>
        <!-- /page content -->

        <!-- footer content -->
        <footer>
          <div class="pull-right">
              
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="vendors/nprogress/nprogress.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- validator -->
    <script src="vendors/validator/validator.js"></script>
    <!-- Datatables -->
    <script src="vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="vendors/jszip/dist/jszip.min.js"></script>
    <script src="vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="vendors/pdfmake/build/vfs_fonts.js"></script>    
    <script src="vendors/datatables.net-select/js/dataTables.select.min.js"></script>
    
    <!-- Custom Theme Scripts -->
    <script src="custom/js/custom.js"></script>
  </body>
</html>