<%-- 
    Document   : projects
    Created on : 12 Mar, 2017, 1:07:33 PM
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
    <!-- PNotify -->
    <link href="vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    <link href="vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">

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
                    <h2>Active Projects</h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg"><i class="fa fa-plus"></i>  Add Project</button>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <!-- start project list -->
                    <table id="datatable-projects" class="table table-striped projects">
                      <thead>
                        <tr>
                          <th style="width: 1%">#</th>
                          <th style="width: 20%">Project Name</th>
                          <th>Project Lead</th>
                          <th>Project Progress</th>
                          <th>Status</th>
                          <th style="width: 20%">Edit</th>
                        </tr>
                      </thead>
                      <%
                        ps=con.prepareStatement("SELECT * FROM projects WHERE STATUS>-1 AND ISDELETE=0");
                        ps2=con.prepareStatement("SELECT NAME FROM users WHERE UID=?");
                        rs=ps.executeQuery();
                    %>
                      <tbody>
                          <%
                            int i=1;                            
                            while(rs.next()){
                                ps2.setInt(1, rs.getInt("INCHARGE"));
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
                                    pstatus="<button type=\"button\" class=\"btn btn-success btn-xs\">Active</button>";
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
                                      <td class="project_progress">
                                        <div class="progress progress_sm">
                                          <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="57"></div>
                                        </div>
                                        <small>57% Complete</small>
                                      </td>
                                      <td><%=pstatus%></td>
                                    <td>
                                        <button type="button" class="btn-view btn btn-primary btn-xs"><i class="fa fa-folder"></i> View </button>                                        
                                        <button type="button" class="btn-delete btn btn-danger btn-xs"><i class="fa fa-trash-o"></i> Delete </button>
                                      </td>
                                    
                                </tr><%
                                i++;
                            }
                          %>                           
                      </tbody>
                    </table> 
                      <%
                            if(request.getParameter("project-id")!=null&&request.getParameter("operation").toString().equals("0")){
                                int pid=Integer.parseInt(request.getParameter("project-id").substring(5));
                                try{
                                ps=con.prepareStatement("UPDATE projects SET ISDELETE=1 WHERE PID=?");
                                ps.setInt(1,pid);
                                ps.execute();
                                }
                                catch(SQLException e){
                                    System.out.println("SQL: "+e);
                                }
                            }
                            
                           
                                if(request.getParameter("project-id")!=null&&request.getParameter("operation").toString().equals("1")){
                                System.out.println("Inside");
                                int pid=Integer.parseInt(request.getParameter("project-id").substring(5));
                                session.setAttribute("activeProject",pid);                                
                                response.sendRedirect("project_details.jsp");                                                                                                
                                return;
                            }

                          %>
                    <!-- end project list -->

                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel">Add Project</h4>
                        </div>
                        <div class="modal-body">
                            <form class="form-horizontal form-label-left" action="projectAdd.jsp" method="POST">
                                <%
                                stmt=con.createStatement();
                                rs=stmt.executeQuery("SELECT NAME FROM users WHERE TYPE=1");
                                %>

                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="project_name">Project Name <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" name="project_name" required="required" type="text">
                                  </div>
                                </div>
                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="institution_name">Institution Name <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" class="form-control col-md-7 col-xs-12" name="institution_name" required="required" type="text">
                                  </div>
                                </div>
                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="institution_str">Institution Strength <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" class="form-control col-md-7 col-xs-12" name="institution_str" required="required" type="number">
                                  </div>
                                </div>
                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="contact_name">Contact Person <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" name="contact_name" required="required" type="text">
                                  </div>
                                </div>
                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="contact">Contact <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" name="contact" required="required" type="number">
                                  </div>
                                </div>
                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="project_lead">Project Lead <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                      <select name="project_lead" class="select2_multiple form-control" required>
                                        <option value="">Choose Member</option>
                                        <%while(rs.next()){
                                            %>
                                            <option value="<%=rs.getString("NAME")%>"><%=rs.getString("NAME")%></option>
                                        <%
                                        }%>
                                      </select>
                                  </div>
                                </div>
                                
                                
                                  <div class="modal-footer">
                                    <button type="reset" class="btn btn-default">Reset</button>
                                    <button type="button" class="btn btn-info" data-dismiss="modal">Cancel</button>
                                    <button name="projSubmit2" type="submit" class="btn btn-success">Submit</button>
                                  </div>
                                
                              </form>
                                      <%
                                        if(request.getParameter("projSubmit2")!=null){                                            
                                                                    
                                        }
                                      %>
                        </div>
                        

                      </div>
                    </div>
                  </div>
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
    <!-- PNotify -->
    <script src="vendors/pnotify/dist/pnotify.js"></script>
    <script src="vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <script src="vendors/pnotify/dist/pnotify.confirm.js"></script>
    
    <!-- Custom Theme Scripts -->
    <script src="custom/js/custom.js"></script>
  </body>
</html>
