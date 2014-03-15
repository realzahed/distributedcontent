<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.DB_Conn"%>
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
    <<!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
    <style type="text/css">
        .imageGallery {
            width: 300px;
            margin: 11px auto;
            padding: 8px;
            border: 1px solid #CCC;
            text-align: center;
        }
    </style>
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
        <div class="col-md-9">
        <%
            String imageId = request.getParameter("iid");
            String confirm = request.getParameter("d");
            session.getAttribute("productId");
            session.getAttribute("productName");
            if (request.getParameter("iid") == null && session.getAttribute("productId") == null) {
                //No Image selected for delete

        %>
    <div class="well">
        <h3 style="text-align: center;">Please Select an Image to Delete</h3>
        <p><a href="admin_manageProduct.jsp" class="btn btn-warning">Edit Product</a></p>
    </div>
        <%    } else {
                
                    //Delete it right away
                    /*
                    DELETE FROM  `images` 
                    WHERE  `image-id` =  '5'
                    */
                    String sqlDeleteImg = "DELETE FROM  `images` "
                    +" WHERE  `image-id` =  '"+imageId+"'; ";
                    
                    Connection c = new DB_Conn().getConnection();
                    Statement st = c.createStatement();
                                        if (st.execute(sqlDeleteImg)){
                                            %>
        <div class="well">
          <h3 style="text-align: center;">Product Image Successfully Deleted</h3>
             <p><a href="admin_manageProduct.jsp?pid=<%=session.getAttribute("productId")%>" class="btn btn-warning">Edit Product</a></p>
        </div>
                            <%
                                        }
                
        %>
        <div class="well">
          <h3 style="text-align: center;">Product Image Deleted</h3>
          <p class="text-center"><a href="admin_manageProduct.jsp" class="btn btn-warning">Edit Product</a></p>
        </div>
        <%
                }
     
        %>
    </div>
   </div>
  </div>
</body>
</html>
