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

        .signup-container {
            background-color: white;
            border-radius: 16px;
            padding: 36px;
            width: 100%;
            max-width: 580px;
			height: 100%;
			max-height: 630px; 
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        h1 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #1d1d1f;
        }

		#signupForm {
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

        .password-confirm-message {
			text-align: end;
            font-size: 12px;
            color: #34c759;
            margin-top: 8px;
            display: none;
        }

        .password-confirm-message.show {
            display: block;
        }

        .date-row {
            display: flex;
            gap: 16px;
        }

        .date-group,
        .gender-group {
            flex: 1;
        }

        .button-group {
            display: flex;
			justify-content: flex-end;
            gap: 12px;
            margin-top: 20px;
        }

        button {
			width: 100px;
			height: 50px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .signup-btn {
            background-color: #6c63ff;
            color: white;
        }

        .signup-btn:hover {
            background-color: #5a52d5;
        }

        .cancel-btn {
            background-color: #f5f5f7;
            color: #1d1d1f;
        }

        .cancel-btn:hover {
            background-color: #e8e8ed;
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
    <div class="signup-container">
        <h1>회원가입</h1>
        
        <form action="register" method="post" id="signupForm">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="passwordConfirm">비밀번호 확인</label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" required>
                <div class="password-confirm-message" id="passwordMessage">
                    비밀번호가 일치합니다.
                </div>
            </div>
            
            <div class="date-row">
                <div class="date-group">
                    <label for="nickname">닉네임</label>
                    <input type="text" id="nickname" name="nickname">
                </div>
                
                <div class="gender-group">
                    <label for="gender">성별</label>
                    <select id="gender" name="gender">
                        <option value="M">남성</option>
                        <option value="F">여성</option>
                    </select>
                </div>
            </div>
            
            <div class="button-group">
                <button type="submit" class="signup-btn">회원가입</button>
                <button type="button" class="cancel-btn" onclick="handleCancel()">취소</button>
            </div>
        </form>
    </div>
</body>
<script>
	
</script>
</html>