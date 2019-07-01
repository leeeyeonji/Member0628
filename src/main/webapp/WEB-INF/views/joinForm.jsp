
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
#wrapper {
	margin: 50px 200px;
	border: 3px solid #5378b2;
	width: 500px;
	padding: 30px;
	background-color: #f9ffe0;
	color: #5378b2;
	border-radius: 10px;
}

th {
	font-size: 20px;
	padding-bottom: 20px;
}

tr, input {
	height: 30px;
}

td {
	width: 150px;
}

#imgView {
	width:100%;
	text-align: center;
	margin: 0 auto;
}

input {
	width: 200px;
}

button, #joinBtn, #upload, #fileBtn {
	background-color: #bed1e8;
	border: 1px solid #5378b2;
	color: #5378b2;
	border-radius: 10px;
	height: 40px;
	width: 90px;
	font-weight: bold;
	font-size: 15px;
}

button:hover, #joinBtn:hover, #upload:hover, #fileBtn:hover {
	cursor: pointer;
	background-color: #5378b2;
	color: #f9ffe0;
}

table {
	padding: 0px;
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

#footer {
	text-align: center;
	margin-top:20px;
}

</style>
</head>
<body>

	<div id=wrapper>
		<form action="joinProc" method="post" id=joinForm
			enctype="multipart/form-data">
			<table>
				<tr>
					<th colspan="3">회원가입</th>
				</tr>
				<tr>
					<td>아이디 :
					<td colspan="1"><input type=text id=id
						placeholder="영문,숫자 5~15자" name=id class=box>
					<td colspan=1 id=idcheck>
						<!-- <button id=idCheck flag=false>중복확인</button> --> 
						<!-- <p id=idcheck flag=false></p> -->
				</tr>
				<tr>
					<td>비밀번호 :
					<td colspan="1"><input type="password" id=pw
						placeholder="영문,숫자,~!@#$ 8~20자" required name=pw class=box>
					<td colspan="1" id=result1></td>
				</tr>
				<tr>
					<td>비밀번호 확인 :
					<td colspan="1"><input type="password" id=pwCheck name=pwCheck
						class=box flag=false>
					<td colspan="1" id=result2></td>
				</tr>
				<tr>
					<td>이름 :
					<td colspan="2"><input type="text" required id=name name=name
						class=box>
				</tr>
				<tr>
					<td>프로필사진 :</td>
					<td colspan="2"><input type="file" name="fileImg" id="fileImg">
						<input type="button" value="등록" id=fileBtn></td>
				</tr>
				<tr>
					<td>
						<div id=imgView></div> 
						<input type=hidden name=image id=image>
				</tr>
				<tr>
					<td>전화번호 :
					<td colspan="2"><input type="text"
						placeholder="-를 포함하여 띄어쓰기 없이 입력" id=phone name=phone class=box>
						<!-- 					pattern="^[0-9]{2,4}-[0-9]{3,4}-[0-9]{4}$" -->
				</tr>
				<tr>
					<td>이메일 :
					<td colspan="2"><input type="text" id=email name=email
						class=box> <!-- 						pattern="^[a-zA-Z0-9]{3,}@[a-zA-Z0-9]{3,}\.[a-zA-Z0-9]{3,}$" -->
				</tr>
				<tr>
					<td>우편번호 :
					<td colspan="2"><input type="text" id=zipcode name=zipcode
						readonly placeholder="찾기 버튼을 눌러 주소 입력" class=box>
						<button id=zipBtn type=button>찾기</button>
				</tr>
				<tr>
					<td>주소1 :
					<td colspan="2"><input type="text" id=address1 readonly
						name=addr1 class=box>
				</tr>
				<tr>
					<td>주소2 :
					<td colspan="2"><input type="text" id=address2 name=addr2
						class=box>
				</tr>
			</table>
			
			<div id=footer>
				<input type=button id=joinBtn value=회원가입>
				<button id=resetBtn type=button>다시입력</button>
				<button id=home type=button>돌아가기</button>
			</div>
		</form>
	</div>

	<script>
		$("#fileBtn").on("click",function(){				
//			window.open("joinImgProc","","width=200px,height=100px");
// 		var form = $("#imgForm")[0];
 		var formdata = new FormData();
 		formdata.append("fileImg",$("#fileImg")[0].files[0]);
// 		alert(form);
		$.ajax({
			url : "/joinImg",
			type : "post",
			enctype : "multipart/form-data",
			data : formdata,
			processData : false,
			cache : false,
			contentType : false
		}).done(function(resp) {
			console.log(resp)
			$("#imgView").html("<img src=/image/"+resp+" width=100px>")
			$("#image").val(resp);		
		})
		})
	
		
		$("#zipBtn").on("click", function searchAddress() {
							new daum.Postcode(
									{
										oncomplete : function(data) {

											var roadAddr = data.roadAddress;
											var extraRoadAddr = '';

											if (data.bname !== ''
													&& /[동|로|가]$/g
															.test(data.bname)) {
												extraRoadAddr += data.bname;
											}
											if (data.buildingName !== ''
													&& data.apartment === 'Y') {
												extraRoadAddr += (extraRoadAddr !== '' ? ', '
														+ data.buildingName
														: data.buildingName);
											}
											if (extraRoadAddr !== '') {
												extraRoadAddr = ' ('
														+ extraRoadAddr + ')';
											}

											$("#zipcode").val(data.zonecode);
											$("#address1").val(roadAddr);

											if (roadAddr !== '') {
												$("#address2").val(
														extraRoadAddr);
											} else {
												$("#address2").val('');
											}

										}
									}).open();
						})
						
			
						
		$("#id").on("input", function() {
			var id = $("#id").val();	
			var regex= /^[a-zA-Z0-9]{5,15}$/g; 
			var result = regex.exec(id);
			if(id==null || id==""){
				$("#idcheck").text("아이디를 입력해주세요.");
				$("#idcheck").css("color", "#bc3030");
		
			}else if (id!=result){
				$("#idcheck").text("바른 형식으로 입력해주세요.")
			}else {
				/* window.open("idCheck?id="+$("#id").val(), "",
				"width=350px,height=200px"); */
				$.ajax({
					url:"idCheck",
					type:"post",
					data:{
						id:$("#id").val()
						}
				}).done(function(resp){
					if (resp>0) {
						$("#idcheck").text("이미 사용중인 아이디입니다.");
						$("#idcheck").css("color", "#bc3030");
					}else {
						$("#idcheck").html("사용 가능한 아이디입니다.");
						$("#idcheck").attr("flag", "true");
						$("#idcheck").css("color", "#3066bc");					
					}
				})
			}
		});
		
		
		/* $("#fileBtn").on("click",function(){
			if($("#fileBtn").val()!=null){
				$.ajax({
					url:"upload",
					type:"post",
					data:{
						image:$("#fileBtn").val()
					}
				}).done(function (resp) {
					console.log($("#fileBtn").val());
				})
			}
		}) */
				//get 방식으로 입력값을 보내는 흉내	
// 			}else if(id==result){
// 				$.ajax({
// 					url:"idCheck.mem",
// 					type:"post",
// 					data:{
// 						id:$("#id").val()
// 					}
// 				}).done(function(result) {
// 					if (result==true) {
// 						alert(result);
// 						$("#idcheck").text("이미 사용중인 아이디입니다.");
// 						$("#idcheck").css("color", "#bc3030");
// 					} else {
// 						$("#idcheck").text("사용 가능한 아이디입니다.");
// 						$("#idcheck").css("color", "#3066bc");
// 						$("#idCheck").attr("flag", "true");
// 					}
// 				});
				
// 			}else{
// 				$("#idcheck").html("유효한 아이디만 사용가능합니다.");	
// 			}
// 		});	
			
		
		$("#pwCheck").on("input", function() {
			if ($("#pw").val() == $("#pwCheck").val()) {
				$("#result2").text("비밀번호가 일치합니다.");
				$("#result2").css("color", "#3066bc");
			} else {
				$("#result2").text("비밀번호를 정확히 입력해주세요.");
				$("#result2").css("color", "#bc3030");
			}
		})		
        $("#pw").on("input", function(){
            var pw = $("#pw").val();
            var regex2 = /^[a-zA-Z0-9!@#_]{8,20}$/g;
		    var result2 = regex2.exec(pw);
		 
            if(pw == result2){
				$("#result1").text("사용가능한 비밀번호입니다.");
				$("#result1").css("color", "#3066bc");
				$("#pwCheck").attr("flag","true");
            }else{
            	$("#result1").text("유효한 비밀번호를 입력해주세요.");
            	$("#result1").css("color", "#bc3030");
            	
            }
        })
        		
		$("#resetBtn").on("click", function(){
			$(".box").val("");
		})
		
		$("#home").on("click", function(){
			location.href="/";
		})
		
		$("#id").on("input", function(){
			$("#idCheck").attr("flag","false");
		})
		
		$("#joinBtn").on("click", function(){
			if($("#id").val()==""){
				alert("아이디를 입력해주세요.");
				return;
			}else if($("#pw").val()==""){
				alert("비밀번호를 입력해주세요.");
				return;
			}else if($("#pw").val()!=$("#pwCheck").val()){
				alert("비밀번호를 정확히 입력하세요.");
				return;
			}else if($("#idCheck").attr("flag")=="false"){
				alert("아이디 중복체크를 해주세요.");
			}else if($("#name").val()==""){
				alert("이름을 입력해주세요.");
// 			}else if($("#phone").val()==""){
// 				alert("전화번호를 입력해주세요.");
// 			}else if($("#zipcode").val()==""){
// 				alert("우편번호를 입력해주세요.")
// 			}else if($("#email").val()==""){
// 				alert("이메일을 입력해주세요.")	
 			}else if($("#pwCheck").attr("flag")=="false"){
				alert("유효한 비밀번호를 입력해주세요.");
			}else{
								
				$("#joinForm").submit();
			}
		})	
	</script>

</body>
</html>

