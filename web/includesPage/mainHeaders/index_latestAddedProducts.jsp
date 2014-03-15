<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DB_Conn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<style>
    .productImg{
        width: 150px;
        height: 180px;
        padding: 5px;
        background: white;
        border: 1px solid #e5e5e5;
    }
    #inner {
        text-overflow: ellipsis;
        white-space:nowrap;
        overflow:hidden;
    }
    #panel-price {
        border-top: 1px solid #c9c9c9;
    }
    #panel-inner {
        box-shadow: 0 8px 16px -6px #ccc;
    }
    #panel-inner:hover {
        box-shadow: 0 8px 20px -6px #ff4400;
    }
</style>
    <div class="panel panel-default">
      <div class="panel-heading">New Releases</div>
        <div class="panel-body">
<%
 String sqlTopMostProds = "SELECT * "
+" FROM  `products` p"
+" INNER JOIN  `images` i"
+" USING (  `product-name` ) "
 + "WHERE `product_qty` > 5 "
+" GROUP BY  `product-name` "
+" ORDER BY  `lastUpdated` DESC "
 + " LIMIT 0,3 ";
 ArrayList<String> topMost = new ArrayList<String>();
 topMost.clear();
 Connection c = new DB_Conn().getConnection();
 Statement st = c.createStatement();
 ResultSet rs = st.executeQuery(sqlTopMostProds);
 String name, productId, category, subCategory, company, imageName, price;
 while (rs.next()){ 
        price = rs.getString("price");
      imageName = rs.getString("image-name");
      productId = rs.getString("product_id");
      name = rs.getString("product-name");
      subCategory = rs.getString("sub-category-name");
      category = rs.getString("category-name");
      company = rs.getString("company-name");
      %>
      
      <div class="col-sm-4 col-md-4 col-md-4"> 
            <div id="panel-inner" class="panel panel-default">
                <div class="panel-body">
                    <a href="product.jsp?id=<%= productId %>"><img class="productImg center-block" src="<%= imageName %>"/></a>
                </div>  
                <div class="panel-footer">
                    <div id="inner">
                        <p class="small text-center"><a href="product.jsp?id=<%= productId %>" style="text-decoration: none;"><strong><%= name %></strong></a></p>
                    </div>
                    <div id="panel-price inner">
                      <div class="productprice text-right">
                        <a class="pull-left label" style="background-color: #cad3d9;color: #4a495b;font-size: 16px;" href="product.jsp?id=<%= productId %>" style="text-decoration: none;"><i class="fa fa-rupee"></i> <%= price %></a>
                        <a class="btn btn-facebook btn-embossed btn-sm" href="addToCart.jsp?id=<%= productId %>" role="button">ADD TO CART</a>
                      </div>
                    </div>
                </div>
            </div>
          </div> 
           <%
            }
           %>
        </div>
    </div>