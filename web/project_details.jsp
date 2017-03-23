<%-- 
    Document   : project_details
    Created on : 18 Mar, 2017, 12:56:49 PM
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

String pname=null;
String iname=null;
String istrength=null;
String contactp=null;
String contact=null;
String incharge=null;
String submittedby=null;
String status=null;
String createDate=null;
%>
<%    
    session.setAttribute("activeProject",1);
    //con=(Connection)session.getAttribute("dbConnection");
    Class.forName("com.mysql.jdbc.Driver");  
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rubberband","root","");  
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>BAND Information System | Project Details</title>

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

    <!-- Custom Theme Style -->
    <link href="custom/css/custom.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <jsp:include page="sidebar.jsp"></jsp:include>
        <%
            ps=con.prepareStatement("SELECT * FROM projects WHERE PID=?");
            ps2=con.prepareStatement("SELECT NAME FROM users WHERE UID=?");
            ps.setInt(1,Integer.parseInt(session.getAttribute("activeProject").toString()));
            rs=ps.executeQuery();
            while(rs.next()){
                ps2.setInt(1,rs.getInt("INCHARGE"));
                rs2=ps2.executeQuery();
                while(rs2.next()){
                    incharge=rs2.getString("NAME");
                }
                ps2.setInt(1,rs.getInt("USERID"));
                rs2=ps2.executeQuery();
                while(rs2.next()){
                    submittedby=rs2.getString("NAME");
                }
                pname=rs.getString("PNAME");
                iname=rs.getString("INAME");
                istrength=rs.getString("ISTRENGTH");
                status=rs.getString("STATUS");
                contactp=rs.getString("CONTACTNAME");
                contact=rs.getString("CONTACT");
                createDate=rs.getString("DATE");
            }
        %>
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">            
            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">                  
                  <div class="x_content">
                      <!-- start accordion -->
                    <div class="accordion" id="accordion1" role="tablist" aria-multiselectable="true">
                      <div class="panel">
                        <a class="panel-heading" role="tab" id="headingOne1" data-toggle="collapse" data-parent="#accordion1" href="#collapseOne1" aria-expanded="true" aria-controls="collapseOne">
                          <h4 class="panel-title">Project Statistics</h4>
                        </a>
                        <div id="collapseOne1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                          <div class="panel-body">
                            <div class="col-md-9 col-sm-9 col-xs-12">

                      <ul class="stats-overview">
                        <li>
                          <span class="name"> Project Status </span>
                          <span class="value text-success"> <%=status%> </span>
                        </li>
                        <li>
                          <span class="name"> Institute Strength </span>
                          <span class="value text-success"> <%=istrength%> </span>
                        </li>
                        <li class="hidden-phone">
                          <span class="name"> BAND Count </span>
                          <span class="value text-success"> 20 </span>
                        </li>
                      </ul>
                      <br />

                      <div id="mainb" style="height:350px;"></div>

                      <div>
                                                                       


                      </div>


                    </div>

                    <!-- start project-detail sidebar -->
                    <div class="col-md-3 col-sm-3 col-xs-12">

                      <section class="panel">

                        <div class="x_title">
                          <h2>Project Description</h2>
                          <div class="clearfix"></div>
                        </div>
                        <div class="panel-body">
                          <h3 class="green"><%=pname%></h3>
                          <div class="project_detail">
                              <br>
                              <br>
                              <p class="title">Project Leader</p>
                            <p><%=incharge%></p>
                            <p class="title">Client Name</p>
                            <p><%=contactp%></p>
                              <p class="title">Client Company</p>
                            <p><%=iname%></p>
                            <p class="title">Client Contact</p>
                            <p><%=contact%></p>
                            <p class="title">Project Created On</p>
                            <p><%=createDate%></p>
                            
                          </div>                          
                          
                        </div>

                      </section>

                    </div>
                    <!-- end project-detail sidebar -->
                          </div>
                        </div>
                      </div>
                      <div class="panel">
                        <a class="panel-heading collapsed" role="tab" id="headingTwo1" data-toggle="collapse" data-parent="#accordion1" href="#collapseTwo1" aria-expanded="false" aria-controls="collapseTwo">
                          <h4 class="panel-title">Project BANDs</h4>
                        </a>
                        <div id="collapseTwo1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                          <div class="panel-body">
                            <table id="datatable-buttons" class="table table-striped table-bordered" width="100%">
                            <%
                            ps=con.prepareStatement("SELECT * FROM bands WHERE PID=?");
                            ps.setInt(1,Integer.parseInt(session.getAttribute("activeProject").toString()));
                            rs=ps.executeQuery();
                            %>
                      <thead>
                        <tr>
                          <th>BAND ID</th>
                          <th>BAND Name</th>
                          <th>Members</th>                          
                        </tr>
                      </thead>
                      <tbody>
                          <%
                            while(rs.next()){ %>
                            <tr>
                      <td><%= rs.getInt("BANDID")%></td>
                      <td><%= rs.getString("NAME")%></td>
                      <td><%= rs.getInt("MEMBERS")%></td>
                            </tr>
                      <% } %>
                      </tbody>
                    </table>
                          </div>
                        </div>
                      </div>                      
                    <!-- end of accordion -->
                  </div>
                </div>
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
    <!-- ECharts -->
    <script src="vendors/echarts/dist/echarts.min.js"></script>
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
    
    <!-- Custom Theme Scripts -->
    <script src="custom/js/custom.js"></script>
  </body>
</html>

