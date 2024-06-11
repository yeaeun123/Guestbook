<%@ page import = "java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>

<% 
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String pass = request.getParameter("password");
	String content = request.getParameter("content");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String url = "jdbc:oracle:thin:@localhost:1522:xe";
	String user = "himedia";
	String password = "himedia";
	
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, password);
        String sql = "INSERT INTO guestbook(no, name, password, content, reg_date) VALUES(seq_guestbook_no.NEXTVAL, ?, ?, ?, SYSDATE)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, pass);
        pstmt.setString(3, content);
        pstmt.executeUpdate();
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
        if(conn != null) try { conn.close(); } catch(SQLException e) {}
    }
	response.sendRedirect("index.jsp");

	%>
