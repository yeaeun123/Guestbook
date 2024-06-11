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
public class GuestBookOracleImpl implements GuestbookDao{
	private String dbuser;
	private String dbpass;
	
	
	public GuestBookOracleImpl(String dbuser, String dbpass) {
		super();
		this.dbuser = dbuser;
		this.dbpass = dbpass;
	}


	private Connection getConnection() throws SQLException {
		Connection con = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String dburl = "jdbc:oracle:thin:@localhost:1522:xe";
            con = DriverManager.getConnection(dburl, dbuser, dbpass);
		} catch (ClassNotFoundException e) {
			System.err.println("JDBC Driver를 찾을 수 없습니다.");
		}
		return con;
	}
	
	
	@Override
	public List<GuestVo> getList() {
		List<GuestVo> lst = new ArrayList<>();
		String sql = 
				"SELECT no, name, password, content, reg_date FROM guestbook";
				
		try (
				Connection con = getConnection();
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
		) {
			while (rs.next()) {
				Long no = rs.getLong("no");
				String name = rs.getString("name");
				String password = rs.getString("password");
				String content = rs.getString("content");
				Date regDate = rs.getDate("reg_date");
				
				GuestVo tmp = new GuestVo(no, name, password, content, regDate);
				lst.add(tmp);
			}
		} catch (SQLException e) {
			System.err.println("연결 에러");
		} catch (Exception e) {
			System.err.println("에러");
		}
		return lst;
	}

	// method for get ResultSet with id parameter
	private ResultSet executeQuery(PreparedStatement pstmt, Long id) throws SQLException {
		pstmt.setLong(1, id);
		return pstmt.executeQuery();
	}
	
	@Override
	public GuestVo get(Long id) {
		GuestVo tmp = null;
		String sql = "SELECT no, name, password, content, reg_date FROM guestbook WHERE no = ?";
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = executeQuery(pstmt, id);
		) {
			if (rs.next()) {
				Long no = rs.getLong("no");
				String name = rs.getString("name");
				String password = rs.getString("password");
				String content = rs.getString("content");
				Date regDate = rs.getDate("reg_date");
				
				tmp = new GuestVo(no, name, password, content, regDate);
				}
		} catch (SQLException e) {
			System.err.println("연결 에러");
		} catch (Exception e) {
			System.err.println("에러");
		}
		return tmp;
	}
		
	@Override
	public boolean insert(GuestVo vo) {
		int insertCount = 0;
		String sql = "INSERT INTO guestbook(no, name, password, content, reg_date) VALUES(seq_guestbook_no.nextval, ?, nvl(?, ''), ?, sysdate)";
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
		) {
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getPassword());
			pstmt.setString(3, vo.getContent());
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("연결 에러");
		} catch (Exception e) {
			System.err.println("에러");
		}
		return insertCount == 1;
	}

	@Override
	public boolean delete(GuestVo vo) {
		int deleteCount = 0;
		String sql = "DELETE FROM guestbook WHERE no = ?";
				
		try (
				Connection con = getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
		) {
			pstmt.setLong(1, vo.getNo());
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("연결 에러");
		} catch (Exception e) {
			System.err.println("에러");
		}
		return deleteCount == 1;
	}
}