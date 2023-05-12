<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
    <title>ajax</title>
</head>
<body>
    <h2>{name:"earth", age:1}</h2>
    <button id="sendBtn" type="button">SEND</button>
    
    <h2>Data from Server : </h2>
    <div id="data"></div>
    
    <script type="text/javascript">
    	$(document).ready(function() {
			let person = {name:"earth", age:1}
			let person2 = {}
			
			$("#sendBtn").click(function() {
				/* alert("test") */
				$.ajax({
					url: '/heart/send',			//요청 URI
					type: 'post',				//요청 메서드
					headers: {"content-type":"application/json"},	//요청 헤더
					dataType: 'text',			//서버로부터 전송받을 데이터 타입
					data: JSON.stringify(person),	//서버로 전송할 데이터. stringify()로 직렬화필요
					success: function(result) {		//서버로부터 응답이 도착하면 호출될 함수(callback)
						person2 = JSON.parse(result)	//result는 서버가 전송한 데이터
						alert("received = "+result)
						$("#data").html("name: "+person2.name+", age: "+person2.age)
						/* $("#data").html(person2.toString()) */
					}, 
					error: function() {			//서버로부터 에러가 발생했을 때, 호출될 함수(callback)
						alert("error")
					}
				})
			})
		})
    </script>
</body>
</html>