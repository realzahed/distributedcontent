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
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script>
    <style type="text/css">
        .error {
            box-shadow: 0px 0px 7px #CC0000;
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
                           <li><a href="admin_addProduct_2.jsp">
                               <h4 class="list-group-item-heading">Step 2</h4>
                               <p class="list-group-item-text">Product Category</p>
                            </a></li>
                            <li class="active"><a href="#step-3">
                                <h4 style="color: #fff;" class="list-group-item-heading">Step 3</h4>
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
               <jsp:useBean class="product.productBean" scope="session" id="productBean"></jsp:useBean>
                <%
                    if (productBean.getCompany() == null || 
                            productBean.getCompany()  == ""){
                        response.sendRedirect("admin_addProduct_1.jsp");
                    }
                    else if ( productBean.getCategory() == null || 
                                    productBean.getCategory()  == "" ||
                                    productBean.getSubcategory()  == null || 
                                    productBean.getSubcategory()  == "" ){
                        response.sendRedirect("admin_addProduct_2.jsp");
                    }
                %>  
         <div class="panel panel-warning">
            <div class="panel-heading">
               <h3 class="panel-title">Enter Product Name and Product Tags</h3>
            </div>
            <div class="panel-body">
             <form class="form-horizontal" method="post" action="admin_addProduct_controller.jsp">
                <input type="hidden" name="company" value="<%= productBean.getCompany() %>"/>
                <input type="hidden" name="category" value="<%= productBean.getCategory() %>"/>
                <input type="hidden" name="subCategory" value="<%= productBean.getSubcategory() %>"/>
                <input type="hidden" name="page" value="admin_addProduct_4.jsp"/>
                <div class="form-group">
                  <label class="col-sm-3 control-label">Product Name</label>
                   <div class="col-sm-7">
                      <input id="productName" type="text" class="form-control" name= "productName"  placeholder="Product Name" required>
                   </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-3 control-label">Product Search Tags</label>
                   <div class="col-sm-7">
                     <textarea id="tags" class="form-control" rows="3" name= "tags" placeholder="Tags, seperated with comma(,)" required></textarea>
                   </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12 col-lg-offset-5">
                      <input id="buy" class="next btn btn-warning" type="submit" value="Proceed to Step 4"/>
                    </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
     </div>
    <script type="text/javascript">
        $(document).ready (function (){
            var next= $('.next');
            var name= $('#productName');
            var tags= $('#tags');

            name.keyup(function (){
                if ((name.attr('value').indexOf('\'') !== -1)){
                    name.addClass('error');
                    next.attr ('disabled', true);
                } else {
                    name.removeClass('error');
                    next.attr ('disabled', false);
                }
                var valueTag = name.attr('value');
                tags.val(valueTag);
            });
            tags.keyup(function (){
                if ((tags.attr('value').indexOf('\'') !== -1)){
                    tags.addClass('error');
                    next.attr ('disabled', true);
                }else {
                    tags.removeClass('error');
                    next.attr ('disabled', false);
                }
            });
        });
    </script>                    
  </body>
</html>
