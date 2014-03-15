<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="database.DB_Conn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<style type="text/css">
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
    #panel-inner {
        box-shadow: 0 8px 16px -6px #ccc;
    }
    #panel-inner:hover {
        box-shadow: 0 8px 15px -5px #555;
    }
    #panel-price {
        border-top: 1px solid #c9c9c9;
    }
</style>
    <div class="panel panel-default">
        <div class="panel-heading">Most Viewed Products<span class="pull-right"><a class="btn btn-default btn-embossed btn-xs" href=../../viewProducts_.jsp>View All</a></span></div>
        <div class="panel-body">
        <%
         String sqlTopMostProds = "SELECT * "
        +" FROM  `products` p"
        +" INNER JOIN  `images` i"
        +" USING (  `product-name` ) "
        + "WHERE `product_qty` > 5 "
        +" GROUP BY  `product-name` "
        +" ORDER BY  `hits` DESC "
        + " LIMIT 0,6 ";
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
                       <small><span class="label" style="background-color: #cad3d9;font-size: 12px;"><%= company %></span></small>
                       <a class="pull-right label" style="background-color:#cad3d9;color: #4a495b;font-size: 16px;" href="product.jsp?id=<%= productId %>" style="text-decoration: none; font-weight: bold;"><i class="fa fa-rupee"></i> <%= price %></a>
                    </div>
                </div>
            </div>
          </div>
        <%
        if (i%4 == 0){
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
