<style>
.navbar-wrapper{top:0;left:0;right:0;z-index:20;margin-top:20px}.navbar-wrapper .container{padding-left:0;padding-right:0}.navbar-wrapper .navbar{padding-left:15px;padding-right:15px}.navbar-content{width:320px;padding:15px;padding-bottom:0}.navbar-content:after,.navbar-content:before{display:table;content:"";line-height:0}.navbar-nav.navbar-right:last-child{margin-right:15px!important}.navbar-footer{background-color:#DDD}.navbar-footer-content{padding:15px}.dropdown-menu{padding:0;overflow:hidden}.nav>li>a:focus,.nav>li>a:hover{text-decoration:none}.icon-header-cart{background:url("http://i.imgur.com/Hpf9X2L.png") center center no-repeat;background-size:41px 35px;width:60px;position:relative;-webkit-transition:.2s;-moz-transition:.2s;-o-transition:.2s;transition:.2s}
</style>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.user"%>
<jsp:useBean id="cart" scope="session" class="cart.cart"></jsp:useBean>
    <%
        ArrayList<Integer> Qty = new ArrayList();
        Qty = cart.getQty();
        int totalQty = 0;
        for (int i=0; i<Qty.size(); i++){
            totalQty += Qty.get(i);
        }
        user User = (user) session.getAttribute("user");
        String email = User.getUserEmail();
        String userName = User.getUsername();
        int uid = User.getUserId();
        String printName;
        if (userName == null){
            printName = email;
        }
        else {printName = userName;}
    %>
    
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
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav hidden-xs">
                <li><a href="#main"><i class="fa fa-globe fa-fw fa-lg"></i>Home</a></li>
                <li><a href="faq.jsp"><i class="fa fa-cutlery fa-fw fa-lg"></i>Help</a></li>
                <li><a href="contact-support.jsp"><i class="fa fa-phone fa-fw fa-lg"></i>Contact</a></li>
                <li class="visible-xs"><a href="addToCart_view.jsp" class ="showForm"><i class="fa fa-shopping-cart fa-fa fa-lg"></i> View Cart</a></li>
            </ul>
            <ul class="nav navbar-right hidden-xs">
                <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="http://i.imgur.com/Aivv3ph.png" class="img-thumbnail" width="45">
                  <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <div class="navbar-content" style="background-color: #f9f9f9;">
                                <div class="row">
                                    <div class="col-md-5 hidden-xs hidden-sm">
                                        <a href="userinfo.jsp?uid=<%= uid %>">
                                            <img src="http://i.imgur.com/Aivv3ph.png" class="img-thumbnail">
                                        </a>
                                    </div>  
                                    <div class="col-md-5 visible-sm pull-left">
                                        <a href="userinfo.jsp?uid=<%= uid %>">
                                            <img src="http://i.imgur.com/Aivv3ph.png" class="img-thumbnail" width="120">
                                        </a>
                                    </div>
                                    <div class="col-md-7">
                                        <span><%= printName %></span>
                                        <p class="text-muted small">
                                            <%= email %></p>
                                        <div class="divider">
                                        </div>
                                        <div class="btn-group" role="toolbar">
                                            <a href="userinfo.jsp?uid=<%= uid %>" class="btn btn-info btn-sm">Profile</a>
                                             <%
                                                if (session.getAttribute("admin") != null){
                                            %>
                                            <a href="admin_Performance.jsp" class="btn btn-success btn-sm">Admin</a>
                                            <%
                                                }
                                            %>
                                        </div>
                                   </div>
                                </div>
                            </div>
                            <div class="navbar-footer">
                                <div class="navbar-footer-content">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <a href="userinfo.jsp?uid=<%= uid %>#Settings" class="btn btn-default btn-embossed btn-sm">Change Password</a>
                                        </div>
                                        <div class="col-md-6">
                                            <a href="_logoutServlet" class="btn btn-danger btn-embossed btn-sm pull-right">Sign Out</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav visible-xs">
                <div class="media">
                    <a class="pull-left" href="userinfo.jsp?uid=<%= uid %>">
                        <img src="http://i.imgur.com/Aivv3ph.png" class="media-object img-thumbnail" width="90">
                    </a>
                    <div class="media-body">
                        <h4 class="media-heading" style="font-size: 95%;"><%= printName %></h4>
                        <h5 class="text-muted"><%= email %></h5>
                        <hr style="margin:8px auto">

                        <a href="userinfo.jsp?uid=<%= uid %>" class="btn btn-info btn-embossed btn-xs">Profile</a>
                        <%
                            if (session.getAttribute("admin") != null){
                        %>
                        <a href="admin_Performance.jsp" class ="btn btn-success btn-embossed btn-xs">Admin</a>
                        <%
                            }
                        %>
                        <a href="userinfo.jsp?uid=<%= uid %>#Settings" class="btn btn-default btn-embossed btn-xs">Change Password</a>
                        <a href="_logoutServlet" class="btn btn-danger btn-embossed btn-xs">Sign Out</a>
                    </div>
                </div>
            </ul>
            <ul class="nav navbar-nav nav-pills visible-xs">
                <li><a href="#main"><i class="fa fa-globe fa-fw fa-lg"></i>Home</a></li>
                <li><a href="faq.jsp"><i class="fa fa-cutlery fa-fw fa-lg"></i>Help</a></li>
                <li><a href="contact-support.jsp"><i class="fa fa-phone fa-fw fa-lg"></i>Contact</a></li>
                <li class="visible-xs"><a href="addToCart_view.jsp" class ="showForm"><i class="fa fa-shopping-cart fa-fa fa-lg"></i> <span class="badge" style="background-color: #5d5d5c;"><%= totalQty %></span></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right hidden-xs">
                <li id="account"><a href="addToCart_view.jsp" class ="showForm icon-header-cart">&nbsp;<span class="navbar-new"><%= totalQty %></span></a></li>
            </ul>
            <div class="col-sm-3 col-md-3 navbar-right">
             <form class="navbar-form" role="search">
               <div class="input-group">
                <input type="text" id="search" class="form-control" placeholder="Search">
                <div class="input-group-btn">
                    <button class="btn btn-default" type="submit" disabled=""><i class="fa fa-search"></i></button>
                </div>
               </div>
             </form>
           </div>
        </div>
    </div>
  </div>
</nav>
<%
    if (session.getAttribute("admin") != null){
        %>
<script type="text/javascript">
var $, document, searchbar;
$(document).ready(function () {
    'use strict';
    $('#search').keyup(function () {
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
    'use strict';
    $('#search').keyup(function () {
        searchbar = $('#search').val();
        if (searchbar.length >= 3) {
                //$('#loadSearches').load('findProductLoad.jsp', {searchbar:searchbar});            
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
<%
    }
%>
<div class="container" id="loadSearches"></div>
<script src="../js/jquery-1.7.2.min.js"></script>