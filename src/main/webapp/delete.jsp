<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%
    String no = request.getParameter("no");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>
</head>
<body>
    <!-- 비밀번호 확인 폼 -->
    <form method="post" action="delete.jsp">
    <input type='hidden' name="no" value="<%= no %>">
    <table>
        <tr>
            <td>비밀번호</td>
            <td><input type="password" name="password"></td>
            <td><input type="submit" value="확인"></td>
            <td><a href="index.jsp">메인으로 돌아가기</a></td>
        </tr>
    </table>
    </form>
</body>
</html>

<%
    if(request.getMethod().equalsIgnoreCase("POST")) {
        request.setCharacterEncoding("UTF-8"); // POST 요청 인코딩 설정
        String password = request.getParameter("password");
        out.println("입력한 비밀번호: " + password + "<br>");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String url = "jdbc:oracle:thin:@localhost:1522:xe";
        String user = "himedia"; 
        String passwordDB = "himedia"; 

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, passwordDB);
            String sql = "SELECT password FROM guestbook WHERE no=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(no));
            rs = pstmt.executeQuery();

            if(rs.next()) {
                String dbPassword = rs.getString("password");
                out.println("데이터베이스에 저장된 비밀번호: " + dbPassword + "<br>");
                if ( dbPassword.equals(password)) {
                    sql = "DELETE FROM guestbook WHERE no=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(no));
                    pstmt.executeUpdate();
                    response.sendRedirect("index.jsp");
                } else {
                    out.println("비밀번호가 틀립니다.");
                }
            } else {
                out.println("해당 번호의 글이 없습니다.");
            }
        } catch(Exception e) {
            e.printStackTrace();
            out.println("오류가 발생했습니다: " + e.getMessage());
        } finally {
            if(rs != null) try { rs.close(); } catch(SQLException e) {}
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
            if(conn != null) try { conn.close(); } catch(SQLException e) {}
        }
    }
%>
