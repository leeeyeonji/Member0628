<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>홈</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<style>
div {
	margin: 50px 200px;
	border: 1px solid #5378b2;
	width: 400px;
	padding: 20px;
	background-color: #bed1e8;
	color: #5378b2;
	border-radius: 10px;
}

tr, input {
	border: 1px solid #5378b2;
	height: 30px;
	margin: 10px;
	padding-left: 10px;
	font-size: 15px;
	font-weight: bold;
}

input {
	background-color: #f9ffe0;
	color: #5378b2;
	border-radius: 10px;
}

button {
	background-color: #f9ffe0;
	border: 2px solid #5378b2;
	color: #5378b2;
	border-radius: 10px;
	height: 30px;
}

button:hover {
	cursor: pointer;
	background-color: #5378b2;
	color: #f9ffe0;
}

table {
	text-align: center;
	padding: 0px;
	width: 400px;
}

th {
	font-size: 20px;
	font-style: italic;
	padding-bottom: 20px;
}

td {
	padding-bottom: 10px;
}
</style>
</head>

<body>
	<c:choose>
		<c:when test="${loginID != null }">
			<!-- 	로그인 성공상황 -->
			<div>
				<table>
					<tr>
						<th colspan="3">♡ <%=session.getAttribute("loginID")%> 님,
							환영합니다 ♡
					</tr>
					<tr>
						<td>
							<button id="board">게시판</button>
							<button id="webChat">채팅</button>
							<button id="modify">정보수정</button>
							<button id="myPage">마이페이지</button>
						</td>
					</tr>
					<tr>
						<td>
							<button id="dropBtn">회원탈퇴</button>
							<button id="logoutBtn">로그아웃</button>
					</tr>
				</table>
			</div>
		</c:when>

		<c:otherwise>
			<!-- 	로그인 실패시 다시 로그인폼 -->
			<form action="login" method="post" id=loginBox>
				<div>
					<table>
						<tr>
							<th colspan="2">회원 로그인</th>
						</tr>
						<tr>

							<td>아이디 :</td>
							<td><input type="text" name="id" id=id></td>
						</tr>
						<tr>
							<td>비밀번호 :</td>
							<td><input type="password" name="pw" id=pw></td>
						</tr>

						<tr>
							<td colspan="2">
								<button id=login type=button>로그인</button>
								<button id=join type=button>회원가입</button> <a
								id="kakao-login-btn"></a> <a
								href="http://developers.kakao.com/logout"></a>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</c:otherwise>
	</c:choose>

	<script>
	
	$("#webChat").on("click",function(){
		location.href="webChat";
	})
	
	if(${loginID == null }){
     // 사용할 앱의 JavaScript 키를 설정해 주세요.
     Kakao.init('c9678b999807ca654cc053907cff1aea');
     // 카카오 로그인 버튼을 생성합니다.
     Kakao.Auth.createLoginButton({
       container: '#kakao-login-btn',
       success: function(authObj) {
        console.log(JSON.stringify(authObj));
       },
       fail: function(err) {
    	   console.log(JSON.stringify(err));
       }
     });
	}
	
		$("#pw").keypress(function (e) {
			if(e.keyCode == 13){
					if ($("#id").val() == "" || $("#pw").val() == "") {
						alert("아이디와 비밀번호를 모두 입력해주세요.")
					} else {
						$("#loginBox").submit();
					}
			}
		})
	
			$("#login").on("click", function() {
					if ($("#id").val() == "" || $("#pw").val() == "") {
						alert("아이디와 비밀번호를 모두 입력해주세요.")
					} else {
						$("#loginBox").submit();
					}
				})

		$("#join").on("click", function() {
			location.href = "joinForm";
		})

		$("#logoutBtn").on("click", function() {
			alert("로그아웃!")
			location.href = "logout";
		})

		$("#dropBtn").on("click", function() {
			location.href = "dropCheckView.jsp";
		})

		$("#myPage").on("click", function() {
			location.href = "myPageForm";
		})

		$("#modify").on("click", function() {
			location.href = "modifyForm";
		})

		$("#board").on("click", function() {
			location.href = "boardProc?page=1";

		})
	</script>
</body>
</html>


