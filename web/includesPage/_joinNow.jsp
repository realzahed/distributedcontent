<style type="text/css">
    #topLogin{background-color:#f7f5fa;color:#fff;margin-bottom:20px;margin-top:-20px;-moz-box-shadow:inset 0 -10px 5px -7px #888;-webkit-box-shadow:inset 0 -10px 5px -7px #888;box-shadow:inset 0 -10px 5px -7px #888}#signUp{background-color:#e74c3c;margin-bottom:20px;margin-top:-20px;-moz-box-shadow:inset 0 -10px 5px -7px #222;-webkit-box-shadow:inset 0 -10px 5px -7px #222;box-shadow:inset 0 -10px 5px -7px #222}#adminLogin{background-color:#f8f8f8;margin-bottom:20px;margin-top:-20px;-moz-box-shadow:inset 0 -10px 5px -7px #c5c5c5;-webkit-box-shadow:inset 0 -10px 5px -7px #c5c5c5;box-shadow:inset 0 -10px 5px -7px #c5c5c5}
</style>
<nav class="navbar navbar-default" role="navigation">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand visible-lg" href="index.jsp"><img src="http://i.imgur.com/GOQ1LDH.png" width="30" alt="logo-nav"/> Major Project <em><small>dcac</small></em></a>
      <a class="navbar-brand hidden-lg" href="index.jsp"><img src="http://i.imgur.com/GOQ1LDH.png" width="20" alt="logo-nav"/> <em><small>dcac</small></em></a>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav hidden-xs">
        <li><a href="#main"><i class="fa fa-globe fa-fw fa-lg"></i>Home</a></li>
        <li><a href="faq.jsp"><i class="fa fa-cutlery fa-fw fa-lg"></i>Help</a></li>
        <li><a href="contact-support.jsp"><i class="fa fa-phone fa-fw fa-lg"></i>Contact</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right hidden-xs">
        <li><a href="#" id="join" class="showForm">Login</a></li>
        <li><a href="#" id="join" class="showForm-signup">SignUp</a></li>
      </ul>
      <ul class="nav navbar-nav nav-pills visible-xs">
        <li><a href="#main"><i class="fa fa-globe fa-fw fa-lg"></i>Home</a></li>
        <li><a href="faq.jsp"><i class="fa fa-cutlery fa-fw fa-lg"></i>Help</a></li>
        <li><a href="contact-support.jsp"><i class="fa fa-phone fa-fw fa-lg"></i>Contact</a></li>
        <li><a href="#" id="join" class="showForm"><i class="fa fa-sign-in fa-fw fa-lg"></i>Login</a></li>
        <li><a href="#" id="join" class="showForm-signup"><i class="fa fa-random fa-fw fa-lg"></i>Sign Up</a></li>
      </ul>
        <div class="col-sm-3 col-md-3 navbar-right">
          <form class="navbar-form" role="search">
            <div class="input-group">
                <input type="text" id="search" class="form-control" placeholder="Search">
                <div class="input-group-btn">
                    <button style="background-color: #f2f2f2" class="btn" type="submit" disabled=""><i class="fa fa-search"></i></button>
                </div>
            </div>
          </form>
      </div>
    </div><!--/.navbar-collapse -->  
  </div>
</nav>
<div id="topLogin" class="animated fadeInDownBig">
    <div class="container center-block">
        <div class="row">
          <div class="col-md-4 col-md-push-4" style="margin: 1%;">
            <div class="card card-signin" style="background-color: #302244;color: #fff;" id= "loginForm">
                <img class="img-circle profile-img hidden-xs" src="http://i.imgur.com/Aivv3ph.png" alt="">
                <form class="form-signin" autocomplete="on" method="post" action="loginServlet"  name="login">
                    <h6 class="form-signin-heading text-center" style="color: #f2f2f2;">Welcome Back!<br /><small>You&apos;re almost there.</small></h6> 
                    <div class="form-group">
                        <label class="sr-only">Email</label>
                        <input type="email" class="form-control" name="email" placeholder="Email" autofocus required/>
                    </div>
                    <div class="form-group">
                        <label class="sr-only">Password</label>
                        <input type="password" class="form-control" name="pass" placeholder="Password" required/>
                    </div>
                    <div class="form-group text-center">
                        <input type="submit" value="Sign In" class="btn btn-outline btn-block" />
                    </div>
                    <div class="text-right">
                        <small>Read the </small><a href="#" style="text-decoration: none;"><small>Terms and Conditions</small></a><br>
                        <a href="#" style="text-decoration: none;color: seashell;font-size: 105%;" class="showForm-admin"><small>Sign in As Administrator</small></a>
                    </div>
                </form>
              </div>
              <div class="text-center">
                  <h5 style="color: #000;">Don't Have an Account? <a href="#" style="text-decoration: none;" id="join" class="showForm-signup">Sign Up!</a></h5>
              </div>
          </div>  
         </div>
        </div>
    </div>
    <div id="signUp">
        <div class="container">
           <div class="col-md-4 col-md-push-4" style="margin: 1%;">
             <div class="card card-signin">
                 <img class="img-circle profile-img hidden-xs" src="http://i.imgur.com/sVsG5hv.png" alt="">
                <form class="form-signin" autocomplete="on" method="POST" action="register" name="registerServlet">
                    <h6 class="form-signin-heading text-center">Create an Account<br /><small>It takes less than a minute</small></h6>
                    <div class="form-group">
                        <label class="sr-only">Email</label>
                        <input type="email" class="form-control" name="emailReg" placeholder="Email" required/>
                        <small class="help-block">This will be your Username</small>
                    </div>
                    <div class="form-group">
                        <label class="sr-only">Password</label>
                        <input type="password" class="form-control" name="passReg" placeholder="Password" required/>
                        <small class="help-block">Choose something that&apos;s easy to remember but hard to guess. 6 characters min.</small>
                    </div>
                    <div class="form-group">
                        <label class="sr-only">Confirm Password</label>
                        <input type="password" class="form-control" name="passAgainReg" placeholder="Confirm Password" required/>
                    </div>
                    <div class="form-group text-center">
                        <input type="submit" value="Register" class="btn btn-bsu btn-block" />
                    </div>
                    <div class="pull-right">
                    <small>I accept the </small><a href="#"><small>Terms and Conditions</small></a>
                    </div>
                </form>
            </div>
        </div>
    </div><!--row-->
</div><!--container-->

<!--Admin Login-->
<div id="adminLogin">
    <div class="container">
        <div class="col-md-4 col-md-push-4" style="margin: 1%;"> 
            <div class="card card-signin" style="background-color: #2c3e50;color: #fff;">
              <img class="img-circle profile-img hidden-xs" src="http://i.imgur.com/f0UYbtD.png" alt="">
                <form class="form-signin" autocomplete="on" method="post" action="admin_login">
                    <h6 class="form-signin-heading text-center" style="color: #fff;">Administrator Login<br /><small>Caution! Dragons Ahead</small></h6>
                    <div class="form-group">
                        <label class="sr-only">Email</label>
                        <input type="email" class="form-control" name="email" placeholder="Administrator Email" required autofocus/>
                        <small style="color: #fff;" class="help-block">The e-mail assigned to you by Administrator</small>
                    </div>
                    <div class="form-group">
                        <label class="sr-only">Password</label>
                        <input type="password" class="form-control" name="pass" placeholder="Administrator Password" required/>
                        <small style="color: #fff;" class="help-block">The password assigned to you by Administrator</small>
                    </div>
                    <div class="form-group text-center">
                        <input class="btn btn-facebook btn-block" type="submit" value="Login"/>
                    </div>
                    <div class="text-right">
                      <small>Read the </small><a href="#"><small>Terms and Conditions</small></a><br>
                      <a href="#" style="color: #f9f9f9; text-decoration: none;" class="showForm"><small>Sign in As A Standard User</small></a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--/.Admin Login-->
   <%
    if (session.getAttribute("admin") != null){
        %>
<script type="text/javascript">
var $, document, searchbar;
$(document).ready(function () {     
    $('#search').keyup(function () {
        "use strict";
        searchbar = $('#search').val();
        //searchbar = $('#search').attr('value');
        if (searchbar.length >= 3) {
        //$('#loadSearches').load('findProductLoad.jsp', {searchbar:searchbar});            
            $('#loadSearches').css('display');
            $.get('findProductLoad.jsp', {searchbar: searchbar}, function (data) {
                    //alert (data);
                if (data.length > 760) {
                    $('#loadSearches').html(data).slideDown(500);
                } else {
                    $('#loadSearches').slideUp(500);
                    $('#loadSearches').html("");
                }
            });
        
        } else {
            $('#loadSearches').slideUp(500);
            $('#loadSearches').html("");
        }
    });
});  
</script>
<%
    } else {
        %>
<script type="text/javascript">
var $, document, searchbar;
$(document).ready(function () {
    "use strict";
    $('#search').keyup(function () {
        searchbar = $('#search').val();
        if (searchbar.length >= 3) {
            $('#loadSearches').css('display');
            $.get('findProductLoad_1.jsp', {searchbar: searchbar}, function (data) {
                    //alert (data);
                if (data.length > 760) {
                    $('#loadSearches').hide().html(data).slideDown(500);
                } else {
                    $('#loadSearches').slideUp(500);
                    $('#loadSearches').html("");
                }
            });
        } else {
            $('#loadSearches').slideUp(500);
            $('#loadSearches').html("");
        }
    });
});
</script>
<script src="../js/jquery-1.7.2.min.js"></script>
<%
    }
%>
<div class="container" id="loadSearches"></div>