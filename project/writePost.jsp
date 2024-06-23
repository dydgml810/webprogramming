<%@ include file="dbconn.jsp" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 쓰기</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h1>글 쓰기</h1>
    <form action="uploadFile.jsp" method="post" enctype="multipart/form-data">
        파일 선택: <input type="file" name="file"><br>
        제목: <input type="text" name="title"><br>
        내용: <textarea name="content"></textarea><br>
        <input type="submit" value="업로드">
    </form>
    <!-- 게시판 목록으로 돌아가는 링크 -->
    <a href="board.jsp">목록으로</a>
</body>
</html>
