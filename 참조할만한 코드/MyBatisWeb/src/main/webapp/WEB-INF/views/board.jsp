<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="loginId" value="${sessionScope.id }" />
<c:set var="loginout" value="${sessionScope.id==null ? 'Login' : loginId }" />
<c:set var="loginoutlink" value="${sessionScope.id==null ? '/login/login' : '/login/logout' }"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href='<c:url value='/resources/css/menu.css' />'/>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <title>게시글 조회</title>
    
    <style type="text/css">
    	*{
    		font-family: 'Noto Sans KR', sans-serif;
    	}
    	
    	.container{
    		width: 50%;
    		margin: auto;
    	}
    	
    	.writing-header{
    		position: relative;
    		margin: 20px 0 0 0;
    		padding-bottom: 10px;
    		border-bottom: 2px solid #646464;
    	}

		.frm{
			width: 100%;
		}
		
		input{
			width: 100%;
			height: 35px;
			margin: 5px 0px 10px 0px;
			border-style: none;
			border-bottom: 2px solid #646464;
			padding: 8px;
			font-size: 18px;
		}
		
		textarea{
			width: 100%;
			color: black;
			padding: 6px 12px;
			font-size: 16px;
			margin: 5px 0px 10px 0px;
			border-style: none;
			border-bottom: 2px solid #646464;
			resize: none;
			padding: 8px;
		}
		
		.total-btn{
			display: flex;
			justify-content: flex-end;	
		}
		.btn{
			background-color: #ffc0cb;
			border: none;
			color: black;
			padding: 6px 12px;
			font-size: 16px;
			cursor: pointer;
			border-radius: 5px;
			font-weight: bold;
			margin: 0 5px;
		}
		
		.btn:hover{
			text-decoration: underline;
		}
    </style>
</head>
<body>
    
    <div id="menu">
    	<ul>
    		<li id="logo">earth</li>
    		<li><a href="<c:url value='/' />">Home</a></li>
    		<li><a href="<c:url value='/board/list' />">Board</a></li>
    		<li><a href="<c:url value='${loginoutlink }' />">${loginout}</a></li>
    		<li><a href="<c:url value='/register/add' />">SignUp</a></li>
    		<li><a href=""><i class="fa-sharp fa-solid fa-magnifying-glass" style="background-color: #ffc0cb;"></i></a></li>
    	</ul>    
    </div>
    
    <script type="text/javascript">
    	$(document).ready(function() {	/* main */
			let bno = $("input[name=bno]").val()
			
			$("#listBtn").on("click", function() {
				/* alert("listBtn clicked!") */
				location.href="<c:url value='/board/list${searchItem.queryString}' />"
			})
			
			$("#removeBtn").on("click", function() {
				/* alert("removeBtn clicked!") */
			
				if(!$("input[name=title]").attr('readonly')){
					let form = $("#form")
					form.attr("action", "<c:url value='/board/read${searchItem.queryString}' />")
					form.attr("method", "get")
					form.submit()
					return
				}
				
				if(!confirm("정말로 삭제하시겠습니까?")) return
				
				let form = $("#form")
				form.attr("action", "<c:url value='/board/remove${searchItem.queryString}' />")
				form.attr("method", "post")
				form.submit()
			})
			
			$("#writeBtn").on("click", function() {
				/* alert("writeBtn clicked!") */
				let form = $("#form")
				form.attr("action", "<c:url value='/board/write' />")
				form.attr("method", "post")
				
				if(formCheck()){
					form.submit()
				}

			})
			
			let formCheck = function() {
				let form = document.getElementById("form")
				
				if(form.title.value==""){
					alert("제목을 입력해 주세요.")
					form.title.focus()
					return false
				}
				
				if(form.content.value==""){
					alert("내용을 입력해 주세요.")
					form.content.focus()
					return false
				}
				return true
			}
    	
			$("#modifyBtn").on("click", function() {
				let form = $("#form")
				let isReadonly = $("input[name=title]").attr('readonly')
				
				//읽기 상태이면 수정상태로 변경
				if(isReadonly=='readonly'){
					$(".writing-header").html("게시판 수정")
					$("input[name=title]").attr('readonly', false)
					$("textarea").attr('readonly', false)
					$("#modifyBtn").html("<i class='fa-solid fa-pen-to-square' style='background-color: #ffc0cb'></i>등록")
					$("#removeBtn").html("취소")
					return
				}
				
				//수정상태로 수정된 내용을 서버로 전송
				form.attr("action", "<c:url value='/board/modify${searchItem.queryString}' />")
				form.attr("method", "post")
				
				if(formCheck()){
					form.submit()
				}
			})
			
			let showList = function(bno) {
			
				$.ajax({
					type: 'GET',						//요청 메서드
					url: '/heart/comments?bno='+bno, 	//요청 URI
					success: function(result) {
						$("#commentList").html(toHtml(result))	//result는 서버가 전송한 데이터
					},
					error: function(){alert("error")}			//에러가 발생할 때, 
				})
			}
			
			let toHtml = function(comments) {
				let tmp = "<ul style='display: block;'>"
				comments.forEach(function(comment) {
					tmp += '<li style="width: 100%;" data-cno='+comment.cno
					tmp += ' data-pcon='+comment.pcno
					tmp += ' data-bno='+comment.bno
					tmp += ' comment=<span class="comment">'+comment.comment+'</span>'
					tmp += ' commenter=<span class="commenter">'+comment.commenter+'</span>'
					tmp += ' <button class="btn delBtn">삭제</button>'
					tmp += '</li>'
				})			
				return tmp + "</ul>"
			}
			
			showList(bno)
		})
    </script>
    
    <script type="text/javascript">
    	let msg = "${msg}"
    	if(msg == "WRT_ERR") alert("게시물 등록에 실패하였습니다. 다시 시도해 주세요!")
    	if(msg == "MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요!")
    
    </script>
    
    <div class="container">
    	<h2 class="writing-header">게시판 ${mode=="new" ? "글쓰기" : "읽기"}</h2>
    
    	<form action="" id="form" class="frm" method="post">
    		<input type="hidden" name="bno" value="${boardDTO.bno }"  />
    		<input type="text" name="title" value="${boardDTO.title }" ${mode=="new" ? "" : "readonly='readonly'" } />
    		<br />
    		<textarea rows="20" name="content" ${mode=="new" ? "" : "readonly='readonly'" } >${boardDTO.content }</textarea>
    		<br />

    		<div class="total-btn">
    		<!-- <button type="button" id="listBtn" class="btn"><i class="fa-solid fa-list" style="background-color: #ffc0cb"></i>목록</button> -->
	    		<c:if test="${mode eq 'new'}">
	    			<button type="button" id="writeBtn" class="btn"><i class="fa-solid fa-pen-to-square" style="background-color: #ffc0cb"></i>등록</button>
	    			<button type="button" id="listBtn" class="btn">취소</button>
	    		</c:if>
	    		
	    		<%-- <c:if test="${mode eq 'new'}">
	    			<button type="button" id="writeNewBtn" class="btn"><i class="fa-solid fa-pen-to-square"></i>글쓰기</button>
	    		</c:if> --%>
	    		
	    		<c:if test="${boardDTO.writer eq loginId}">
	    			<button type="button" id="modifyBtn" class="btn"><i class="fa-solid fa-pen-to-square" style="background-color: #ffc0cb"></i>수정</button>
	    			<button type="button" id="removeBtn" class="btn"><i class="fa-solid fa-trash" style="background-color: #ffc0cb"></i>삭제</button>
	    		</c:if>
	    		<button type="button" id="listBtn" class="btn"><i class="fa-solid fa-list" style="background-color: #ffc0cb"></i>목록</button>
    		</div>
    	</form>
    	
    	<!-- <button type="button" id="sendBtn" class="btn" >SEND</button>
    	<button type="button" id="modBtn" class="btn" >수정하기</button> -->
    	<button id="commentList"></button>
    </div>
</body>
</html>






























