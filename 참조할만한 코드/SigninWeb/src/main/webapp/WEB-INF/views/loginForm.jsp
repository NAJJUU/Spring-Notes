<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style type="text/css">
    	*{
    		box-sizing: border-box;
    		background-color: #fafaaa;
    	}
    	
    	#title{
    		font-size: 35px;
    		font-weight: bolder;
    		background-color: #ffc0cb;
    	}
    	
    	a{
    		text-decoration: none;
    		background-color: #ffc0cb;
    	}
    	
    	label{
    		background-color: #ffc0cb;
    	}
    	
    	form{
    		width: 400px;
    		height: 500px;
    		display: flex;
    		flex-direction: column;
    		align-items: center;
    		position: absolute;
    		top: 50%;
    		left: 50%;
    		transform: translate(-50%, -50%);
    		border: 2px solid #646464;
    		border-radius: 10px;
    		background-color: #ffc0cb;
    	}
    
    	input[type='text'], input[type='password']{
    		width: 300px;
    		height: 40px;
    		border: 1.5px solid #646464;
    		border-radius: 5px;
    		padding: 0 10px;
    		margin-bottom: 10px;
    		background-color: white;
    	}
    	
    	button{
    		background-color: #646464;
    		color: white;
    		width: 300px;
    		height: 50px;
    		font-size: 23px;
    		font-weight: bold;
    		border: none;
    		border-radius: 5px;
    		margin: 20px 0 30px 0;
    	}
    	
    	#msg{
    		height: 30px;
    		text-align: center;
    		font-size: 16px;
    		font-weight: bold;
    		color: red;
    		margin-bottom: 20px;
    		background-color: #ffc0cb;
    	}
    	.fa{
    		background-color: #ffc0cb;
    	}

    </style>
    <title>Login</title>
</head>
<body>
    <form action='<c:url value='/login/login' />' method="post" onsubmit="return frmCheck(this)">
    	<h3 id="title">Login</h3>
    	
    	<div id="msg">
    		<c:if test="${not empty param.msg }">
    			<i class="fa fa-exclamation-circle">${URLDecoder.decode(param.msg)}</i>
    		</c:if>
    	</div>
    	
    	<input type="text" name="id" placeholder="이메일 입력" value="${cookie.id.value }" autofocus/>
    	<input type="password" name="pwd" placeholder="비밀번호" />
    	
    	<button>로그인</button>
    	
    	<div style="background-color: #ffc0cb;">
    		<label><input type="checkbox" name="rememverId" value="on" ${empty cookie.id.value ? "" : "checked"}/>아이디 기억</label> |
    		<a href="">비밀번호 찾기</a> |
    		<a href="">회원가입</a>
    	</div>
    </form>
    
    <script type="text/javascript">
    	function frmCheck(frm) {
			let msg = ''
			
			if(frm.id.value.length == 0){
				setMessage('id를 입력해주세요.', frm.id)
				return false;
			}
			
			if(frm.pwd.value.length == 0){
				setMessage('비밀번호를 입력해주세요.', frm.pwd)
				return false;
			}
			
			return true;
		}
    	
    	function setMessage(msg, element) {
			document.getElementById("msg").innerHTML
				=`<i class="fa fa-exclamation-circle">${'${msg}'}</i>`
			if(element){
				element.select()
			}
		}
    </script>
</body>
</html>

























































