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
            <% String tags = request.getParameter("tags");
                String productName = request.getParameter("productName");
                String s_quantity = (String)session.getAttribute("quantity");
                String s_addQuantity = request.getParameter("addQuantity");
                String s_productPrice = request.getParameter("productPrice");
                String summary = request.getParameter("summary");
                int quantity, addQuantity, totalQuantity; 
                double productPrice;
                if (session.getAttribute("productId") != null && session.getAttribute("productName") != null) {
                    
                    if (request.getParameter("del") != null) {
                        //String productId = request.getParameter("pid");
                        session.getAttribute("productId");
                        session.getAttribute("productName");
                        int pid = Integer.parseInt((String)session.getAttribute("productId"));
                        quantity = Integer.parseInt(request.getParameter("quantity"));
                        addQuantity = Integer.parseInt(request.getParameter("addQuantity"));
                        productPrice = Double.parseDouble(request.getParameter("price"));
                        totalQuantity = quantity+addQuantity;
                        summary = request.getParameter("summary");
                        tags = request.getParameter("tags");
   
                        String sqlUpdateProduct =  " UPDATE  `products` "
                        +" SET  `product-name` =  '"+productName+"',"
                        +" `price` =  '"+productPrice+"',"
                        +" `tags` =  '"+tags+"',"
                        +" `product_qty` =  '"+totalQuantity+"',"
                        +" `lastUpdated` = NOW( ) ,"
                        +" `summary` =  '"+summary+"' WHERE  `products`.`product_id` ="+pid+" ";
                        double expenses_d = productPrice * addQuantity;
                        int expenses = (int)expenses_d;
                        String sqlUpdateExpenses = "INSERT INTO  `dcac`.`expenses` ("
                         +"  `expenses_id` , "
                         +"   `product_id` ,"
                         +"   `product_name` , "
                         +"  `price` , "
                         +" `purchase_date` "
                         +"   ) "
                         +"   VALUES ( "
                         +"   NULL ,  '"+pid+"',  '"+productName+"',  '"+expenses+"', NOW( ) )";
                        
                        Connection c = new DB_Conn().getConnection();
                        Statement st = c.createStatement();
                        st.executeUpdate(sqlUpdateExpenses) ;
                        st.executeUpdate(sqlUpdateProduct);
                        //out.print (sqlUpdateExpenses+" "+sqlUpdateProduct);
            %>
            <div class="col-md-9">
               <div class="well text-center">
                  <h4>Product Information Updated</h4>
                    <div class="text-center">
                        <a class="btn btn-warning" href="admin_manageProduct.jsp" id="buy">Manage Products</a>
                    </div>
               </div>
            </div>
            <%
            } else {
            %>
             <div class="col-md-9">
               <div class="well">
               <%
                 try {
                quantity = Integer.parseInt(s_quantity);
                addQuantity = Integer.parseInt(s_addQuantity);
                productPrice = Double.parseDouble(s_productPrice);
                totalQuantity = quantity+addQuantity;
                if (totalQuantity <= 0  || productPrice <= 0){
               %>
                <div class="panel-heading">
                   <h4>Product cannot be updated because the quantity is less than 0</h4>
                </div>
                <div class="panel-body">
                   <p>Product Name: <%= session.getAttribute("productName")%></p>
                   <a class="btn btn-warning" href="admin_manageProduct.jsp?pid=<%= session.getAttribute("productId")%>" id="buy">Cancel Updating</a>
                 </div>
              </div>
                <%
                }else {

                 %>           
      <form action="admin_changeProductInfo.jsp" method="post">
        <input type="hidden" name="tags" value="<%= tags %>"/>
        <input type="hidden" name="productName" value="<%= productName %>"/>
        <input type="hidden" name="summary" value="<%= summary %>"/>
        <input type="hidden" name="quantity" value="<%= s_quantity %>"/>
        <input type="hidden" name="addQuantity" value="<%= s_addQuantity %>"/>
        <input type="hidden" name="price" value="<%= productPrice %>"/>
        <input type="hidden" name="del" value="y"/>
        <div class="panel panel-primary">
          <div class="panel-heading">
              <h4 style="color: #fff;">Are you sure you want to update the Product?</h4>
          </div>
          <div class="panel-body">
            <h4>Product Name: <%= session.getAttribute("productName")%></h4>
             <div class="text-center">
                <input type="submit" class="btn btn-success" id="buy" value="Update"/>
                <a class="btn btn-danger" href="admin_manageProduct.jsp?pid=<%= session.getAttribute("productId")%>" id="buy">Cancel</a>
             </div>
          </div>
        </div>
       </form>
        <form class="form-horizontal">
          <div class="form-group">
              <label class="col-sm-5 control-label">Product Tags:</label>
              <div class="col-sm-7">
                  <p class="form-control-static"><strong><%= tags %></strong></p>
              </div>
          </div>

          <div class="form-group">
              <label class="col-sm-5 control-label">Product Name:</label>
              <div class="col-sm-7">
                  <p class="form-control-static"><strong><%= productName %></strong></p>
              </div>
          </div>
          <div class="form-group">
              <label class="col-sm-5 control-label">Product Quantity:</label>
              <div class="col-sm-7">
                  <p class="form-control-static"><strong><%= quantity %></strong></p>
              </div>
          </div>
          <div class="form-group">
              <label class="col-sm-5 control-label">Added Product Quantity:</label>
              <div class="col-sm-7">
                  <p class="form-control-static"><strong><%= addQuantity %></strong></p>
              </div>
          </div>
          <div class="form-group">
              <label class="col-sm-5 control-label">Product Price:</label>
              <div class="col-sm-7">
                  <div class="input-group">
                      <p class="form-control-static"><i class="fa fa-rupee fa-lg"></i> <strong><%= productPrice %></strong></p>
                  </div>
              </div>
          </div>
          <div class="form-group">
              <label class="col-sm-5 control-label">Product Description:</label>
              <div class="col-sm-6">
                  <p style="text-align: justify;" class="form-control-static"><%= summary %></p>
              </div>
          </div> 
        </form>
        <% 
            }
         } catch (NumberFormatException ex) {
             response.sendRedirect("admin_manageProduct.jsp?pid=" + session.getAttribute("productId"));
         }
        %>
      </div>
    </div>
    <%
        }
    } else {
        response.sendRedirect("admin_manageProduct.jsp");
    }
    %>
  </div>
 </body>
</html>
