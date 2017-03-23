<%-- 
    Document   : project_req
    Created on : 23 Mar, 2017, 12:36:44 PM
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

    <title>BAND Information System | Request Project</title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
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
          
        </div>
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">            
            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Request Project</h2>                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                      <div class="modal-body">
                          <form class="form-horizontal form-label-left" action="project_req.jsp" method="POST" onsubmit="customPN('Success!','Project Added','success')">

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
                                    <input class="form-control col-md-7 col-xs-12" name="institution_name" required="required" type="text">
                                  </div>
                                </div>
                                <div class="item form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="institution_str">Institution Strength <span class="required">*</span>
                                  </label>
                                  <div class="col-md-6 col-sm-6 col-xs-12">
                                    <input class="form-control col-md-7 col-xs-12" name="institution_str" required="required" type="number">
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
                                
                                
                                  <div class="modal-footer">
                                        <button type="reset" class="btn btn-default">Reset</button>                                    
                                        <button type="submit" name="projSubmit" class="btn btn-success">Submit</button>
                                  </div>                                
                              </form>                          
                          <%
                            if(request.getParameter("projSubmit")!=null){
                                try{
                                    ps=con.prepareStatement("INSERT INTO PROJECTS(PNAME,INAME,ISTRENGTH,CONTACTNAME,CONTACT,USERID) VALUES (?,?,?,?,?,?)");
                                    ps.setString(1,request.getParameter("project_name"));
                                    ps.setString(2,request.getParameter("institution_name"));
                                    ps.setString(3,request.getParameter("institution_str"));
                                    ps.setString(4,request.getParameter("contact_name"));
                                    ps.setString(5,request.getParameter("contact"));
                                    ps.setInt(6,Integer.parseInt(session.getAttribute("userid").toString()));
                                    ps.execute();
                                    session.setAttribute("notify",0);
                                    response.sendRedirect("index2.jsp");
                                }
                                catch(SQLException se){
                                    System.out.println("SQL: "+se);
                                }                                
                            }
                          %>
                        </div>
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
    <!-- PNotify -->
    <script src="vendors/pnotify/dist/pnotify.js"></script>
    <script src="vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <script src="vendors/pnotify/dist/pnotify.confirm.js"></script>

    
    <!-- Custom Theme Scripts -->
    <script src="custom/js/custom.js"></script>
  </body>
</html>
