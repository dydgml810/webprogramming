<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String postId = request.getParameter("post_id");
    String comment = request.getParameter("comment");

    PreparedStatement pstmt = null;

    try {
        pstmt = conn.prepareStatement("INSERT INTO comments (post_id, comment) VALUES (?, ?)");
        pstmt.setInt(1, Integer.parseInt(postId));
        pstmt.setString(2, comment);
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
