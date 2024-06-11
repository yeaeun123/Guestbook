package guestbooktest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBTest {
    public static void main(String[] args) {
        Connection conn = null;
        String url = "jdbc:oracle:thin:@localhost:1522:xe";
        String user = "himedia";
        String password = "himedia";

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("Database connected successfully!");
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if(conn != null) try { conn.close(); } catch(SQLException e) {}
        }
    }
}
