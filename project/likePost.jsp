<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String postId = request.getParameter("post_id");
    String userId = request.getParameter("user_id");

    PreparedStatement pstmt = null;

    try {
        pstmt = conn.prepareStatement("INSERT INTO likes (post_id, user_id) VALUES (?, ?)");
        pstmt.setInt(1, Integer.parseInt(postId));
        pstmt.setInt(2, Integer.parseInt(userId));
        pstmt.executeUpdate();

        response.sendRedirect("board.jsp?id=" + postId);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
