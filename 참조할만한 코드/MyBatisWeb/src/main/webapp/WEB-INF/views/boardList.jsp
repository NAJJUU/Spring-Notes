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
    <title>게시판 리스트</title>
    
    <style type="text/css">
    	*{
    		font-family: 'Noto Sans KR', sans-serif;
    	}
    	
    	.board-container{
    		width: 60%;
    		height: 1200px;
    		margin: 0 auto;
    	}
    	
    	table{
    		border-collapse: collapse;
    		width: 100%;
    		border-top: 2px solid #202020;
    		margin-top: 30px;
    	}
    	
    	tr:nth-child(even) {
			background-color: #fff;
		}
		
		th, td{
			width: 300px;
			text-align: center;
			padding: 10px 12px;
			border-bottom: 1px solid #646464;
		}
		
		td>a{
			background-color: #fafaaa;
			color: black;
		}
		
		.paging-container{
			width: 100%;
			height: 70px;
			display: flex;
			margin-top: 50px;
			margin: auto;
		}
		
		.paging{
			color: black;
			width: 100%;
			align-items: center;
		}
		
		.page{
			background-color: #fafaaa;
			color: black;
			padding: 6px;
			margin-right: 10px;
		}
		
		.btn-write{
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

 		.search-container{
 			display: flex;
			justify-content: flex-end;	
			margin-top: 50px;
			width: 100%;
 		}
 		 		
 		.search-form{
 			height: 37px;
 			display: flex;
 			align-items: center;
 		}
 		
 		.search-option{
 			color: black;
 			width: 90px;
 			height: 90%;
 			outline: none;
 			margin: 0 5px;
 			border: 1px solid #646464;
 		}
 		
 		.search-input{
 			color: black;
 			background-color: #fff;
 			border: 1px solid #646464;
 			height: 100%;
 			width: 300px;
 			font-size: 15px;
 			padding: 5px 7px;
 			outline: none;
 			font-weight: bold;
 		}
 		
 		.search-input::placeholder{
 			color: #646464;
 		}
 		
 		.btn-search{
 			width: 20%;
 			height: 100%;
 			background-color: #ffc0cb;
 			color: black;
 			font-size: 15px;
 			border: none;
 			border-radius: 5px;
 			font-weight: bold;
 			margin: 5px;
 		}
 		
 		.btn-search:hover{
 			cursor: pointer;
 		}
    </style>
</head>
<body>
    <!-- 헤더 include -->
    <%-- <%@ include file="" %> --%>
    
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
    	let msg = "${msg}"
    	if(msg == "DEL_OK") alert("삭제되었습니다.")
    	if(msg == "DEL_ERR") alert("이미 삭제되었거나 없는 게시물입니다.")
    	if(msg == "WRT_OK") alert("게시글이 등록되었습니다.")
    	if(msg == "MOD_OK") alert("게시글이 수정되었습니다.")
    </script>
    
    <div style="text-align: center;">
    	<div class="board-container">
    		<div class="search-container">
    			<form action="<c:url value='/board/list' />" class="search-form" method="get">
    				<select class="search-option" name="option">
    					<option value="A" ${pr.sc.option=='A' || pr.sc.option=='' ? "selected" : ""}>제목+내용</option>
    					<option value="T" ${pr.sc.option=='T' ? "selected" : ""}>제목</option>
    					<option value="W" ${pr.sc.option=='W' ? "selected" : ""}>작성자</option>
    				</select>
    				<input type="text" name="keyword" class="search-input" value="${param.keyword}" placeholder="검색어를 입력해주세요." />
    				<input type="submit" value="검색" class="btn-search" />
    			</form>
    			<button id="writeBtn" class="btn-write" onclick="location.href='<c:url value="/board/write" />'">
    				<i class="fa-solid fa-pen-to-square" style="background-color: #ffc0cb"></i>글쓰기
    			</button>
    		</div>
    		
    		<table>
    			<tr>
    				<th class="no">번호</th>
    				<th class="title">제목</th>
    				<th class="writer">이름</th>
    				<th class="regdate">등록일</th>
    				<th class="viewcnt">조회수</th>
    			</tr>
    			
    			<c:forEach var="boardDTO" items="${list}">
    				<tr>
    					<td class="no">${boardDTO.bno }</td>
    					<td class="title">
    						<a href="<c:url value="/board/read${pr.sc.queryString}&bno=${boardDTO.bno }" />">${boardDTO.title}</a>
    					</td>
    					<td class="writer">${boardDTO.writer}</td>
    					<td class="regdate">
    						<fmt:formatDate value="${boardDTO.reg_date }" pattern="yyyy-MM-dd" type="date" />
    					</td>
    					<td class="viewcnt">${boardDTO.view_cnt}</td>
    				</tr>
    			</c:forEach>
    		</table>
    		<br>
    		
    		<div class="paging-container">
    			<div class="paging">
    				<c:if test="${totalCnt == null || totalCnt == 0}">
    					<div>게시물이 없습니다.</div>
    				</c:if>
    				<c:if test="${totalCnt != null || totalCnt != 0}">
    					<c:if test="${pr.showPrev}">
    						<%-- <a class="page" href="<c:url value="/board/list${pr.sc.getQueryString(((pr.sc.page-1)/10-1)*10+1)}" />">&lt;</a> --%>
    						<a class="page" href="<c:url value="/board/list${pr.sc.getQueryString(pr.beginPage-1)}" />">&lt;</a>
    					</c:if>
    					<c:forEach var="i" begin="${pr.beginPage }" end="${pr.endPage}">
    						<a class="page" href="<c:url value="/board/list${pr.sc.getQueryString(i)}" />">${i}</a>
    					</c:forEach>
    					<c:if test="${pr.showNext}">
    						<%-- <a class="page" href="<c:url value="/board/list${pr.sc.getQueryString(((pr.sc.page-1)/10+1)*10+1)}" />">&gt;</a> --%>
    						<a class="page" href="<c:url value="/board/list${pr.sc.getQueryString(pr.endPage+1)}" />">&gt;</a>
    					</c:if>
    				</c:if>
    			</div>
    		</div>
    		
    	</div>
    
    </div>
</body>
</html>