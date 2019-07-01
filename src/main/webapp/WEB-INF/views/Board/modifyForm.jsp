<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>글수정</title>
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
	height: 600px;
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

#fileDiv {
	margin: 20px auto;
	text-align: center;
}

.contents {
	background-color: #5378b2;
	height: 550px;
	color: #5378b2;
	margin-bottom: 20px;
}

#contents, #title {
	text-align: left;
	background-color: #dbf5c4;
	color: #5378b2;
	font-size: 20px;
	height: 80%;
	width: 90%;
	margin: 5px auto;
	padding: 0px 20px;
	border-radius: 15px;
}

#contents {
	height: 450px;
	overflow-x: auto;
	overflow-y: auto;
	text-align: left;
}

.con {
	text-align: center;
}

.info {
	color: #f2f7ff;
}

#fileImg {
	height: 50px;
	margin: 10px 0;
	color: #e5edf9;
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

#imgBtn:hover {
	border: 1px solid #e5edf9;
}

#footer {
	text-align: center;
}
</style>
</head>

<body>
	<div id=wrapper>
		<form action="modifySaveBoardProc" method="post">
			<div class="row title">
				<div class="col col-2 title">TITLE</div>
				<div class="col col-10 title">
					<div id=title contenteditable>${dto.title }</div>
					<input type="hidden" name=title id=sendTitle>
				</div>
			</div>
			<div class="row header">
				<div class="col col-3">No.</div>
				<div class="col col-3">WRITER</div>
				<div class="col col-3">DATE</div>
				<div class="col col-3">VIEW</div>
			</div>

			<div class="row header">
				<div class="col col-2 info" id=seq>${dto.seq }</div>
				<input type=hidden name=seq id=sendSeq>
				<div class="col col-2 info">${dto.writer }</div>
				<div class="col col-2 info">${dto.writedate }</div>
				<div class="col col-2 info">${dto.viewcount }</div>

			</div>

			<div class="row contents">
			<div class="col-12">
					<input type="file" id=fileImg>
					<button type=button id=imgBtn class=btn>등록</button>
				</div>
				<div id=contents contenteditable>${dto.contents }</div>
				<input type=hidden name=contents id=sendContents>
			</div>
		</form>
		<div id=footer>
			<input type="button" value="수정완료" id=modify class=btn> <input
				type="button" value="목록보기" id=list class=btn> <input
				type="button" value="홈으로" id=home class=btn>
		</div>
	</div>

	<script>
		$("#imgBtn").on("click",function(){
			var formdata = new FormData();
			formdata.append("fileImg",$("#fileImg")[0].files[0]);	
			
			$.ajax({
				url:"modifyBoardImgProc",
				type:"post",
				data:formdata,
				processData:false,
				cache:false,
				contentType:false	
			}).done(function(resp){
				console.log(resp);
				$("#contents").append("<img src=/image/modify/"+resp+" width=150px>");
			})
		})
		
		$("#modify").on(
				"click",
				function() {
					$("#sendSeq").val($("#seq").text());
					$("#sendTitle").val($("#title").html());
					$("#sendContents").val($("#contents").html());
					console.log($("#sendTitle").val() + ":"
							+ $("#sendSeq").val() + ":"
							+ $("#sendContents").val())
					$("form").submit();
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