package GuestBookDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GuestBookOracleImpl implements GuestbookDao {
    private String user;
    private String password;

    public GuestBookOracleImpl(String user, String password) {
        this.user = user;
        this.password = password;
    }

    private Connection getConnection() throws SQLException {
        Connection conn = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String url = "jdbc:oracle:thin:@localhost:1522:xe"; 
            conn = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return conn;
    }

    @Override
    public List<GuestVo> getList() {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        List<GuestVo> list = new ArrayList<>();

        try {
            conn = getConnection();
            stmt = conn.createStatement();

            String sql = "SELECT * FROM guestbook ORDER BY no DESC";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                int no = rs.getInt("no");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String content = rs.getString("content");
                Date regDate = rs.getDate("reg_date");

                GuestVo vo = new GuestVo(no, name, password, content, regDate);

                list.add(vo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    @Override
    public boolean insert(GuestVo vo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int insertedCount = 0;

        try {
            conn = getConnection();

            String sql = "INSERT INTO guestbook(no, name, password, content, reg_date) VALUES(seq_guestbook_no.NEXTVAL, ?, ?, ?, SYSDATE)";

            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, vo.getName());
            pstmt.setString(2, vo.getPassword());
            pstmt.setString(3, vo.getContent());

            insertedCount = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 1 == insertedCount;
    }

    @Override
    public boolean delete(int no, String password) {
        int deleteCount = 0;
        String sql = "DELETE FROM guestbook WHERE no = ? AND password = ?";

        try (
                Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, no);
            pstmt.setString(2, password);
            deleteCount = pstmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("연결 에러: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("에러: " + e.getMessage());
        }
        return deleteCount == 1;
    }
}
