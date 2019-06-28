<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Web Chat</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<style>

div {
	box-sizing: border-box;
}

#header{
	width: 400px;
	margin: 0 auto;
	text-align: center;
	color: #52a8a8;
	font-weight: bold;
	font-size: 25px;
	margin-top:50px;
}

.container {
	width: 400px;
	height: 500px;
	margin: 0 auto;
	background-color: #e9f7f7;
	border-radius: 15px;
}

.contents {
	width: 100%;
	height: 90%;
	overflow-y: auto;
}

.control {
	width: 100%;
	height: 10%;
}

#input {
	position:relative;
	background-color:#fffff0;
	left:5px;
	bottom:5px;
	width: 78%;
	height: 90%;
	border: 2px solid #ace6e6;
	border-radius: 15px;
}

#send, #home {
position:relative;
bottom:5px;
	width: 18%;
	height: 100%;
	box-sizing: border-box;
	border: 2px solid #ace6e6;
	color:#ace6e6;
	font-weight:bold;
	font-size:15px;
	background-color: #fffff0;
	cursor: pointer;
	border-radius: 15px;
}

#home{
	height: 50px;
	position: relative;
	top: 20px;
	left: 165px;
}

#send:hover, #home:hover{
	border: 2px solid #ace6e6;
	color: #fffff0;
	background-color:#ace6e6;
	border-radius: 15px;
}

.you, .me{
	color: #2c70b8;
	font-weight: bold;
	padding:5px 10px;
}

.me{
	color: #52a8a8;
	text-align: right;
}
</style>

</head>
<body>
<div id=header>채팅방</div>
	<div class="container">
		<div class="contents"></div>

		<div class="control">
			<input type=text id="input"> <input type=button id=send
				value="보내기">
		</div>
		<input type=button value="돌아가기" id="home">
	</div>

	<script>
	
	$("#input").keypress(function(e){
		if (e.keyCode == 13) {   // 엔터 키값은 13
			 var msg = $("#input").val();
				socket.send(msg);
				$("#input").val("");
		  }
	})
	
	$("#home").on("click",function(){
		location.href="/";	
	})
	
	
		var socket = new WebSocket("ws://localhost/chat");
		// 원래라면 서버의 ip주소를 적어야함
		// 상황에 따라 버튼을 누르면 위의 코드가 실행되도록 할수도 있음
		
		// 1. 메세지가 도착했을 때
		socket.onmessage = function(evt) {
			$(".contents").append(evt.data);
		}
		
		// 2. 서버로 메세지를 보내는 경우
		$("#send").on("click",function(){
			var msg = $("#input").val();
			socket.send(msg);
			$("#input").val("");
		})
	</script>
</body>
</html>