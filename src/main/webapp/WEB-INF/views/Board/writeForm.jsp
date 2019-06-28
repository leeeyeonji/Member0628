<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
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

#header, .contents, .col {
	width: 100%;
	margin: 0 auto;
	padding: 0px;
	height: 50px;
	line-height: 40px;
	text-align: center;
}

#header {
	font-size: 20px;
	font-weight: bold;
	background-color: #5378b2;
	color: #fdffed;
	height: 70px;
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
	border-radius:15px;
	color: #5378b2;
	height: 80%;
	width: 96%;
	margin: 20px auto;
	border: 0px;
	font-size: 20px;
	padding: 10px;
}

#head{
	margin: 20px auto;
}
#contents {
	text-align: left;
	margin: 10px auto;
}

#image {
	height: 50px;
	margin-top: 10px;
	color:#f9ffe0;
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
		<form action="writeProc" method="post" id=writeForm>
			<div class=row id=header>
				<div class="col col-2" id=head>TITLE</div>
				<form action="writeProc" method="post">
					<div class="col col-10 title">
						<input type=text id=title name=title>
					</div>
					<input type=hidden id=realContents name=contents>
				</form>
			</div>

			<div class="row contents">
				<div class="col col-12 contents">
					<input type=file id=image accept="image/*" name=image> <input
						type="button" value="등록" id=imgbtn class=btn>
					<div contenteditable=true id=contents></div>
				</div>
			</div>
		</form>
		<div id=footer>
			<input type="button" value="글쓰기" id=write class=btn> 
			<input type="button" value="목록보기" id=list class=btn> 
			<input type="button" value="홈으로" id=home class=btn>
		</div>
	</div>

	<script>
		$("#imgbtn")
				.on(
						"click",
						function() {
							var formdata = new FormData();
							formdata.append("image", $("#image")[0].files[0]);
							$
									.ajax({
										url : "writeImgProc",
										type : "post",
										data : formdata,
										processData : false,
										cache : false,
										contentType : false
									})
									.done(
											function(resp) {
												console.log(resp);
												$("#contents")
														.append(
																"<img src=/image/write/"+resp+" width=200px>");
											})
						})

		$("#write").on("click", function() {
			if ($("#title").val() == "" || $("#contents").html() == "") {
				alert("제목 또는 내용을 입력해주세요.")
			} else {
				$("#realContents").val($("#contents").html());
				$("form").submit();
			}
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