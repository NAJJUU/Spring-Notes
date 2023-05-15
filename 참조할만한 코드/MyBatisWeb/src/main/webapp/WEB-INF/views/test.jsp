<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <title>Document</title>
</head>
<body>
    <h2>CommentTest</h2>
    <button id="sendBtn">SEND</button>
    <div id="commentList"></div>
    
    <script type="text/javascript">
	    let bno = 1133
		
		let showList = function(bno) {
			
			$.ajax({
				type: 'GET',						//요청 메서드
				url: '/heart/comments?bno='+bno, 	//요청 URI
				success: function(result) {
					$("#commentList").html(toHtml(result))	//result는 서버가 전송한 데이터
				},
				error: function(){alert("error")}
			})
		}
	    
	    let toHtml = function(comments) {
			let tmp = "<ul>"
			comments.forEach(function(comment) {
				tmp += '<li data-cno='+comment.cno
				tmp += ' data-pcon='+comment.pcno
				tmp += ' data-bno='+comment.bno
				tmp += ' comment=<span class="comment">'+comment.comment+'</span>'
				tmp += ' commenter=<span class="commenter">'+comment.commenter+'</span>'
				tmp += ' <button class="btn delBtn">삭제</button>'
				tmp += '</li>'
			})			
			return tmp + "</ul>"
		}
	    
    	$(document).ready(function() {
    		$("#sendBtn").click(function() {
				showList(bno)
			})
					
			//$(".delBtn").click(function() {		//[send]버튼 클릭하고 나서 [삭제]버튼이 보임()
			$("#commentList").on("click", ".delBtn",function(){
				//alert("삭제버튼 클릭")
				let cno = $(this).parent().attr("data-cno")	//<li>태그는 <button>의 부모임
				let bno = $(this).parent().attr("data-bno")	
				
				$.ajax({
					type: 'DELETE',							//요청메서드
					url: '/heart/comments'+cno+'?bno='+bno,	//요청URI
					success: function(result) {				//서버로부터 응답이 도착하면 호출될 함수
						alert(result)						//result는 서버가 전송한 데이터
						showList(bno)
					},
					error: function() { alert("error") }	//에러가 발생했을 때 호출될 함수
				})
			})
		})
    
    </script>
</body>
</html>