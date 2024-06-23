<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String commentId = request.getParameter("comment_id");
    String postId = request.getParameter("post_id");

    PreparedStatement pstmt = null;

    try {
        
        pstmt = conn.prepareStatement("DELETE FROM comments WHERE id = ?");
        pstmt.setInt(1, Integer.parseInt(commentId));
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
