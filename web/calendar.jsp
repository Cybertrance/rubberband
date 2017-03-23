
<%@page 
    contentType="text/html" 
    pageEncoding="UTF-8" 
    import="javax.json.*,
    java.sql.*,
    java.util.*"
%>
<%    
    int lastId=-1;
    int newEvId;
    Connection con=null;
    Statement stmt=null;
    ResultSet rs=null;
    PreparedStatement ps=null;   
    try{
        Class.forName("com.mysql.jdbc.Driver");  
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rubberband","root","");        
        
        // Get Last Event ID//
        stmt=con.createStatement();
        rs=stmt.executeQuery("SELECT MAX(ev_id) FROM Events");
        lastId=rs.getInt(1);
        
        
        
    }
    catch(SQLException se){
        System.out.println(se.getMessage());
    }
    
    //Test DB Connection//
    if(con==null){
        System.out.println("No Database Connection");
    }
    //Set new EventID//
    if(lastId==-1){
        newEvId=1;
    }
    else{
        newEvId=lastId+1;
    }
    
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>BAND Information System | Calendar </title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- FullCalendar -->
    <link href="vendors/fullcalendar/dist/fullcalendar.min.css" rel="stylesheet">
    <link href="vendors/fullcalendar/dist/fullcalendar.print.css" rel="stylesheet" media="print">
    <!-- iCheck -->
    <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    <link href="vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">

    <!-- Custom styling plus plugins -->
    <link href="custom/css/custom.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
          <jsp:include page="sidebar.jsp"></jsp:include>
           
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Calendar <small>Click to add/edit events</small></h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Calendar Events <small>Sessions</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content" style="height: 100%; width: 100%;">

                    <div id='calendar'></div>

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

    <!-- calendar modal -->
    <div id="CalenderModalNew" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">

          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="myModalLabel">New Calendar Entry</h4>
          </div>
          <div class="modal-body">
            <div id="testmodal" style="padding: 5px 20px;">
                <form id="antoform" class="form-horizontal calender" role="form" action="calendar.jsp" novalidate>
                <div class="form-group">
                  <label class="col-sm-3 control-label">Title</label>
                  <div class="col-sm-9">
                    <input type="text" class="form-control" id="title" name="title" required="required" data-validate-length-range="1">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-3 control-label">Description</label>
                  <div class="col-sm-9">
                    <textarea class="form-control" style="height:55px;" id="desc" name="descr"></textarea>
                  </div>
                </div>
                  <div class="form-group">
                  <label class="col-sm-3 pull-left control-label">Event Start</label>
                  </div>
                <div class="form-group">                    
                  <label class="col-sm-3 control-label">Date</label>
                  <div class="col-sm-5">
                    <input type="date" class="form-control" id="start-date" name="start">
                  </div>
                  <label class="col-sm-1 control-label">Time</label>
                  <div class="col-sm-3">
                    <input type="time" class="form-control" id="start-time" name="start">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-3 pull-left control-label">Event End</label>
                  </div>
                <div class="form-group">                    
                  <label class="col-sm-3 control-label">Date</label>
                  <div class="col-sm-5">
                    <input type="date" class="form-control" id="end-date" name="start">
                  </div>
                  <label class="col-sm-1 control-label">Time</label>
                  <div class="col-sm-3">
                    <input type="time" class="form-control" id="end-time" name="start">
                  </div>
                </div>
                  <div class="form-group">
                  <label class="col-sm-3 control-label">All Day? </label>
                  <div class="col-sm-9">
                     <div class="checkbox" id="is-all-day">
                              <input type="checkbox" class="flat">
                          </div>
                  </div>
                  </div>                
                    <input id="newEvId" type="text" hidden value="<%=newEvId%>">
                    <div class="modal-footer">            
            <button type="button" class="btn btn-success calsubmit">Save changes</button>
            <%
            //System.out.println(request.getParameter("id")+request.getParameter("title")+request.getParameter("desc")+request.getParameter("start")+request.getParameter("end")+request.getParameter("allDay"));
            //NEW Event Entry
            if(request.getParameter("operation")!=null){
                if(request.getParameter("operation").equals("0")){
                try{
                ps=con.prepareStatement("INSERT INTO Events(ev_title,ev_start,ev_end,allDay,ev_desc) VALUES (?,?,?,?,?)");
                //ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                ps.setString(1,request.getParameter("title"));
                ps.setString(2,request.getParameter("start"));
                ps.setString(3,request.getParameter("end"));
                ps.setBoolean(4,Boolean.parseBoolean(request.getParameter("start")));
                ps.setString(5,request.getParameter("desc"));

                ps.execute();
                }

                catch(SQLException se){
                    System.out.println("SQL ERROR!!! : "+se);
                }
                }
            }            
            %>
          </div>
              </form>
            </div>
              
          </div>
          
        </div>
      </div>
    </div>
    <div id="CalenderModalEdit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">

          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="myModalLabel2">Edit Calendar Entry</h4>
          </div>
          <div class="modal-body">

            <div id="testmodal2" style="padding: 5px 20px;">
              <form id="antoform2" class="form-horizontal calender" role="form" novalidate>
                <div class="form-group">
                  <label class="col-sm-3 control-label">Title</label>
                  <div class="col-sm-9">
                    <input type="text" class="form-control" id="e_title" name="title" required="required" data-validate-length-range="1">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-3 control-label">Description</label>
                  <div class="col-sm-9">
                    <textarea class="form-control" style="height:55px;" id="e_descr" name="descr"></textarea>
                  </div>
                </div>
                  <div class="form-group">
                  <label class="col-sm-3 pull-left control-label">Event Start</label>
                  </div>
                <div class="form-group">                    
                  <label class="col-sm-3 control-label">Date</label>
                  <div class="col-sm-5">
                    <input type="date" class="form-control" id="e_start-date" name="start">
                  </div>
                  <label class="col-sm-1 control-label">Time</label>
                  <div class="col-sm-3">
                    <input type="time" class="form-control" id="e_start-time" name="start">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-3 pull-left control-label">Event End</label>
                  </div>
                <div class="form-group">                    
                  <label class="col-sm-3 control-label">Date</label>
                  <div class="col-sm-5">
                    <input type="date" class="form-control" id="e_end-date" name="start">
                  </div>
                  <label class="col-sm-1 control-label">Time</label>
                  <div class="col-sm-3">
                    <input type="time" class="form-control" id="e_end-time" name="start">
                  </div>
                </div>
                  <div class="form-group">
                  <label class="col-sm-3 control-label">All Day? </label>
                  <div class="col-sm-9">
                     <div class="checkbox" id="e_is-all-day">
                              <input type="checkbox" class="flat">
                          </div>
                  </div>
                </div>
                    <div class="modal-footer">
            <button type="button" class="btn btn-danger e_caldelete" data-dismiss="modal"><i class="fa fa-trash"></i>&nbsp;Delete Event</button>
            <%
            if(request.getParameter("operation")!=null){
                    //DELETE Event Entry
                if(request.getParameter("operation").equals("2")){
                try{                    
                ps=con.prepareStatement("UPDATE Events SET isDelete=true WHERE ev_id=?");
                ps.setInt(1, Integer.parseInt(request.getParameter("id")));                        
                ps.execute();
                }

                catch(SQLException se){
                    System.out.println("SQL ERROR!!! : "+se);
                }
                }
            }            
            %>
            <button type="button" class="btn btn-success e_calsubmit">Save changes</button>
            <%
            if(request.getParameter("operation")!=null){
                if(request.getParameter("operation").equals("1")){
                try{
                ps=con.prepareStatement("UPDATE Events SET ev_title=?, ev_start=?, ev_end=?, allDay=?, ev_desc=? WHERE ev_id=?");
                //ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                ps.setString(1,request.getParameter("title"));
                ps.setString(2,request.getParameter("start"));
                ps.setString(3,request.getParameter("end"));
                ps.setBoolean(4,Boolean.parseBoolean(request.getParameter("allDay")));
                ps.setString(5,request.getParameter("desc"));
                ps.setInt(6, Integer.parseInt(request.getParameter("id")));

                ps.execute();
                }

                catch(SQLException se){
                    System.out.println("SQL ERROR!!! : "+se);
                }
                }
            }   
            %>            
          </div>
              </form>
            </div>
          </div>
          
        </div>
      </div>
    </div>

    <div id="fc_create" data-toggle="modal" data-target="#CalenderModalNew"></div>
    <div id="fc_edit" data-toggle="modal" data-target="#CalenderModalEdit"></div>
    <!-- /calendar modal -->
        <%
        con.close();
        %>
    <!-- jQuery -->
    <script src="vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="vendors/nprogress/nprogress.js"></script>
    <!-- FullCalendar -->
    <script src="vendors/moment/min/moment.min.js"></script>
    <script src="vendors/fullcalendar/dist/fullcalendar.min.js"></script>
    <!-- iCheck -->
    <script src="vendors/iCheck/icheck.min.js"></script>
    <!-- validator -->
    <script src="vendors/validator/validator.js"></script>
    <!-- PNotify -->
    <script src="vendors/pnotify/dist/pnotify.js"></script>
    <script src="vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <script src="vendors/pnotify/dist/pnotify.confirm.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="custom/js/custom.js"></script>

  </body>
</html>
