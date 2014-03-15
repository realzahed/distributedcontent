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
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/animate.css"/>
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
        
        if (session.getAttribute("admin")== null){
            response.sendRedirect("admin_.jsp");
        }
        %>
    <div class="container animated slideInRight">
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
        <%
            DB_Conn conn = new DB_Conn();
            Connection con = conn.getConnection();
            Statement st = con.createStatement();
            //String sql_getCategory = "SELECT  `category_name` FROM  `category`; ";
            //String sql_getSubCategory = "SELECT  `sub-category_name` FROM  `sub-category`;";
            String sql_getCompany = "SELECT  `company-name` FROM  `product-company`;";
        %>
    <jsp:useBean class="product.productBean" scope="session" id="productBean"></jsp:useBean>
      <div class="col-md-9">
        <div class="well">
           <h3>Steps for adding a product</h3>
             <p class="lead">Enter the following Information in the following steps to add a Product.</p>      
                <div class="row form-group">
                  <div class="col-xs-12">
                     <ul class="nav nav-pills nav-justified thumbnail">
                        <li class="active "><a href="#step-1">
                           <h4 style="color: #fff;" class="list-group-item-text" >Step 1</h4>
                              <p class="list-group-item-text">Product Company</p>
                              </a></li>
                              <li class="disabled"><a href="#step-2">
                                  <h4 class="list-group-item-heading">Step 2</h4>
                                  <p class="list-group-item-text">Product Category</p>
                              </a></li>
                              <li class="disabled"><a href="#step-3">
                                  <h4 class="list-group-item-heading">Step 3</h4>
                                  <p class="list-group-item-text">Product Name</p>
                              </a></li>
                              <li class="disabled"><a href="#step-4">
                                  <h4 class="list-group-item-heading">Step 4</h4>
                                  <p class="list-group-item-text">Product Price</p>
                              </a></li>
                          </ul>
                      </div>
                   </div>
                </div> 
                <div class="panel panel-warning">
                    <div class="panel-heading">
                        <h3 class="panel-title">Select a Company Name or Enter a new one below</h3>
                    </div>
                    <div class="panel-body">
                      <div class="row">
                        <form method="post" action="admin_addProduct_controller.jsp">
                          <input type="hidden" name="page" value="admin_addProduct_2.jsp"/>
                          <div class="col-sm-5">
                          <div class="form-group">
                            <label class="control-label">Select Company</label>
                              <select class="form-control" name="company" id="company">
                                  <option value="" selected>Select a Company</option>
                                <%
                                    ResultSet company = st.executeQuery(sql_getCompany);
                                    while (company.next()) {
                                        String companyName = company.getString("company-name");
                                %>
                                <option value="<%= companyName%>"><%= companyName%></option>
                                <%
                                    }
                                %>
                              </select>
                          </div>
                       </div>
                       <div class="col-sm-2">
                          <h4 class="text-center">Or</h4>
                          <h1 class="text-center" style="margin-top: -0.4em;">|</h1>
                       </div>
                       <div class="col-sm-5">
                        <div class="form-group">
                            <label class="control-label">Add New Company</label>
                            <input id="companyName" type="text" class="form-control" name="companyName" placeholder="Company Name"/>
                            <div class="text-right" style="margin-top: 5px;">
                                <input id="addProductNameBtn" class="buy btn btn-primary btn-sm" type="button" value="Add Company"/>
                            </div>
                        </div>
                       </div>
                       <div class="text-center">
                          <input id="buy" class="btn btn-warning" type="submit" value="Proceed to Step 2"/>
                       </div>
                  </form>
                </div><!--/.row-->
              </div><!--/.panel-body-->
           </div><!--panel-->
         <div class="well"><h4 id="step1Feedback" class="text-center">----</h4></div>           
      </div>
    </div>
   </div> 
   <script src="js/myScript.js"></script>
 </body>
</html>
