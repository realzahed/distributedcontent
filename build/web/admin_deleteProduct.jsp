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
                <a href="admin_addProduct.jsp" class="list-group-item"><i class="fa fa-plus-square fa-lg fa-fw"></i> Add Product</a>
                <a href="admin_manageProduct.jsp" style="background-color: #e4717a;color: #fff;" class="list-group-item"><i class="fa fa-paperclip fa-lg fa-fw"></i> Manage Product</a>
                <a href="admin_pendingOrders.jsp" class="list-group-item"><i class="fa fa-clock-o fa-lg fa-fw"></i> Pending Orders</a>
                <a href="admin_approvedOrders.jsp" class="list-group-item"><i class="fa fa-check-square-o fa-lg fa-fw"></i> Approved Orders</a>
                <a href="admin_deliveredOrders.jsp" class="list-group-item"><i class="fa fa-truck fa-lg fa-fw"></i> Delivered Orders</a>
                <a href="admin_settings.jsp" class="list-group-item"><i class="fa fa-cog fa-lg fa-fw"></i> Settings</a>
            </div>
        </div>
            <% 
             if (session.getAttribute("productId") != null   && session.getAttribute("productName") != null ){
                String productId = request.getParameter("pid");

                session.getAttribute("productId");
                session.getAttribute("productName");
                 if (request.getParameter("del") != null){

                     String sqlDeleteProduct = "DELETE FROM `products` WHERE `product_id` = '"+session.getAttribute("productId")+"';";
                     String sqlDeleteProductImgs = "DELETE FROM `images` WHERE `product-name` = '"+session.getAttribute("productName")+"';";
                     Connection c = new DB_Conn().getConnection();
                     Statement st = c.createStatement();
                     st.addBatch(sqlDeleteProduct);
                     st.addBatch(sqlDeleteProductImgs);
                     st.executeBatch();        
         %>
      <div class="col-md-9">
        <div class="well">
          <h3 style="text-align: center;">Product Deleted</h3>
            <div class="text-center">
               <a class="btn btn-warning" href="admin_manageProduct.jsp" id="buy">Manage Products</a>
            </div>
        </div>
      </div>
                    <%
                 }else {
                     %>
      <div class="col-md-9">
        <div class="jumbotron text-center">
            <h3>Are you really sure? <small> You can't restore the product again!</small></h3>
            <h5>Product Name</span> : <%= session.getAttribute("productName")%></h5>
            <div class="form-group">
                <a class="btn btn-danger" href="admin_deleteProduct.jsp?pid=<%= session.getAttribute("productId")  %>&del=y" id="buy">Delete</a>
                <a class="btn btn-default"  href="admin_manageProduct.jsp?pid=<%= session.getAttribute("productId")  %>" id="buy">Cancel</a>
            </div>
        </div>
      </div>
    <%
    }
    }else {
    response.sendRedirect("admin_manageProduct.jsp");
    }
    %>
    </div> 
  </body>
</html>
