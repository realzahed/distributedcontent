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
    <script src="js/product.js"></script>
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
         <div class="col-md-9">
           <div class="well">
             <h3>Steps for adding a product</h3>
               <p class="lead">Enter the following Information in the following steps to add a Product.</p>      
                  <div class="row form-group">
                    <div class="col-xs-12">
                       <ul class="nav nav-pills nav-justified thumbnail">
                           <li><a href="admin_addProduct_1.jsp">
                             <h4 class="list-group-item-heading" >Step 1</h4>
                             <p class="list-group-item-text">Product Company</p>
                           </a></li>
                           <li class="active"><a href="#step-2">
                               <h4 style="color: #fff;" class="list-group-item-heading">Step 2</h4>
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
                </div><!--/.steps_well-->
                <!--Loading the AJAX API-->
                <script type="text/javascript" src="js/gclibrary/jsapi.js"></script>
                <script type="text/javascript" src="js/gclibrary/core.js"></script>
                <script type="text/javascript" src="js/gclibrary/core1.js"></script>
         <jsp:useBean class="product.productBean" scope="session" id="productBean"></jsp:useBean>
    <%
        DB_Conn conn = new DB_Conn();
        Connection con = conn.getConnection();
        Statement st = con.createStatement();
        String sql_getCategory = "SELECT  `category_name` FROM  `category`; ";
        String sql_getSubCategory = "SELECT  `sub-category_name` FROM  `sub-category`;";
        //String sql_getCompany = "SELECT  `company-name` FROM  `product-company`;";

        if (productBean.getCompany() == null || 
                productBean.getCompany()  == ""){
            response.sendRedirect("admin_addProduct_1.jsp");
        }
    %>
       <div class="panel panel-warning">
          <div class="panel-heading">
             <h3 class="panel-title">Select a Category and  Sub-Category or Create a new one below.</h3>
          </div>
           <div class="panel-body">
            <form class="form-horizontal" method="post" action="admin_addProduct_controller.jsp">
              <input type="hidden" name="company" value="<%= productBean.getCompany() %>">
                <input type="hidden" name="page" value="admin_addProduct_3.jsp">
                   <div class="form-group">
                    <label for="selecCat" class="col-sm-2 control-label">Select Category</label>
                    <div class="col-sm-10">
                      <select class="form-control" id="selectMenuCategory" name="category">
                        <option value="" selected="">Select Category</option>
                            <% 
                                ResultSet rs = st.executeQuery(sql_getCategory);
                                while (rs.next()) {
                                    String category = rs.getString("category_name");
                            %>
                            <option value="<%= category%>"><%= category%></option>
                            <%
                                }
                            %>
                       </select>
                     </div>
                    </div>
                    <div class="form-group">
                    <label for="selectSubCat" class="col-sm-2 control-label">Select Sub-Category</label>
                    <div class="col-sm-10">
                      <select class="form-control" id="selectMenuSubCategory" name="subCategory">
                        <option value="" selected="">Select Sub-Category</option>
                            <%
                                ResultSet subCategory = st.executeQuery(sql_getSubCategory);
                                while (subCategory.next()) {
                                    String subCat = subCategory.getString("sub-category_name");
                            %>
                            <option value="<%= subCat%>"><%= subCat%></option>
                            <%
                                }
                                st.close();
                            %>
                        </select>
                    </div>
                  </div>
                    <div class="text-center">
                        <h4>Or</h4>
                    </div>
                    <div class="form-group">
                        <label for="selectSubCat" class="col-sm-2 control-label">Add New Category</label>
                        <div class="col-sm-7">
                            <input id="categoryName" type="text" name="categoryName" class="form-control" tabindex="1" placeholder="Category Name"/>
                        </div>
                        <div class="col-sm-3">
                            <input id="addCategoryNameBtn" class="buy btn btn-primary btn-sm" type="button" value="Add Category"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="selectSubCat" class="col-sm-2 control-label">Add New Sub-Category</label>
                        <div class="col-sm-7">
                            <input id="SubCategoryName" type="text" class="form-control" name="SubCategoryName" tabindex="1" placeholder="Sub-Category Name"/>
                        </div>
                        <div class="col-sm-3">
                            <input id="addSubCategoryBtn" class="buy btn btn-primary btn-sm" type="button" value="Add Sub-Category"/>
                        </div>
                    </div>
                    <div class="text-center">
                        <input id="buy" class="btn btn-warning" type="submit" value="Proceed to Step 3"/>
                    </div>
                </form>   
             </div>
          </div>
         <div class="well-sm">
            <h4 id="step2Feedback" class="text-center"></h4>
            <h4 id="step2Feedback1" class="text-center"></h4>
         </div>  
       </div>
     </div>
   </div>
    <script src="js/myScript.js"></script>
    <script type="text/javascript">
        $(document).ready (function () {
          $('#selectMenuCategory').click(function () {
            var category = $(this).val();
            //alert ("Aargh " +getCategory);
            $.get('getProductSubCategory', 
            { category: category}, 
            function (data){
            $('#selectMenuSubCategory').html(data);
            });
         });
        });
    </script>
 </body>
</html>
