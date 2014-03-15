<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DCAC - Major Project">
    <meta name="author" content="Zahed Shareef">
    <title>Oops! Error 404</title>        
    <!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
</head>
<body> 
        <%
            if (session.getAttribute("user") == null) {
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
                    <h3>Oops! Page Not found</h3>
                    <h4 class="lead">We are really sorry but the page you requested cannot be found.</h4>
                    <h4 class="lead">The nav-bar above might help you get back on track.</h4>
                    <p class="lead">Or use the search below to find your way.</p>
                    <script type="text/javascript">
                        var GOOG_FIXURL_LANG = 'en';
                        var GOOG_FIXURL_SITE = 'http://localhost:8084/index.jsp';
                    </script>
                    <script type="text/javascript"
                        src="http://linkhelp.clients.google.com/tbproxy/lh/wm/fixurl.js">
                    </script>
                </div>
              </div>
            <div class="col-md-4">
                <div class="404img" style="margin-top:25%;">
                    <img src="assets/img/error404.gif" alt='error404'/>
                </div>
            </div>
        </div>
      </div>
    </body>
</html>

