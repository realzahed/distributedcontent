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
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
    <style type="text/css">
        #leftside {
            cursor: pointer;
        }
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
    <div class="container">
      <div class="row">
       <div class="col-md-3">
            <div  id="sidebar-nav" class="list-group">
                <a href="admin_Performance.jsp" class="list-group-item"><i class="fa fa-dashboard fa-lg fa-fw"></i> Dashboard</a>
                <a href="admin_addProduct.jsp" class="list-group-item list-group-item-warning"><i class="fa fa-plus-square fa-lg fa-fw"></i> Add Product</a>
                <a href="admin_manageProduct.jsp" class="list-group-item"><i class="fa fa-paperclip fa-lg fa-fw"></i> Manage Product</a>
                <a href="admin_pendingOrders.jsp" class="list-group-item"><i class="fa fa-clock-o fa-lg fa-fw"></i> Pending Orders</a>
                <a href="admin_approvedOrders.jsp" class="list-group-item"><i class="fa fa-check-square-o fa-lg fa-fw"></i> Approved Orders</a>
                <a href="admin_deliveredOrders.jsp" class="list-group-item"><i class="fa fa-truck fa-lg fa-fw"></i> Delivered Orders</a>
                <a href="admin_settings.jsp" class="list-group-item"><i class="fa fa-cog fa-lg fa-fw"></i> Settings</a>
            </div>
        </div>
          <div class="col-md-9">
             <div class="well">
               <h3>Steps for adding a product</h3>
                <p class="lead">Enter the following Information in the following steps to add a Product.</p>      
                 <div class="row form-group">
                   <div class="col-xs-12">
                      <ul class="nav nav-pills nav-justified thumbnail">
                          <li class="disabled"><a href="#step-1">
                              <h4 class="list-group-item-heading">Step 1</h4>
                              <p class="list-group-item-text">Product Company</p>
                          </a></li>
                          <li class="disabled"><a href="#step-2">
                              <h4 class="list-group-item-heading">Step 2</h4>
                              <p class="list-group-item-text">Product Category & Sub-Category</p>
                          </a></li>
                          <li class="disabled"><a href="#step-3">
                              <h4 class="list-group-item-heading">Step 3</h4>
                              <p class="list-group-item-text">Product Name and Tags</p>
                          </a></li>
                          <li class="disabled"><a href="#step-4">
                              <h4 class="list-group-item-heading">Step 4</h4>
                              <p class="list-group-item-text">Product Description and Price</p>
                          </a></li>
                      </ul>
                      <div class="text-center">
                        <a href="admin_addProduct_1.jsp" class="btn btn-warning">Proceed</a>
                      </div>
                  </div>
               </div>
             </div>           
           </div>
         </div>
      </div>
  </body>
</html> 
