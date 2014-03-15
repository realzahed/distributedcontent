package helpers;

public class StringSlasher {
    public void sqlSlasher (String sql){
        char arr [] = sql.toCharArray();
        String strarr [] = sql.split(" ");
        
        for (int i = 0 ; i< strarr.length ; i++){
            System.out.print(""+strarr[i]);
        }
    }
    
    public static void main(String args[]){
        StringSlasher slash = new StringSlasher();
        String sql = "Hello ";
        slash.sqlSlasher(sql);
    }
    
}
