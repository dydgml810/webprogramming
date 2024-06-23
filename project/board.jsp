<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    PreparedStatement pstmt = null;
    PreparedStatement commentsPstmt = null;
    PreparedStatement likesPstmt = null;
    PreparedStatement commentLikesPstmt = null;
    ResultSet rs = null;
    ResultSet commentsRs = null;
    ResultSet likesRs = null;
    ResultSet commentLikesRs = null;
    String postId = request.getParameter("id");
    boolean singlePostView = postId != null;

    try {
        if (singlePostView) {
            // 개별 게시글 보기
            pstmt = conn.prepareStatement("SELECT * FROM posts WHERE id = ?");
            pstmt.setInt(1, Integer.parseInt(postId));
            rs = pstmt.executeQuery();

            commentsPstmt = conn.prepareStatement("SELECT * FROM comments WHERE post_id = ?");
            commentsPstmt.setInt(1, Integer.parseInt(postId));
            commentsRs = commentsPstmt.executeQuery();

            likesPstmt = conn.prepareStatement("SELECT COUNT(*) AS like_count FROM likes WHERE post_id = ?");
            likesPstmt.setInt(1, Integer.parseInt(postId));
            likesRs = likesPstmt.executeQuery();
        } else {
            // 게시글 목록 보기
            pstmt = conn.prepareStatement("SELECT * FROM posts");
            rs = pstmt.executeQuery();
        }
%>
<!DOCTYPE html>
<html>
<head>
    <title>게시판</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>게시판</h1>
    <% if (singlePostView) { %>
        <!-- 개별 게시글 보기 -->
        <% if (rs.next()) { %>
            <h2><%= rs.getString("title") %></h2>
            <p><%= rs.getString("content") %></p>
            <p>첨부 파일: <a href="downloadFile.jsp?id=<%= rs.getInt("id") %>"><%= rs.getString("file_name") %></a></p>
            <h3>좋아요</h3>
            <% if (likesRs.next()) { %>
                <p>좋아요 수: <%= likesRs.getInt("like_count") %></p>
            <% } %>
            <form action="likePost.jsp" method="post">
                <input type="hidden" name="post_id" value="<%= postId %>">
                <input type="hidden" name="user_id" value="1">
                <button type="submit">좋아요</button>
            </form>
            <form action="unlikePost.jsp" method="post">
                <input type="hidden" name="post_id" value="<%= postId %>">
                <input type="hidden" name="user_id" value="1">
                <button type="submit">좋아요 취소</button>
            </form>

            <h3>덧글</h3>
            <table>
                <tr>
                    <th>덧글</th>
                    <th>작성 시간</th>
                    <th>좋아요 수</th>
                    <th>좋아요</th>
                    <th>좋아요 취소</th>
                    <th>삭제</th>
                </tr>
                <% while (commentsRs.next()) {
                    int commentId = commentsRs.getInt("id");

                    // 덧글 좋아요 수 조회
                    commentLikesPstmt = conn.prepareStatement("SELECT COUNT(*) AS like_count FROM comment_likes WHERE comment_id = ?");
                    commentLikesPstmt.setInt(1, commentId);
                    commentLikesRs = commentLikesPstmt.executeQuery();
                    int commentLikeCount = 0;
                    if (commentLikesRs.next()) {
                        commentLikeCount = commentLikesRs.getInt("like_count");
                    }
                %>
                    <tr>
                        <td><%= commentsRs.getString("comment") %></td>
                        <td><%= commentsRs.getTimestamp("created_at") %></td>
                        <td><%= commentLikeCount %></td>
                        <td>
                            <form action="likeComment.jsp" method="post">
                                <input type="hidden" name="comment_id" value="<%= commentId %>">
                                <input type="hidden" name="user_id" value="1">
                                <button type="submit">좋아요</button>
                            </form>
                        </td>
                        <td>
                            <form action="unlikeComment.jsp" method="post">
                                <input type="hidden" name="comment_id" value="<%= commentId %>">
                                <input type="hidden" name="user_id" value="1">
                                <button type="submit">좋아요 취소</button>
                            </form>
                        </td>
                        <td>
                            <form action="deleteComment.jsp" method="post">
                                <input type="hidden" name="comment_id" value="<%= commentsRs.getInt("id") %>">
                                <input type="hidden" name="post_id" value="<%= postId %>">
                                <button type="submit">삭제</button>
                            </form>
                        </td>
                    </tr>
                 <% 
                    if (commentLikesRs != null) commentLikesRs.close();
                    if (commentLikesPstmt != null) commentLikesPstmt.close();
                } %>
            </table>
            <h3>덧글 작성</h3>
            <form action="addComment.jsp" method="post">
                <input type="hidden" name="post_id" value="<%= postId %>">
                <textarea name="comment" rows="4" cols="50"></textarea>
                <button type="submit">덧글 작성</button>
            </form>
        <% } %>
        <a href="board.jsp">목록으로 돌아가기</a>
    <% } else { %>
        <!-- 게시글 목록 보기 -->
        <a href="writePost.jsp">글 쓰기</a>
        <h2>게시물 목록</h2>
        <table>
            <tr>
                <th>제목</th>
                <th>내용</th>
                <th>첨부 파일</th>
                <th>덧글 수</th>
                <th>좋아요 수</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
            <% 
                PreparedStatement commentCountPstmt = null;
                PreparedStatement likeCountPstmt = null;
                ResultSet commentCountRs = null;
                ResultSet likeCountRs = null;
            
                while(rs.next()) { 
                    int postIdInt = rs.getInt("id");

                    // 덧글 수 조회
                    commentCountPstmt = conn.prepareStatement("SELECT COUNT(*) AS comment_count FROM comments WHERE post_id = ?");
                    commentCountPstmt.setInt(1, postIdInt);
                    commentCountRs = commentCountPstmt.executeQuery();
                    int commentCount = 0;
                    if (commentCountRs.next()) {
                        commentCount = commentCountRs.getInt("comment_count");
                    }

                    // 좋아요 수 조회
                    likeCountPstmt = conn.prepareStatement("SELECT COUNT(*) AS like_count FROM likes WHERE post_id = ?");
                    likeCountPstmt.setInt(1, postIdInt);
                    likeCountRs = likeCountPstmt.executeQuery();
                    int likeCount = 0;
                    if (likeCountRs.next()) {
                        likeCount = likeCountRs.getInt("like_count");
                    }
            %>
                <tr>
                    <td><a href="board.jsp?id=<%= postIdInt %>"><%= rs.getString("title") %></a></td>
                    <td><%= rs.getString("content") %></td>
                    <td><a href="downloadFile.jsp?id=<%= postIdInt %>"><%= rs.getString("file_name") %></a></td>
                    <td><%= commentCount %></td>
                    <td><%= likeCount %></td>
                    <!-- 수정 폼으로 이동하는 링크 -->
                    <td><a href="editPost.jsp?id=<%= postIdInt %>">수정</a></td>
                    <!-- 삭제 폼으로 이동하는 링크 -->
                    <td><a href="deletePost.jsp?id=<%= postIdInt %>">삭제</a></td>
                </tr>
            <% 
                if (commentCountRs != null) commentCountRs.close();
                if (likeCountRs != null) likeCountRs.close();
                if (commentCountPstmt != null) commentCountPstmt.close();
                if (likeCountPstmt != null) likeCountPstmt.close();
            } 
            %>
        </table>
    <% } %>
    <a href="main.jsp">메인으로 돌아가기</a>

</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (commentsRs != null) commentsRs.close();
            if (likesRs != null) likesRs.close();
            if (commentLikesRs != null) commentLikesRs.close();
            if (pstmt != null) pstmt.close();
            if (commentsPstmt != null) commentsPstmt.close();
            if (likesPstmt != null) likesPstmt.close();
            if (commentLikesPstmt != null) commentLikesPstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
