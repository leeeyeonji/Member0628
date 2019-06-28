<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
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

input {
	width: 250px;
}

button{
	background-color: #bed1e8;
	border: 2px solid #5378b2;
	color: #5378b2;
	border-radius: 10px;
	height: 40px;
	width:100px;
	font-weight:bold;
	font-size:15px;
	margin-top: 30px;
}

button:hover {
	cursor: pointer;
	background-color: #5378b2;
	color: #f9ffe0;
}

table {
	padding: 0 20px;
	width: 500px;
}

#btn{
	text-align: center;
}

</style>
</head>
<body>
	<div id=wrapper>
			<table>
				<tr>
					<th colspan="2"> 
					<span id=profile></span> ${loginID } 님, 환영합니다.	
					</th>
				</tr>
				<tr>
				<tr>
					<td>이름 :
					<td colspan="2">
					<input type="text" id=name name=name class=box value="${loginDTO.name }" readonly>
				</tr>
				<tr>
					<td>전화번호 :
					<td colspan="2">
					<input type="text" id=phone name=phone class=box value="${loginDTO.phone }" readonly>
				</tr>
				<tr>
					<td>이메일 :
					<td colspan="2">
					<input type="text" id=email name=email class=box value="${loginDTO.email }" readonly>
				</tr>
				<tr>
					<td>우편번호 :
					<td colspan="2">
					<input type="text" id=zipcode name=zipcode class=box value="${loginDTO.zipcode }" readonly> 					
				</tr>
				<tr>
					<td>주소1 :
					<td colspan="2">
					<input type="text" id=address1 name=addr1 class=box value="${loginDTO.addr1 }" readonly>
				</tr>
				<tr>
					<td>주소2 :
					<td colspan="2">
					<input type="text" id=address2 name=addr2 class=box value="${loginDTO.addr2 }" readonly>
				</tr>
				<tr id=btn>
					<td colspan="3">
						<button id=home type=button>돌아가기</button>
				</tr>
			</table>
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
		
	</script>
	
</body>
</html>