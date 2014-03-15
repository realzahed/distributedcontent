<script src="js/jquery-1.7.2.min.js"></script>     
<link rel="stylesheet" href="assets/css/stylemain.css"/>
<link rel="stylesheet" href="assets/css/shop-homepage.css"/>
<link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
<style>
    #searchrow {
        width: 50%;
        margin: 0 auto;
        margin-bottom: 3%;
      }
    .well{
        cursor: pointer;
    }
    .well:hover {
        outline: 2px solid #1bc5a3;
    }
</style>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.DB_Conn"%>
<%
        String sqlSearch = "";
        if (request.getParameter("searchbar") != null){
            String searchText = request.getParameter("searchbar");
            String searches [] = searchText.split(" ");                
            if (searchText.length() >= 0){
            sqlSearch = "SELECT * FROM  `products` p "
                        + "INNER JOIN  `images` i "
                        + "USING (  `product-name` ) WHERE ";
            //out.println (""+sqlSearch);
            for (int i=0; i<searches.length; i++){
                if (searches[i].trim().length() > 2){
                    sqlSearch+=" `tags` LIKE '%"+searches[i]+"%' ";
                    //out.println (" `tags` LIKE '%"+searches[i]+"%' ");
                    if (i != searches.length-1){
                        sqlSearch+=" AND ";
                        //out.println (" AND ");
                    }
                }
            }
            //out.println (" GROUP BY  `product-name` ");
            sqlSearch+=" AND `product_qty` > 5 ";               
            sqlSearch+=" GROUP BY  `product-name` ";             
            sqlSearch+=" ORDER BY  `hits` DESC ";         
        %>
        <div class="container">
          <div class="row" id="searchrow">
            <div class="col-md-11">
              <div class="well" style="margin-top: 3%;">
                <%
                DB_Conn con = new DB_Conn();
                Connection c = con.getConnection();
                Statement st = c.createStatement();
                ResultSet rs = st.executeQuery(sqlSearch.toString());
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
                <div class="media" onclick="window.location='product.jsp?id=<%=product_id%>';">
                      <a class="pull-left" href="product.jsp?id=<%=product_id%>"><img src="<%= image_name %>" class="media-object img-thumbnail" alt="64x64" style="width: 100px; height: 128px;"></a>
                      <div class="media-body">
                        <h4 class="media-heading"><a href="product.jsp?id=<%=product_id%>"><%=product_name %></a></h4>
                        <p>By <%= company_name %> <span class="label label-primary pull-right" style="font-size: 100%;"><i class="fa fa-rupee"></i> <%= price %></span></p>
                        <p><a href="addToCart.jsp?id=<%= product_id %>" class="btn btn-success btn-embossed pull-right hidden-sm hidden-xs">BUY NOW</a></p>
                        <p><a href="addToCart.jsp?id=<%= product_id %>" class="btn btn-success btn-embossed pull-right btn-xs visible-sm visible-xs">BUY NOW</a></p>
                        <p class="hidden-xs hidden-sm"><span class="badge pull-left"> <%= category_name %></span> <span class="badge pull-left"> <%=sub_category_name %></span></p>
                        <br><small class="hidden-xs hidden-sm hidden-md"><%= quantity %> available in Stock</small>
                      </div>
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
<%
            }
        %><%
                }
                %>