<%@page import="java.util.ArrayList"%>
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
    <script src="js/jquery-1.7.2.min.js"></script>
    <style type="text/css">
     .main-header {position: relative;margin: 0 auto;margin-top: -20px;padding: 3em 1em;color: #fff;text-align: center;background: url(assets/img/bgheader.jpg) no-repeat center center;background-size: cover;}
     .main-header h1 {font-size: 2.625em;line-height: 1.3;margin: 0;font-weight: 300;}
     .main-header h1 span {display: block;font-size: 60%;opacity: 0.7;padding: 0 0 0.6em 0.1em;}
     #cart:hover {color:#f7f7f7;}
     #heading {color:#667d8e;font-weight: 400;text-decoration: none;}
     #heading:hover {color:#318ce7;text-decoration: none;}
     #price{padding: 6px;-moz-box-shadow:inset 0 0 10px #cad3d9;-webkit-box-shadow: inset 0 0 10px #cad3d9;box-shadow:inset 0 0 10px #cad3d9;}
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
   <header class="main-header animated slideInDown">
      <h1>Book Catalog <span>Now featuring a large collection to choose from</span></h1>	
   </header>
    <div class="container">
     <div id = "row">
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
                        <li class="list-group active hidden-sm hidden-xs"><a href="#"><em><strong>Sub Categories</strong></em></a></li>
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
                        <li class="list-group active hidden-sm hidden-xs"><a href="#"><em><strong>Categories</strong></em></a></li>
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
            <a class="text-info" href="removeProductFilter.jsp?cat=<%= category %>"> <%= category %> <i class="fa fa-times-circle"></i></a>
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
    <!-- Middle -->
    <div class="col-md-9">
        <div style="margin-top: 2%;">
            <ol class="breadcrumb">
                <li class="active"><a href="index.jsp"><i class="fa fa-home fa-fw fa-lg"></i></a></li>
                <li><a href="viewProducts_.jsp"><%= category %></a></li>
                <li><a href="#"><%= subcategory %></a></li>
            </ol>
        </div>
     <!--main content-->
     <div class="well" style="background-color: #f8f8f8;">
            <%
            DB_Conn con = new DB_Conn();
            Connection c = con.getConnection();
            Statement st = c.createStatement();
            ResultSet rs ;
             if (sql.toString().equalsIgnoreCase("SELECT * FROM  `products` p "
                                                + "INNER JOIN  `images` i "
                                                + "USING (  `product-name` ) "
                                                )){
            String newSQL  = "SELECT * FROM  `products` p "
                            + "INNER JOIN  `images` i "
                           + "USING (  `product-name` ) "
                            + " WHERE `product_qty` > 0 "
                          +" GROUP BY  `product-name` "
                         + " ORDER BY  `hits` DESC  ";
            //out.print("Equals "+sql.toString() +" "+newSQL);
             rs= st.executeQuery(newSQL);
             }else { 
            sql.append(" AND `product_qty` > 0  "
                    + " GROUP BY  `product-name` "
                    + " ORDER BY  `hits` DESC  ");
                //out.print("Not Equals "+sql.toString());
                rs= st.executeQuery(sql.toString());                        
             }
                while (rs.next()) {
                    String product_id = rs.getString("product_id");
                    String product_name = rs.getString("product-name");
                    String sub_category_name = rs.getString("sub-category-name");
                    String category_name = rs.getString("category-name");
                    String company_name = rs.getString("company-name");
                    String price = rs.getString("price");                 
                    int quantity=rs.getInt("product_qty");
                    String summary = rs.getString("summary");
                    String image_name = rs.getString("image-name");
                    %>
              <div class="media">
                  <a class="pull-left"  href="product.jsp?id=<%=product_id%>"><img src="<%= image_name %>" class="media-object img-thumbnail" alt="main" width="100" height="120"></a>
                <div class="media-body">
                  <h4 class="media-heading"><a id="heading" href="product.jsp?id=<%=product_id%>"><%=product_name %></a></h4>
                  <p><%= company_name %> <span id="price" class="label label-primary pull-right" style="background-color: #f7f8f9;color: #445560;font-size: 115%;"><i class="fa fa-rupee"></i> <%= price %></span></p>
                  <p><a id="cart" href="addToCart.jsp?id=<%= product_id %>"style="margin-top: 15px;padding: 10px;text-decoration: none;" class="btn btn-facebook pull-right"><i class="fa fa-shopping-cart fa-fw"></i> ADD TO CART</a></p>
                  <p class="hidden-xs hidden-sm"><span class="badge pull-left"> <%= category_name %></span> <span class="badge pull-left"> <%=sub_category_name %></span></p>
                  <br /><small class="hidden-xs hidden-sm"><%= quantity %> available in Stock</small>
                </div>
                <hr style="border-top: 1px solid #ccc;">
              </div>
                        <%
                                }
                            rs.close();
                            st.close();
                            c.close();
                        %>
          </div>
        </div>
     </div>
   </div>
  <jsp:include page="includesPage/_footer.jsp"></jsp:include>
 </body>
</html>
