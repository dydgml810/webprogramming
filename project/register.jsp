<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h1>회원가입</h1>
    <form method="post" action="registerAction.jsp">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required>
        <br>
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <label for="name">이름:</label>
        <input type="text" id="name" name="name" required>
        <br>
        <label for="tel">휴대폰 번호:</label>
        <input type="tel" name="tel" required>
        <br>
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required>
        <br>
        <label for="dob">생일:</label>
        <input type="date" name="dob" required>
        <br>
        <label for="gender">성별:</label>
        <input type="radio" id="gender" name="gender" value="M" title="성별">남자
        <input type="radio" id="gender" name="gender" value="F" title="성별">여자
        <br>
        <input type="submit" name="submit" value="회원가입">
    </form>
    <br>
    <a href="main.jsp">메인으로 돌아가기</a>
</body>
</html>