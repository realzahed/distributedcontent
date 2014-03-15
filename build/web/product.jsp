<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*, database.*" %>
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
    <style>
      #product-images {
        -moz-box-shadow:    inset 0 0 8px #c5c5c5;
        -webkit-box-shadow: inset 0 0 8px #c5c5c5;
        box-shadow:         inset 0 0 8px #c5c5c5;
      }
     .main-header {position: relative;margin: 0 auto;margin-top: -22px;padding: 3em 1em;color: #fff;text-align: center;background: url(assets/img/bgheader.jpg) no-repeat center center;background-size: cover;}
     .main-header h1 {font-size: 2.625em;line-height: 1.3;margin: 0;font-weight: 300;}
     .main-header h1 span {display: block;font-size: 60%;opacity: 0.7;padding: 0 0 0.6em 0.1em;}
     #cart:hover {color:#f7f7f7;}
     #heading {color:#667d8e;font-weight: 400;text-decoration: none;}
     #heading:hover {color:#318ce7;text-decoration: none;}
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
        %>
        <%
            String id = request.getParameter("id");
            if (request.getParameter("id") == null) {
                response.sendRedirect("viewProducts_.jsp");
            }else {
            DB_Conn c = new DB_Conn();
            Connection con = c.getConnection();
            Statement st = con.createStatement();
            String getProductQuery = "SELECT * FROM  `products` p INNER JOIN  `images` i USING (  `product-name` ) WHERE  `product_id` ="+id+" GROUP BY  `product-name` ";
            ResultSet rs = st.executeQuery(getProductQuery);
            rs.next();
            //out.println(""+rs.getString("product-name"));
            String product_id = rs.getString("product_id");
            int product_hits = rs.getInt("hits");   
            int quantity=rs.getInt("product_qty");
            String product_name = rs.getString("product-name");
            String sub_category_name = rs.getString("sub-category-name");
            String category_name = rs.getString("category-name");
            String company_name = rs.getString("company-name");
            String price = rs.getString("price");
            String summary = rs.getString("summary");
            String image_name = rs.getString("image-name");
        %>
    <header class="main-header">
      <h1>Book Catalog <span>Now featuring a large collection to choose from</span></h1>	
   </header>
     <div class="container">
      <div class = "row">
        <div class="col-md-3" style="margin-top: 1em;">   
            <%
            String category, subcategory;
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT * FROM  `products` p "
                            + "INNER JOIN  `images` i "
                            + "USING (  `product-name` ) ");
            category = "";
            subcategory = "";
            if(session.getAttribute("cat") != null ){
                category = (String) session.getAttribute("cat");
                ArrayList subCat = product.getSubcategory(category);

                %>
                <div class="sidebar affix-top"  role="complementary">
                    <ul class="nav sidenav">
                        <li class="active list-group hidden-sm hidden-xs"><a href="#"><em><strong>Sub Categories</strong></em></a></li>
                <%
                for (int i =0; i< subCat.size(); i++){
                    %>
                    <li><a href="addProductFilters.jsp?scat=<%= subCat.get(i) %>"><%= subCat.get(i) %></a></li>      
                    <%
                } subCat.clear(); %>
                    </ul>
                </div>
                 <%
                if (session.getAttribute("scat") != null){
                    subcategory = (String) session.getAttribute("scat");

                }
            } else {
                //Show Category
                ArrayList Cat = product.getCategory();
                %>
                <div class="sidebar affix-top"  role="complementary">
                    <ul class="nav sidenav">
                        <li class="active list-group hidden-sm hidden-xs"><a href="#"><em><strong>Categories</strong></em></a></li>
                <%
                for (int i =0; i< Cat.size(); i++){
                    %>
                    <li><a href="addProductFilters.jsp?cat=<%= Cat.get(i) %>"><%= Cat.get(i) %></a></li>      
                    <%
                } Cat.clear();
                %>
                    </ul>
                </div>
                <%
            }
        %>

        <%
        if (session.getAttribute("cat") != null){
            category = (String)session.getAttribute("cat"); 
            sql.append(" WHERE  `category-name` =  '"+category+"' ");
        %>
        <div class="sidebar" style="text-decoration:none;">
            <p><em><strong>Remove Filters</strong></em></p>
            <a class="text-info" href="removeProductFilter.jsp?cat=<%= category %>"><em> <%= category %> </em><i class="fa fa-times-circle"></i></a>
        </div>
        <%

            %>

                <%
                    if (session.getAttribute("scat") != null){
                        subcategory = (String)session.getAttribute("scat");
                        sql.append(" AND  `sub-category-name` =  '"+subcategory+"' ");
                        %>
                            <div class="sidebar" style="text-decoration:none;">
                                <a class="text-info" href="removeProductFilter.jsp?scat=<%= subcategory %>"><em> <%= subcategory %> </em><i class="fa fa-times-circle"></i></a>
                            </div>
                        <%
                    } 
                %>
            <%
        }
    %>
  </div>
<!-- breadcrumb -->
<div class="col-md-9" style="margin-top: 1em;">
    <ol class="breadcrumb">
        <li><a href="index.jsp">Home</a></li>
        <li><a href="viewProducts_.jsp"><%= category %></a></li>
        <li><a href="#"><%= subcategory %></a></li>
    </ol>
    <!--main content-->
    <div class="jumbotron">
        <div class="media" id="product-images" style="padding: 25px;">
        <a class="pull-left" href="product.jsp?id=<%=product_id%>"><img src="<%= image_name %>" class="media-object hidden-xs" alt="main" width="130"  height="160"></a>
         <div class="media-body">
          <h3 class="media-heading text-info"><%=product_name %></h3>
           <p> <span class="label label-primary pull-right" style="background-color: #4a495b;font-size: 100%;font-weight: 600;"><i class="fa fa-rupee"></i> <%= price %></span></p>
            <h5><%= company_name %></h5>
            <a href="addToCart.jsp?id=<%= product_id %>" style="margin-top: 15px;" class="btn btn-embossed btn-facebook pull-right"><i class="fa fa-shopping-cart fa-fw"></i> ADD TO CART</a>
            <p class="hidden-xs hidden-sm"><span class="badge pull-left"> <%= category_name %> <i class="fa fa-chevron-right"></i> <%=sub_category_name %></span></p>
            <br><small class="hidden-xs hidden-sm"><%= quantity %> available in Stock</small>
            <!--edit button-->
            <%
           if (session.getAttribute("admin") != null){
           %>
           <br /><a href="admin_manageProduct.jsp?pid=<%= product_id %>">
            <div class="btn btn-warning">Edit Product</div>
          </a>
          <%
            }
          %>
      <!--/.edit button-->
         </div><!--/.media-body-->
       </div><!--/.media-->  
        <h3 style="text-align: justify;">Book Description:
        <small><span style="color: #534b4f;text-align: justify;"><%= summary%></span></small></h3>
        <!-- lightbox -->
        <br><h4 class="text-left">Product Images:</h4>
        <div class="well text-center" id="product-images" style="background-color: #f2f2f2;"> 
        <a href="<%= image_name %>" rel="lightbox[product]" title="<%= product_name %>">
            <img class="img-thumbnail" alt="<%= product_name %>" src="<%= image_name%>"  width="140"/>
        </a>
        <%
            String getImages = "SELECT  `image-name` FROM  `products` INNER JOIN  `images` USING (  `product-name` ) WHERE  `product_id` =" + product_id + "";
            rs.close();
            rs = st.executeQuery(getImages);
            int img_number = 1;
            rs.next();
            // GET THE REST OF THE PRODUCT IMAGES
            while (rs.next()) {
                 image_name = rs.getString("image-name");
        %>
        <a href="<%= image_name %>" rel="lightbox[product]" title="<%= product_name %>">
            <img class="img-thumbnail" alt="<%= image_name %> 1 of 8 thumb" src="<%= image_name %>" width="140"/>
        </a>
        <%                            
            }
            st.execute("UPDATE  `products` "+" SET  `hits` =  '"+(product_hits+1)+"' "+" WHERE  `products`.`product_id` ="+product_id+" ");
            st.close();
        }
        %>
      </div><!-- /.lightbox -->
    </div> 
   </div>
  </div>
 </div>
    <jsp:include page="includesPage/_footer.jsp"></jsp:include>
 </body>
</html>
