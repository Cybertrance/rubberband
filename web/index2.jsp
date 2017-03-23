<%-- 
    Document   : index2
    Created on : 19 Mar, 2017, 7:55:39 PM
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
ResultSet rs=null;
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
                    <h2>Your Projects</h2>                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <!-- start project list -->
                    <%
                        ps=con.prepareStatement("SELECT * FROM projects WHERE USERID=?");
                        ps.setInt(1, Integer.parseInt(session.getAttribute("userid").toString()));
                        rs=ps.executeQuery();
                    %>
                    <table class="table table-striped projects">
                      <thead>
                        <tr>
                          <th style="width: 5%">#</th>
                          <th>Project Name</th>                          
                          <th style="width: 10%">Status</th>
                        </tr>
                      </thead>
                      <tbody>
                          <%
                            int i=1;
                            if(!rs.isBeforeFirst()){
                                %>
                                <tr>
                                    <td colspan="3" align="center">No Data</td>
                                </tr>
                                <%
                            }
                            while(rs.next()){                                
                                String pdate=rs.getString("DATE").substring(0, 10);
                                String pstatus=null;
                                if(rs.getInt("status")==-1){
                                    pstatus="<button type=\"button\" align=\"center\" width=\"100%\" class=\"btn btn-warning btn-xs\">Pending</button>";
                                }
                                else if(rs.getInt("status")==0){
                                    pstatus="<button type=\"button\" align=\"center\" width=\"100%\" class=\"btn btn-success btn-xs\">Approved</button>";
                                }
                                else if(rs.getInt("status")==-2){
                                    pstatus="<button type=\"button\" align=\"center\" width=\"100%\" class=\"btn btn-error btn-xs\">Not Approved</button>";
                                }
                                %><tr>
                                    <td><%=i%></td>
                                    <td>
                                        <%=rs.getString("PNAME")%>
                                        <br />
                                        <small>Added on <%=pdate%></small>
                                      </td>
                                    <td><%=pstatus%></td>
                                    
                                </tr><%
                                i++;
                            }
                          %>                        
                      </tbody>
                    </table>
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
                            <form class="form-horizontal form-label-left" novalidate>

                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="project-name">Project Name <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" class="form-control col-md-7 col-xs-12" data-validate-length-range="4" name="project-name" required="required" type="text">
                                  </div>
                                </div>
                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="institution-name">Institution Name <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" class="form-control col-md-7 col-xs-12" data-validate-length-range="4" name="institution-name" required="required" type="text">
                                  </div>
                                </div>
                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="institution-str">Institution Strength <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input id="name" class="form-control col-md-7 col-xs-12" name="institution-str" required="required" type="number">
                                  </div>
                                </div>
                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="number">Team Members <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                      <select class="select2_multiple form-control required" multiple="multiple">
                                        <option>Choose Member(s)</option>
                                        <option>Person 1</option>
                                        <option>Person 2</option>
                                        <option>Person 3</option>
                                      </select>
                                  </div>
                                </div>
                                
                                
                                  <div class="modal-footer">
                                    <button type="reset" class="btn btn-default">Reset</button>
                                    <button type="button" class="btn btn-info" data-dismiss="modal">Cancel</button>
                                    <button id="send" type="submit" class="btn btn-success">Submit</button>
                                  </div>
                                
                              </form>
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
    <!-- validator -->
    <script src="vendors/validator/validator.js"></script>
    
    <!-- Custom Theme Scripts -->
    <script src="custom/js/custom.js"></script>
  </body>
</html>
