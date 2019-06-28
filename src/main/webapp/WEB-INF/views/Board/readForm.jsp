<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>글읽기</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>

#wrapper {
	width: 70%;
	height: 550px;
	margin: 50px auto;
}

.title, .header, .contents, .col {
	width: 100%;
	margin: auto;
	padding: 0px;
	height: 50px;
	line-height: 40px;
	text-align: center;
}

.title, .header {
	font-size: 20px;
	font-weight: bold;
	background-color: #5378b2;
	color: #fdffed;
}

.title {
	margin: 20px 0px;
}

.header {
	height: 40px;
}

.contents {
	background-color: #5378b2;
	height: 500px;
	color: #5378b2;
	margin-bottom: 20px;
}

#contents, #title {
	text-align: left;
	background-color: #f9ffe0;
	color: #5378b2;
	font-size: 20px;
	height: 80%;
	width: 90%;
	margin: 5px auto;
	padding: 0px 20px;
	border-radius: 15px;
}

#contents {
	height: 95%;
}

.con {
	text-align: center;
}

.info {
	color: #f2f7ff;
}

#image {
	height: 50px;
	margin-top: 10px;
}

.btn {
	border: 1px solid #5378b2;
	background-color: #e5edf9;
	font-weight: bold;
	color: #5378b2;
}

.btn:hover {
	background-color: #5378b2;
	color: #e5edf9;
}

#footer{
	text-align: center;
}
</style>
</head>

<body>
	<div id=wrapper>
		<div class="row title">
			<div class="col col-2 title">TITLE</div>
			<div class="col col-10 title">
				<div id=title>${dto.title }</div>
			</div>
		</div>
		<div class="row header">
			<div class="col col-3">No.</div>
			<div class="col col-3">WRITER</div>
			<div class="col col-3">DATE</div>
			<div class="col col-3">VIEW</div>
		</div>

		<div class="row header">
			<div class="col col-2 info">${dto.seq }</div>
			<div class="col col-2 info">${dto.writer }</div>
			<div class="col col-2 info">${dto.writedate }</div>
			<div class="col col-2 info">${dto.viewcount }</div>
		</div>

		<div class="row contents">
			<div id=contents>${dto.contents }</div>
		</div>
		<div id=footer>
		<c:choose>
			<c:when test="${loginID == dto.writer }">
				<input type="button" value="수정하기" id=modify class=btn>
				<input type="button" value="삭제하기" id=delete class=btn>
			</c:when>
		</c:choose>
		<input type="button" value="목록보기" id=list class=btn> 
		<input type="button" value="홈으로" id=home class=btn>
		</div>
	</div>

	<script>
		$("#modify").on("click", function() {
			location.href = "modifyBoardProc?seq=${dto.seq}";
		})
		
		$("#delete").on("click",function(){
			location.href="dropProc?seq=${dto.seq}&writer=${dto.writer}";
		})
	

		$("#home").on("click", function() {
			location.href = "/";
		})

		$("#list").on("click", function() {
			location.href = "boardProc?page=1";
		})
	</script>
</body>
</html>