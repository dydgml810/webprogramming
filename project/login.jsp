<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h1>로그인</h1>
    <form method="post" action="loginAction.jsp">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required>
        <br>
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <input type="submit" name="submit" value="로그인">
    </form>

    <button onclick="window.location.href='register.jsp'">회원가입</button>
    <br>
    <a href="main.jsp">메인으로 돌아가기</a>
</body>
</html>