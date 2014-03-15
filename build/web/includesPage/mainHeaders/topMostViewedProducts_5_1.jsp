<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DB_Conn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<style type="text/css">
    .productImg{
        width: 150px;
        padding: 5px;
        background: white;
        border: 1px solid #CCC;
    }
</style>
<div class="container">
<div class="row">
    <div class="col-md-9"> 
        <h6><a href="viewProducts_.jsp">Top Viewed Products</a></h6>
<%
 String sqlTopMostProds = "SELECT * "
+" FROM  `products` p"
+" INNER JOIN  `images` i"
+" USING (  `product-name` ) "
 + "WHERE `product_qty` > 5 "
+" GROUP BY  `product-name` "
+" ORDER BY  `hits` DESC "
 + " LIMIT 0,3 ";
 
 
 ArrayList<String> topMost = new ArrayList<String>();
 topMost.clear();
 Connection c = new DB_Conn().getConnection();
 Statement st = c.createStatement();
 ResultSet rs = st.executeQuery(sqlTopMostProds);
 String name, productId, category, subCategory, company, imageName, price;
 int i= 1;
 
 while (rs.next()){ 
     
      price = rs.getString("price");
      imageName = rs.getString("image-name");
      productId = rs.getString("product_id");
      name = rs.getString("product-name");
      subCategory = rs.getString("sub-category-name");
      category = rs.getString("category-name");
      company = rs.getString("company-name");
      %>
              <div class="col-sm-4 col-lg-4 col-md-4"> 
        <div class="panel panel-primary">
            <div class="panel-heading">
               <h6 class="panel-title text-center"><a href="product.jsp?id=<%= productId %>"><%= name %></a></h6>
              </div>
            <div class="panel-body">
                <a href="product.jsp?id=<%= productId %>"><img class="productImg center-block" src="<%= imageName %>" /></a>
                
            </div>  
            <div class="panel-footer">
                <a class="pull-right" href="product.jsp?id=<%= productId %>">Price: <i class="fa fa-rupee"></i> <%= price %></a>
                <small><%= company %> </small><br>
                <small><span class="label label-danger"><%= category %></span></small>
            </div>
        </div>
    </div>
                       <%
    if (i%5 == 0){
        %>
                       <%
    }
      i++;
 }
if (i == 0){
%>
     <div class="col-sm-4 col-lg-4 col-md-4"> 
        <a href="product.jsp">
            <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title">No Product Found</h3>
                </div>
                <div class="panel-body">
                  Sorry! The database is currently empty.
                </div>
              </div>
        </a>            
    </div>
<%
}
%>
      </div>
    </div>
</div>