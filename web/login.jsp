<%-- 
    Document   : login
    Created on : 12 Mar, 2017, 1:39:42 PM
    Author     : cyber
--%>

<%@page 
    contentType="text/html" 
    pageEncoding="UTF-8" 
    import="java.sql.*"
%>
<jsp:include page="connectionManager.jsp"></jsp:include>
<%!        
    Connection con=null;
    Statement stmt=null;
    ResultSet rs=null;
    PreparedStatement ps=null;    
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

    <title>BAND Information System Login</title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="vendors/animate.css/animate.min.css" rel="stylesheet">
    <!-- PNotify -->
    <link href="vendors/pnotify/dist/pnotify.css" rel="stylesheet">
    <link href="vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <link href="vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
    <link href="vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="custom/css/custom.css" rel="stylesheet">
       
    
  </head>

  <body class="login green_border">
      <img class="login_header" src="resources/login_header.png" alt="BAND Information System">
       <img class="login_main_image hidden-xs hidden-sm" src="resources/login_main_visual.png">
   
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>
      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
              <form action="login.jsp" method="POST"> 
              <h1>Login</h1>
              <div>
                <input type="email" name="l_name" class="form-control" placeholder="E-mail" required="" />
              </div>
              <div>
                <input type="password" name="l_password" class="form-control" placeholder="Password" required="" />
              </div>
              <div class="col-md-4 col-md-offset-3">
                <input type="submit" name="logSubmit" class="btn btn-success btn-lg" style="width:130px" value="Login"/>
                <!-- <a class="reset_pass" href="#">Lost your password?</a> -->
              </div>
              <%
              if(request.getParameter("logSubmit")!=null){
                  try{
                  ps=con.prepareStatement("SELECT * FROM USERS WHERE CONTACT LIKE ? AND PASSWORD LIKE ?");
                  ps.setString(1, request.getParameter("l_name"));
                  ps.setString(2, request.getParameter("l_password"));                  
                  
                  rs=ps.executeQuery();
                  
                  if(!rs.isBeforeFirst()){
              System.out.println("Null RS");%>
              <script type="text/javascript">
                  customPN("Error!","Invalid Login, Please try again","error");  
              </script>
                              
                  <%}
                                    
                  while(rs.next()){
                      if(rs.getString("TYPE").equals("0")){
                          session.setAttribute("loggedin",true);
                          session.setAttribute("username", rs.getString("name"));
                          session.setAttribute("userid", rs.getInt("uid"));
                          session.setAttribute("type", 0);
                          response.sendRedirect("index.jsp");
                      }
                      if(rs.getString("TYPE").equals("1")){
                          session.setAttribute("loggedin",true);
                          session.setAttribute("username", rs.getString("name"));
                          session.setAttribute("userid", rs.getInt("uid"));
                          session.setAttribute("type", 1);
                          response.sendRedirect("index.jsp");
                      }
                      if(rs.getString("TYPE").equals("2")){
                          session.setAttribute("loggedin",true);
                          session.setAttribute("username", rs.getString("name"));
                          session.setAttribute("userid", rs.getInt("uid"));
                          session.setAttribute("type", 2);
                          response.sendRedirect("index2.jsp");
                      }
                  }
                  
                      
                  }
                  catch(SQLException se){
                      System.out.println("SQL "+se);
                  }
              }
              %>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">New to site?
                  <a href="#signup" class="to_register"> Create Account </a>
                </p>
                <br />

              </div>
            </form>
          </section>
        </div>

        <div class="animate form registration_form">
          <section class="login_content">
              <form action="login.jsp" method="POST">
              <h1>Create Account</h1>
              <div>
                <input type="text" name="username" class="form-control" placeholder="Name" required="required" />
              </div>
              <div>
                <input type="email" name="email" class="form-control" placeholder="Email" required="required" />
              </div>
              <div>
                <input type="password" name="password" class="form-control"placeholder="Password" required="required" />
              </div>
              <div>
                <input type="password" class="form-control" name='password2'placeholder="Confirm Password" required="required" />
              </div>
              <div class="login_button_center">
                <input type="submit" class="btn btn-info btn-lg" style="width:130px" name="regSubmit" value="Submit"/>
              </div>
              <%
              System.out.println(request.getParameter("regSubmit"));
              if(request.getParameter("regSubmit")!=null){
                  try{
                      System.out.println("Inside");
                  ps=con.prepareStatement("INSERT INTO USERS(NAME,PASSWORD,CONTACT,TYPE) VALUES (?,?,?,2)");
                  ps.setString(1, request.getParameter("username"));
                  ps.setString(2, request.getParameter("password"));
                  ps.setString(3, request.getParameter("email"));
                  
                  ps.execute();
                  
                  response.sendRedirect("login.jsp#login");
                  }
                  catch(SQLException se){
                      System.out.println("SQL "+se);
                  }
              }
              %>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">Already a member ?
                  <a href="#signin" class="to_register"> Log in </a>
                </p>
                <br />
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>
	<footer class="login_footer">
		<div>
			<nav class="pull-right">
				<a href="http://band.us/home" target="_blank">Home</a>   
				<a href="http://band.us/about" target="_blank">About BAND</a>   
				<a href="http://band.us/press" target="_blank">Press</a>  
				<a href="https://partners.band.us/partners/en/main.nhn target="_blank"" target="_blank">Partners</a>  
				<a href="http://band.us/policy/terms target="_blank"" target="_blank">Terms of Service</a> 
				<a href="http://band.us/policy/privacy target="_blank"" target="_blank"><strong>Privacy Policy</strong></a>  
				<a href="https://developers.band.us" target="_blank">Developers</a> 
				<a href="http://band.us/cs/#!/help" target="_blank">Help</a>
			</nav>
		</div>
	</footer>
        
              <!-- jQuery -->
    <script src="vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
        
        <!-- PNotify -->
    <script src="vendors/pnotify/dist/pnotify.js"></script>
    <script src="vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <script src="vendors/pnotify/dist/pnotify.confirm.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="custom/js/custom.js"></script>
    
  </body>
</html>
