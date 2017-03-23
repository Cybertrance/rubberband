<%-- 
    Document   : sidebar
    Created on : 12 Mar, 2017, 2:27:07 PM
    Author     : cyber
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>

<div class="col-md-3 left_col">
    <%! 
    String name=null;
%>
<%
        session.setAttribute("username","DEBUG");
        session.setAttribute("type", 0);
        session.setAttribute("userid", 1);        
        
        name=session.getAttribute("username").toString();
%>
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.html" class="site_title index_site_title"></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="resources/temp_user.jpg" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2><%=name %></h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                  <%
                  if(Integer.parseInt(session.getAttribute("type").toString())==0||Integer.parseInt(session.getAttribute("type").toString())==1){
                  %>
                <h3>Analytics and Status</h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-bar-chart-o"></i> Projects <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="index.jsp">Overview</a></li>
                      <li><a href="projects.jsp">Live Projects</a></li>
                      <li><a href="projects2.jsp">Unapproved Projects</a></li>
                    </ul>
                  </li>
                </ul>
                <%
                  }
                  else{
                %>                
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-bar-chart-o"></i> Projects <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="index2.jsp">Projects</a></li>
                      <li><a href="project_req.jsp">Request Project</a></li>                      
                    </ul>
                  </li>
                </ul>
                <%
                  }
                %>
              </div>
              <%
                  if(Integer.parseInt(session.getAttribute("type").toString())==0||Integer.parseInt(session.getAttribute("type").toString())==1){
                  %>
                <div class="menu_section">
                    <h3>Utilities</h3>
                    <ul class="nav side-menu">
                        <li><a><i class="fa fa-group"></i> Team <span class="fa fa-chevron-down"></span></a>
                            <ul class="nav child_menu">
                              <li><a href="calendar.jsp">Calendar</a></li>
                            </ul>
                        </li>
                    </ul>
                    
                </div>
              <%
                  }
              %>
              <%
                  if(Integer.parseInt(session.getAttribute("type").toString())==0){
                  %>
                  <div class="menu_section">
                    <h3>Admin and Maintenence</h3>
                    <ul class="nav side-menu">
                        <li><a><i class="fa fa-terminal"></i> Admin <span class="fa fa-chevron-down"></span></a>
                            <ul class="nav child_menu">
                              <li><a href="employee.jsp">Employee Management</a></li>
                            </ul>
                        </li>
                    </ul>
                    
                </div>
                  <%
                  }
                  %>
            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout" href="login.html">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="resources/temp_user.jpg" alt=""><%=name%>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">                    
                    <li><a href="cleanupManager.jsp"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->
