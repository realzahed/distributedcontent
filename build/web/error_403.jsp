<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DCAC - Major Project">
    <meta name="author" content="Zahed Shareef">
    <title>DCAC Access Denied</title>        
    <!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
</head>
<body> 
        <%
            if (session.getAttribute("user") == null) {// THen new user, show join now
%>
        <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
        <%        } else {
        %>
        <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%            }
        %>
        <div class="container">
          <div class="row">
            <div class="col-md-8">
                <div class="well-lg" style="margin-top: 2%;">
                <h3>Access Forbidden</h3>
                <h4 class="lead">You do not permissions to access the requested webpage.</h4>
                <h4 class="lead">The nav-bar above might help you get back on track.</h4>
              </div>
            </div>
            <div class="col-md-4">
              <div style="margin-top:20%;">
                <img src="assets/img/error.png" alt='error'/>
                <blockquote>Error 403</blockquote>
              </div>
            </div>
          </div>
        </div>
    </body>
</html>

