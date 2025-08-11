<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	<style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f5f5f7;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-container {
            background-color: white;
            border-radius: 16px;
            padding: 36px;
            width: 100%;
            max-width: 580px;
			height: 100%;
			max-height: 670px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .img-group {
            text-align: center;
        }

        .title-group {
            text-align: center;
        }

        h1 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #1d1d1f;
        }

		#loginForm {
			width: 90%;
			margin: auto;
		}

        .form-group {
            margin-bottom: 24px;
        }

        label {
            display: block;
            font-size: 14px;
            color: #1d1d1f;
            margin-bottom: 8px;
            font-weight: 500;
        }

		input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="date"] {
            width: 100%;
			height: 50px;
            padding: 16px;
            border: 1px solid #d2d2d7;
            border-radius: 12px;
            font-size: 16px;
            background-color: #f5f5f7;
            transition: all 0.2s ease;
        }

		input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="date"]:focus {
            outline: none;
            border-color: #0071e3;
            background-color: white;
        }

        .button-group {
            display: flex;
			justify-content: flex-end;
            align-items: center;
            gap: 12px;
            margin-top: 20px;
        }

        button,
        input[type="submit"] {
			width: 100px;
			height: 50px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .login-btn {
            background-color: #6c63ff;
            color: white;
        }

        .login-btn:hover {
            background-color: #5a52d5;
        }

        @media (max-width: 480px) {
            .signup-container {
                padding: 32px 24px;
            }
            
            h1 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="img-group">
            <img src="/image/Logo.png" alt="로고" />
        </div>
        <div class="title-group">
            <h1>로그인</h1>
        </div>
        
        <form method="post" action="<c:url value="/login"/>" id="loginForm">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="button-group">
                <a href="<c:url value="/register"/>" >회원가입</a>
                <input type="submit" value="로그인" class="login-btn">
            </div>
        </form>
    </div>
</body>
</html>