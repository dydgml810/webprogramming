<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // String commentId = request.getParameter("comment_id");
    // String userId = request.getParameter("user_id");
    // String postId = request.getParameter("post_id"); // post_id 파라미터 추가
    PreparedStatement pstmt = null;

    try {
        int commentId = Integer.parseInt(request.getParameter("comment_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        pstmt = conn.prepareStatement("INSERT INTO comment_likes (comment_id, user_id) VALUES (?, ?)");
        pstmt.setInt(1, commentId);
        pstmt.setInt(2, userId);
        pstmt.executeUpdate();

        int postId = Integer.parseInt(request.getParameter("post_id"));
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

