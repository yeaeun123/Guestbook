<%@page import="GuestBookDao.GuestVo"%>
<%@page import="GuestBookDao.GuestbookDao"%>
<%@page import="GuestBookDao.GuestBookOracleImpl"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>
</head>
<body>
    <!-- 방명록 추가 폼 -->
  
   <form action="add.jsp" method="post">
    <table border=1 width=510>
        <tr>
            <td>이름</td><td><input type="text" name="name"></td>
            <td>비밀번호</td><td><input type="password" name="pass"></td>
        </tr>
        <tr>
            <td colspan=4><textarea name="content" cols=60 rows=5></textarea></td>
        </tr>
        <tr>
            <td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
        </tr>
    </table>
    </form>
    <br/>
<table width=510 border=1>
		<tr>
			<td>[1]</td>
			<td>홍길동</td>
			<td>2018-01-15</td>
			<td><a href="delete.jsp">삭제</a></td>
		</tr>
		<tr>
			<td colspan=4>안녕하세요<br/>첫번째글입니다.</td>
		</tr>
	</table>
        <br/>
	<table width=510 border=1>
		<tr>
			<td>[1]</td>
			<td>장실산</td>
			<td>2018-01-15</td>
			<td><a href="delete.jsp">삭제</a></td>
		</tr>
		<tr>
			<td colspan=4>안녕하세요<br/>두번째글입니다.</td>
		</tr>
	</table>
        <br/>
    <!-- 방명록 항목 표시 -->
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String url = "jdbc:oracle:thin:@localhost:1522:xe";
        String user = "himedia"; // 오라클 사용자명
        String password = "himedia"; // 오라클 비밀번호

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, password);
            String sql = "SELECT * FROM guestbook ORDER BY no DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                int no = rs.getInt("no");
                String name = rs.getString("name");
                String reg_date = rs.getString("reg_date");
                String content = rs.getString("content");
    %>
    <table width=510 border=1>
        <tr>
            <td>[<%= no %>]</td>
            <td><%= name %></td>
            <td><%= reg_date %></td>
            <td><a href="delete.jsp?no=<%= no %>">삭제</a></td>
        </tr>
        <tr>
            <td colspan=4><%= content.replace("\n", "<br/>") %></td>
        </tr>
    </table>
    <br/>
    <%
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try { rs.close(); } catch(SQLException e) {}
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
            if(conn != null) try { conn.close(); } catch(SQLException e) {}
        }
    %>
</body>
</html>