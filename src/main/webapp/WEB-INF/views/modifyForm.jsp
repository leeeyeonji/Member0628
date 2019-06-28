<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
#wrapper {
	margin : 50px 200px;
	border: 3px solid #5378b2;
	width: 500px;
	padding: 30px;
	background-color: #f9ffe0;
	color: #5378b2;
	border-radius: 10px;
}

tr, input {
	height: 30px;
}

td {
	width: 150px;
}

input {
	width: 250px;
}

#change, #modify, #home {
	background-color: #bed1e8;
	border: 2px solid #5378b2;
	color: #5378b2;
	border-radius: 10px;
	height: 40px;
	width:80px;
	font-weight:bold;
	font-size:15px;
	margin-top: 20px;
}

#change:hover, #modify:hover, #home:hover {
	cursor: pointer;
	background-color: #5378b2;
	color: #f9ffe0;
}

table {
	padding: 0 20px;
	width: 500px;
}

#btn {
	text-align: center;
	color: #d3665d;
}

#result1, #result2, #idcheck {
	width: 200px;
	font-size: 13px;
	font-weight: bold;
}

</style>
</head>
<body>
	<div id=wrapper>
		<form action="modifyProc" method="post" id="modifyProcForm">
			<table>
				<tr>
					<th colspan="2"> 
					<span id=profile></span> ${loginID } 님, 환영합니다.	
					</th>
				</tr>
				<tr>
				<th colspan="2">
				<input type=button id=change value="수정">
				<tr></tr>
				<tr>
					<td>이름 :
					<td colspan="2">
					<input type="text" id=name name=name class=box value="${loginDTO.name }">
				</tr>
					<tr>
					<td>수정할 비밀번호 :
					<td colspan="2">
					<input type="password" id=pw name=pw class=box value="${loginDTO.pw }">
				</tr>
				<tr>
					<td>전화번호 :
					<td colspan="2">
					<input type="text" id=phone name=phone class=box value="${loginDTO.phone }">
				</tr>
				<tr>
					<td>이메일 :
					<td colspan="2">
					<input type="text" id=email name=email class=box value="${loginDTO.email }">
				</tr>
				<tr>
					<td>우편번호 :
					<td colspan="2">
					<input type="text" id=zipcode name=zipcode class=box value="${loginDTO.zipcode }"> 					
				</tr>
				<tr>
					<td>주소1 :
					<td colspan="2">
					<input type="text" id=address1 name=addr1 class=box value="${loginDTO.addr1 }">
				</tr>
				<tr>
					<td>주소2 :
					<td colspan="2">
					<input type="text" id=address2 name=addr2 class=box value="${loginDTO.addr2 }">
				</tr>
				<tr id=btn>
					<td colspan="3">
						<input type=button id=modify value="수정하기">
						<input type=button id=home value="돌아가기">
				</tr>
			</table>
			</form>
	</div>

	<script>
		
		$("#home").on("click", function(){
			location.href="/";
		})	
		
		$("#change").on("click", function(){
			window.name='tmp';
			window.open("modifyImg","","width=300px,height=80px"); 
		})
		
		$("#profile").html("<img src=/image/${loginDTO.image} width=100px>");
		
		$("#modify").on("click", function(){
			$("#modifyProcForm").submit();
		})
		
	</script>
	
</body>
</html>