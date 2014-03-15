<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.DB_Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%
            Connection c = new DB_Conn().getConnection();
            Statement st = c.createStatement();
            //Fetch the (PID) Product ID 
            String productId = request.getParameter("sortBy");
 
                String sqlFetchItems = "SELECT * FROM  `products` p "
                        + "INNER JOIN  `images` i "
                        + "USING (  `product-name` ) "
                        + "GROUP BY  `product-name` ";
                       // + " ORDER BY `hits` DESC ";
                if (productId.equals("qa")){
                    sqlFetchItems = "SELECT * FROM  `products` p "
                        + "INNER JOIN  `images` i "
                        + "USING (  `product-name` ) "
                        + "GROUP BY  `product-name` "
                        + " ORDER BY `product_qty` ASC ";
                } else if(productId.equals("qd")) {
                    sqlFetchItems = "SELECT * FROM  `products` p "
                        + "INNER JOIN  `images` i "
                        + "USING (  `product-name` ) "
                        + "GROUP BY  `product-name` "
                        + " ORDER BY `product_qty` DESC ";
                } else if(productId.equals("ha")) {
                    sqlFetchItems = "SELECT * FROM  `products` p "
                        + "INNER JOIN  `images` i "
                        + "USING (  `product-name` ) "
                        + "GROUP BY  `product-name` "
                        + " ORDER BY `hits` ASC ";
                } else if(productId.equals("hd")) {
                    sqlFetchItems = "SELECT * FROM  `products` p "
                        + "INNER JOIN  `images` i "
                        + "USING (  `product-name` ) "
                        + "GROUP BY  `product-name` "
                        + " ORDER BY `hits` DESC ";
                    //price
                }  else if(productId.equals("pa")) {
                    sqlFetchItems = "SELECT * FROM  `products` p "
                        + "INNER JOIN  `images` i "
                        + "USING (  `product-name` ) "
                        + "GROUP BY  `product-name` "
                        + " ORDER BY `price` ASC ";
                } else if(productId.equals("pd")) {
                    sqlFetchItems = "SELECT * FROM  `products` p "
                        + "INNER JOIN  `images` i "
                        + "USING (  `product-name` ) "
                        + "GROUP BY  `product-name` "
                        + " ORDER BY `price` DESC ";
                    //price
                }   
                Statement st1 = c.createStatement();
                ResultSet rs = st1.executeQuery(sqlFetchItems.toString());
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
                <h4 class="media-heading text-success"><a style="text-decoration: none;" href="admin_manageProduct.jsp?pid=<%=product_id%>"><span style="color: #ff3800;"><%=product_name%></span></a></h4>
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
        <%
        %>
