<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DCAC - Major Project">
    <meta name="author" content="Zahed Shareef">
    <title>DCAC</title>
    <jsp:useBean class="product.product" id="product" scope="session"></jsp:useBean>
    <%@page import="java.sql.*, database.*" %>
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/animate.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
</head>
<body style="background-color: #f8f8f8;">
    <%
    if (session.getAttribute("user") == null ){// THen new user, show join now
        %>
        <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
    <%
    }else {
        %>
        <jsp:include page="includesPage/_logout.jsp"></jsp:include>
    <%
    }
    %>
     <div class="container">
       <div class="col-md-4 col-md-push-4"> 
         <div class="card card-signin" style="background-color: #2c3e50;color: #fff;">
              <img class="img-circle profile-img" src="../assets/img/multi/profile.png" alt="">
                <form class="form-signin" autocomplete="on" method="post" action="admin_login">
                    <h6 class="form-signin-heading text-center" style="color: #fff;">Administrator Login<br /><small>Caution! Dragons Ahead</small></h6>
                    <div class="form-group">
                        <label class="sr-only">Email</label>
                        <input type="email" class="form-control" name="email" placeholder="Administrator Email" required autofocus/>
                    </div>
                    <div class="form-group">
                        <label class="sr-only">Password</label>
                        <input type="password" class="form-control" name="pass" placeholder="Administrator Password" required/>
                    </div>
                    <div class="form-group text-center">
                        <input class="btn button-primary btn-block" type="submit" value="Login"/>
                    </div>
                    <div class="pull-right">
                    <small>Read the </small><a href="#"><small>Terms and Conditions</small></a>
                    </div>
                </form>
           </div>
       </div>
     </div>
</body>
</html>
