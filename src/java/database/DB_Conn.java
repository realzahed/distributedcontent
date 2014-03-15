/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.*;
public class DB_Conn {

    private String database="dcac", username = "storeuser1", password = "1234567";
    private Connection con;
    
    public Connection getConnection() throws SQLException, ClassNotFoundException  {
        Class.forName("com.mysql.jdbc.Driver"); 
        con=DriverManager.getConnection("jdbc:mysql://mysql-env-2527962.j.layershift.co.uk/"+database+"",""+username+"",""+password+""); 
       // stm=con.createStatement(); 
        return con;
    }

    public String getDatabase() {
        return database;
    }

    public void setDatabase(String database) {
        this.database = database;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
