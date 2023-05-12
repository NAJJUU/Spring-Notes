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
				tmp += '</li>'
			})			
			return tmp + "</ul>"
		}
	    
    	$(document).ready(function() {
    		$("#sendBtn").click(function() {
				showList(bno)
			})
		})
    
    </script>
</body>
</html>