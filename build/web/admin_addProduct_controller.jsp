<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>DCAC</title>
    <jsp:useBean class="product.product" id="product" scope="session"></jsp:useBean>
    <%@page import="java.sql.*, database.*" %>
    <title>DCAC</title>
    <script src="assets/js/jquery.js"></script>
    <script src="js/jquery-1.7.2.min.js"></script>
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
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
        %>
 <div class="container">
  <div class="row">
    <div  class="col-md-3">
        <div class="list-group">
            <a href="admin_Performance.jsp" class="list-group-item">Dashboard</a>
            <a class="list-group-item">Stock</a>
            <a class="list-group-item">Performance</a>
            <a class="list-group-item">Orders</a>
            <a href="productInsert.jsp" class="list-group-item">Add Product</a>
            <a href="admin_settings.jsp" class="list-group-item">Settings</a>
        </div>
    </div>     
    <jsp:useBean class="product.productBean" scope="session" id="productBean"></jsp:useBean>
    <jsp:setProperty name="productBean" property="company" value="${param.company}"></jsp:setProperty>     
    <jsp:setProperty name="productBean" property="category" value="${param.category}"></jsp:setProperty>     
    <jsp:setProperty name="productBean" property="subcategory" value="${param.subCategory}"></jsp:setProperty>     
    <jsp:setProperty name="productBean" property="name" value="${param.productName}"></jsp:setProperty>     
    <jsp:setProperty name="productBean" property="tags" value="${param.tags}"></jsp:setProperty>     
    <jsp:setProperty name="productBean" property="price" value="${param.price}"></jsp:setProperty>     
    <jsp:setProperty name="productBean" property="quantity" value="${param.productQty}"></jsp:setProperty>     
    <jsp:setProperty name="productBean" property="summary" value="${param.summary}"></jsp:setProperty>            
    <div class="col-md-9">
        <div class="well">
            <h3>Add Product Controller</h3>
             <%
                if (request.getParameter("page")!= null){
                    response.sendRedirect(request.getParameter("page"));
                }else {
                    response.sendRedirect("index.jsp");
                }
             %>
        </div>
      </div>
    </div>         
  </div> 
  <script src="assets/js/application.js"></script>
 </body>
</html>
