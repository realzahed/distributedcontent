<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
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
    <!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
    <style type="text/css">
    .imageGallery {
        width: 200px;
        height: 220px;
        margin: 11px;
        padding: 8px;
        border: 1px solid #CCC;
    }
    .media-object {
        width: 140px;
        height: 160px;
    }
    .alert1 {
        box-shadow: -20px 0px 0px #C00;
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
         <div class="well" id="manage">
             <h2 class="text-center">Manage Products
                 <small> Add, Edit or Delete Products</small></h2>
         </div>
        <%
            Connection c = new DB_Conn().getConnection();
            Statement st = c.createStatement();
            //Fetch the (PID) Product ID 
            String productId = request.getParameter("pid");
            if (request.getParameter("pid") == null || request.getParameter("pid") == "" || request.getParameter("pid") == "null") {

                String sqlFetchItems = "SELECT * FROM  `products` p "
                        + "INNER JOIN  `images` i "
                        + "USING (  `product-name` ) "
                        + "GROUP BY  `product-name` "
                        + " ORDER BY `product_qty` ASC ";
                Statement st1 = c.createStatement();
                ResultSet rs = st1.executeQuery(sqlFetchItems.toString());
        %>
        <div class="well">
          <form class="form-horizontal">
              <div class="form-group">  
                 <label for="#sortBy" class="col-sm-2 control-label">Sort By</label>
                   <div class="col-sm-10">
                       <select class="form-control" id="sortBy">
                           <option value="qa">Quantity: Low to High</option>
                           <option value="qd">Quantity: High to Low</option>
                           <option value="pa">Price: Low to High</option>
                           <option value="pd">Price: High to Low</option>
                           <option value="ha">Hits: Min to Max</option>
                           <option value="hd">Hits: Max to Min</option>
                       </select>
                   </div>
              </div>
          </form>
          <div class="productListing">
            <div id="productContent">
            <%
                while (rs.next()) {
                String product_id = rs.getString("product_id");
                String product_name = rs.getString("product-name");
                String sub_category_name = rs.getString("sub-category-name");
                String category_name = rs.getString("category-name");
                String company_name = rs.getString("company-name");
                String price = rs.getString("price");
                String summary = rs.getString("summary");
                int qty = rs.getInt("product_qty");
                String hits = rs.getString("hits");
                String image_name = rs.getString("image-name");
                String alert1="";
                if (qty<5){
                       alert1 = "alert1";
                }
            %>
        <div class="<%= alert1 %>">
          <div class="media">
            <a class="pull-left" href="admin_manageProduct.jsp?pid=<%=product_id%>"><img src="<%= image_name%>" class="media-object img-thumbnail" alt="64x64"/></a>
            <div class="media-body">
                <h4 class="media-heading"><a style="text-decoration: none;" href="admin_manageProduct.jsp?pid=<%=product_id%>"><span style="color: #ff3800;"><%=product_name%></span></a></h4>
                <p><%= company_name %> <span class="label label-success pull-right" style="font-size: 110%;"><i class="fa fa-rupee"></i> <%= price %></span></p>
                <p class="hidden-xs"><a href="admin_manageProduct.jsp?pid=<%= product_id%>" class="btn btn-bsu pull-right">Edit Product</a></p>
                <p class="visible-xs"><a href="admin_manageProduct.jsp?pid=<%= product_id%>" class="btn btn-bsu btn-xs pull-right">Edit Product</a></p>
                <p class="hidden-xs hidden-sm"><span class="badge pull-left"> <%= category_name %></span> <span class="badge pull-left"> <%=sub_category_name %></span></p><br />
                <p style="display: inline;">Views: <span class="label label-default"><%= hits %></span></p>
                <br /><h5><strong><%= qty %></strong> available in Stock</h5>
            </div>
          </div>
         <hr style="border-top: 1px solid #ccc;">
        </div>
        <%
            }
        %>
      </div>
     </div>
    </div>
   </div>
        <%
        } else {
            String sqlFetchProductInfo = "SELECT * "
                    + "FROM  `products` p "
                    + "INNER JOIN  `images` i "
                    + "USING (  `product-name` ) "
                    + "WHERE p.`product_id` = '"+productId+"' ";
            String company = "", productName = "", searchTags = "",
                    category = "", subCategory = "",
                    quantity = "", price = "",
                    image_id, summary = "", imageName = "", product_id = "";
            ArrayList<String> productImages = new ArrayList<String>();
            ArrayList<String> productImagesId = new ArrayList<String>();
            productImages.clear();
            productImagesId.clear();
            ResultSet rs = st.executeQuery(sqlFetchProductInfo);
            while (rs.next()) {
                company = rs.getString("company-name");
                productName = rs.getString("product-name");
                searchTags = rs.getString("tags");
                category = rs.getString("category-name");
                subCategory = rs.getString("sub-category-name");
                quantity = rs.getString("product_qty");
                price = rs.getString("price");
                summary = rs.getString("summary");
                imageName = rs.getString("image-name");
                image_id = rs.getString("image-id");
                product_id = rs.getString("product_id");
                productImages.add(imageName);
                productImagesId.add(image_id);
            }
            session.setAttribute("productId", productId);
            session.setAttribute("productName", productName);
        %>
        <div class="panel panel-danger">
            <div class="panel-heading">
                <h3 class="panel-title">Manage: <span class="label label-default"><%=productName%></span> 
                    <a class="btn btn-outline btn-xs" style="float: right;" href="admin_manageProduct.jsp"><strong>Back</strong></a>
                </h3>
                
            </div>
          <div class="panel-body">
            <form  class="form-horizontal" method="post" action="admin_changeProductInfo.jsp">
                <ol class="breadcrumb">
                    <li><%= category %></li>
                    <li><%= subCategory %></li>
                    <li><a href="product.jsp?id=<%=product_id%>"><strong>View Product</strong></a></li>
               </ol>

               <div class="form-group">
                    <label for="selectSubCat" class="col-sm-2 control-label">Product Name</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="productName" value="<%=productName%>">
                    </div>
               </div>
               <div class="form-group">
                <label for="selecCat" class="col-sm-2 control-label">Search Tags</label>
                <div class="col-sm-10">
                    <textarea class="form-control" name="tags"><%=searchTags%></textarea>
                </div>
               </div>
               <div class="form-group">
                    <label for="s" class="col-sm-2 control-label">Quantity in Stock<%session.setAttribute("quantity", quantity);%></label>
                    <div class="col-sm-10">
                        <input type="text" name="quantity" class="form-control" value="<%=quantity%>" disabled/>
                </div>
               </div>
               <div class="form-group">
                    <label for="s" class="col-sm-2 control-label">Add Product Quantity</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="addQuantity" value="0">
                </div>
               </div>
               <div class="form-group">
                    <label for="s" class="col-sm-2 control-label">Product Price</label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-rupee fa-lg"></i></span>
                            <input type="text" class="form-control" name="productPrice" value="<%=price%>">
                        </div>
                    </div>
               </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Product Description</label>
                    <div class="col-sm-10">
                       <textarea id="summary" class="form-control" rows="9" name="summary" required><%= summary%></textarea>
                    </div>
                </div>   
                <div class="form-group text-center">
                    <input id="buy" class="next btn btn-accent btn-embossed" type="submit" value="Save Changes">
                    <span style="margin-left: 55px;">
                    <a href="admin_deleteProduct.jsp?pid=<%= productId%>" class="btn btn-danger" id="greenBtn">Delete Product</a>
                    </span>
                </div>                
         </form>
       </div>
     </div>
<style type="text/css">
    .enhance {
        width : 430px;
        -webkit-transition:.3s all ease-in-out;
        -moz-transition:.3s all ease-in-out;
    }
</style>
    <div class="well">
        <h4>Product Image Gallery</h4>
        <div class="form-group">
            <a href="productInsertImages.jsp?pid=<%= productId%>" style="color: #333333;" id="greenBtn" class="pull-right btn btn-outline"><i class="fa fa-plus-circle"></i> Add Images for this Product</a>
        <%
        if (productImagesId.size() == 1){
            //Dont delete the product Image
            //Deletion will result into void of join syntax 
            //which then lead to the No display of product from the list

%>
            <img class="imageGallery" src="<%= productImages.get(0)%>"/>
        <%
            }else {
                        for (int i = 0; i < productImagesId.size(); i++) {
                    %>
                    <a href="admin_deleteImage.jsp?iid=<%= productImagesId.get(i)%>">
                        <img class="imageGallery media-object" src="<%= productImages.get(i)%>"/>
                    </a>
                    <%
                    }
                }
            }
        %>
       </div>
       <span class="help-block">Click on the image to <strong>Delete</strong> (Enabled only if more than one image is available)</span>
    </div>
    </div>
  </div>
 <div id="scrolltoTop">
    <a href="#">Top <i class="fa fa-chevron-up"></i></a>
</div>      
<script type="text/javascript">
    $(document).ready(function(){
        $('#sortBy').change(function (){
            var sortBy = $('#sortBy').attr('value');
            if (sortBy !== ""){
                //alert(" "+$('#sortBy').attr('value'));
                $.get('admin_manageProduct_1.jsp', {sortBy : sortBy}, function (data){
                    //alert(data);

                    $('#productContent').fadeOut(200, function (){
                    $('#productContent').html("");
                        $('#productContent').fadeIn(200);
                        $('#productContent').html(data);
                    });
                });
            }
        });
    });
</script>  
<script type="text/javascript">
    $(document).ready(function (){
        $('.imageGallery').css('opacity','0.4');
        $('.imageGallery').mouseover(function (){
            //      fadeTo (speed, opacity, callback)
            $(this).fadeTo(100,1,function (){
                $('.imageGallery').not(this).fadeTo(100, 0.4);
                $('.imageGallery').css('-webkit-transition','.3s all ease-in-out');
                $('.imageGallery').css('-moz-transition','.3s all ease-in-out');
            });
        });
        $('.imageGallery').mouseout(function (){
            $('.imageGallery').css('opacity','0.4');
        });
    });         
</script>     
<script type="text/javascript">
$('#scrolltoTop').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 600);
        return false;
        });
</script>
</body>
</html>
