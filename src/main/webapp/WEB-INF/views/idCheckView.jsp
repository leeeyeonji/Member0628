<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<style>
#wrapper {
	border: 1px solid #d3665d;
	width: 300px;
	padding: 10px;
	background-color: #f2d7d7;
	color: #d8695f;
	text-align: center;
}

button {
	background-color: #fce1df;
	border: 1px solid #d8695f;
	color: #d8695f;
	text-align: center;
}

button:hover {
	cursor: pointer;
	background-color: #f86d61;
	color: white;
}
</style>
</head>
<body>

	<div id=wrapper>
		<div id=result></div>
		<br>
		<button id="close">닫기</button>
	</div>

	<script>
		if (${result}>0) {
			$("#result").html("이미 사용중인 아이디입니다.");
			opener.$("#id").val("");
		}else {
			$("#result").html("사용 가능한 아이디입니다.");
			opener.$("#idCheck").attr("flag", "true");
		}

		$("#close").on("click", function() {
			window.close();
		})
	</script>
</body>
</html>

