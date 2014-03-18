<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/animate.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <style type="text/css">
        #leftside,.clickable {cursor: pointer;}
        .panel-heading span {margin-top: -20px;font-size: 15px;}
    </style>
</head>
<body>
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
        if (session.getAttribute("admin")== null){
            response.sendRedirect("admin_.jsp");
        }
        %>
    <div class="container animated fadeInDownBig">
        <div class="row">
          <div class="col-md-3">
                <div  id="sidebar-nav" class="list-group">
                    <a href="admin_Performance.jsp" class="list-group-item list-group-item-info"><i class="fa fa-dashboard fa-lg fa-fw"></i> Dashboard</a>
                    <a href="admin_addProduct.jsp" class="list-group-item"><i class="fa fa-plus-square fa-lg fa-fw"></i> Add Product</a>
                    <a href="admin_manageProduct.jsp" class="list-group-item"><i class="fa fa-paperclip fa-lg fa-fw"></i> Manage Product</a>
                    <a href="admin_pendingOrders.jsp" class="list-group-item"><i class="fa fa-clock-o fa-lg fa-fw"></i> Pending Orders</a>
                    <a href="admin_approvedOrders.jsp" class="list-group-item"><i class="fa fa-check-square-o fa-lg fa-fw"></i> Approved Orders</a>
                    <a href="admin_deliveredOrders.jsp" class="list-group-item"><i class="fa fa-truck fa-lg fa-fw"></i> Delivered Orders</a>
                    <a href="admin_settings.jsp" class="list-group-item"><i class="fa fa-cog fa-lg fa-fw"></i> Settings</a>
                </div>
            </div>
            <div class="col-md-9">
             <div class="panel panel-info">
                  <%
                    String sqlPending = "SELECT COUNT(  `status` ) as pending"
                    + " FROM  `order` "
                    + " WHERE  `status` =  'pending'";
                    String sqlApproved = "SELECT COUNT(  `status` ) as approved "
                    + " FROM  `order` "
                    + " WHERE  `status` =  'approved' ";
                    String sqlQuantity = "SELECT COUNT(  `product-name` ) as qty"
                    +" FROM  `products` "
                    +" WHERE  `product_qty` <5 ";
                    sqlQuantity = "SELECT COUNT(  `product-name` ) AS qty"
                    +" FROM  `products` "
                    +" WHERE  `product_qty` <5";
                    Connection c = new DB_Conn().getConnection();
                    Statement st = c.createStatement();
                    ResultSet rs = null;
                    String  qty = "0", 
                            pendingOrders= "0",
                            approvedOrders= "0";
                    rs = st.executeQuery(sqlQuantity);
                    while (rs.next()){
                            qty = rs.getString("qty");
                    }
                    if (qty.equals("0")){
                        qty = "No";
                    }
                    rs = st.executeQuery(sqlPending);
                    while (rs.next()){
                            pendingOrders = rs.getString("pending");
                    }
                    if (pendingOrders.equals("0")){
                        pendingOrders = "No";
                    }
                    rs = st.executeQuery(sqlApproved);
                    while (rs.next()){
                            approvedOrders = rs.getString("approved");
                    }
                    if (approvedOrders.equals("0")){
                        approvedOrders = "No";
                    }
                %>
                <div class="panel-heading">
                        <h3 class="panel-title">Administrator Dashboard</h3>
                </div>
                <div class="panel-body text-center">
                    <a style="border-radius: 0px;" class="btn btn-danger" href="admin_manageProduct.jsp"><span class="badge"><%= qty %></span> Items below Quantity</a>     
                    <a style="border-radius: 0px;" class="btn btn-success" href="admin_approvedOrders.jsp"><span class="badge"><%= approvedOrders %></span> Items to be Delivered</a>    
                    <a style="border-radius: 0px;" class="btn btn-info" href="admin_pendingOrders.jsp"><span class="badge"><%= pendingOrders %></span> Items to be Approved</a>    
                </div>
            </div>
            <!--Loading the AJAX API-->
            <script type="text/javascript" src="js/gclibrary/jsapi.js"></script>
            <script type="text/javascript" src="js/gclibrary/core.js"></script>
            <script type="text/javascript" src="js/gclibrary/core1.js"></script>
            <%--<jsp:include page="includesPage/gChartings/gChart_ComboLine.jsp"></jsp:include>--%>
            <jsp:include page="includesPage/gChartings/gCharts_pieChartItemsSoldByCategory.jsp"></jsp:include>
            <jsp:include page="includesPage/gChartings/gCharts_pieChartItemsViewedByCategory.jsp"></jsp:include>
            <jsp:include page="includesPage/gChartings/gCharts_top10ProductsSold.jsp"></jsp:include>
            <jsp:include page="includesPage/gChartings/gCharts_top10Products_viewed.jsp"></jsp:include>
           </div>
           </div>
          </div>
           <div id="scrolltoTop">
                <a href="#">Top <i class="fa fa-chevron-up"></i></a>
            </div>
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/application.js"></script>
    <script type="text/javascript">
    $('#scrolltoTop').click(function(){
            $("html, body").animate({ scrollTop: 0 }, 600);
            return false;
            });
    </script>
<script type="text/javascript">
$(document).on("click",".panel-heading span.clickable",function(e){var t=$(this);if(!t.hasClass("panel-collapsed")){t.parents(".panel").find(".panel-body").slideUp();t.addClass("panel-collapsed");t.find("i").removeClass("fa-chevron-up").addClass("fa-chevron-down")}else{t.parents(".panel").find(".panel-body").slideDown();t.removeClass("panel-collapsed");t.find("i").removeClass("fa-chevron-down").addClass("fa-chevron-up")}})
</script>
</body>
</html>
