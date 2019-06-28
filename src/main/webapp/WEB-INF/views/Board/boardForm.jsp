<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>Board</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
div {
	text-align: center;
}

#wrapper {
	width: 70%;
	height: 550px;
	margin: 50px auto;
}

#header, .contents, .col, .navi {
	width: 100%;
	margin: auto;
	height: 100px;
	line-height: 100px;
	text-align: center;
}

#header, .footer {
	font-size: 20px;
	font-weight: bold;
	background-color: #5378b2;
	color: #fdffed;
}

.title {
	text-align: left;
}

.title:hover {
	text-decoration: underline;
	font-weight: bold;
	cursor: pointer;
}

.contents {
	background-color: #f9ffe0;
	color: #5378b2;
	font-size: 20px;
	font-weight: bold;
	border: 0.5px dotted #6f91d1;
}

.contents:hover {
	opacity: 0.5;
}

.img {
	margin: 0px 10px 8px 0px;
	border-radius: 15px;
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

.naviBtn {
	cursor: pointer;
	margin: 0 10px;
}

.naviBtn:hover, .now {
	color: #8fffa2;
	text-decoration: underline;
}

.footer {
	line-height: 50px;
}

#buttons {
	margin-top: 20px;
}
</style>
</head>

<body>
	<div id=wrapper>
		<div class=row id=header>
			<div class="col col-1">No.</div>
			<div class="col col-7">TITLE</div>
			<div class="col col-1">WRITER</div>
			<div class="col col-2">DATE</div>
			<div class="col col-1">VIEW</div>
		</div>
		<c:forEach var="tmp" items="${list}">
			<div class="row contents">
				<div class="col col-1 seq">${tmp.seq }</div>
				<div class="col col-7 title">
					<input type=hidden class=imgCont value='${tmp.contents }'>
					<span class=image></span> ${tmp.title }
				</div>
				<div class="col col-1 writer">${tmp.writer }</div>
				<div class="col col-2 date">${tmp.writedate }</div>
				<div class="col col-1 view">${tmp.viewcount }</div>
			</div>
		</c:forEach>

		<div class="footer">
			<c:forEach var="i" begin="0" end="${size-1}">
				<c:choose>
					<c:when test="${now == navi[i] }">
					<span class="naviBtn now">${navi[i] }</span>
					</c:when>
					<c:otherwise>
						<span class=naviBtn>${navi[i] }</span>			
					</c:otherwise>		
				</c:choose>
				<input type=hidden value='${navi[i] }' class=navi>
			</c:forEach>
		</div>

		<div id=buttons>
			<input type="button" value="글쓰기" id=write class=btn> <input
				type="button" value="돌아가기" id=home class=btn>
		</div>
	</div>

	<script>
		$("#home").on("click", function() {
			location.href = "/";
		})

		$("#write").on("click", function() {
			location.href = "writeForm";
		})

		$(".title").on("click", function() {
			var seq = $(this).prev().text();
			console.log(seq);
			location.href = "readProc?seq=" + seq;
		})

		$(".imgCont")
				.each(
						function(i, item) {
							console.log(i + ":" + $(this).val());
							var img = $(this).val();
							var tmp = $(item).val();
							var regex = /(\/image.+?\.png)/;
							var result = regex.exec(tmp);
							console.log(result);
							if (result != null) {
								$(this)
										.next()
										.html(
												"<img src="+result[1]+" width=90px height=90px class=img>");
							}
						});

		$(".naviBtn").on("click", function() {
			var page = $(this).next().val();
			location.href = "boardProc?page=" + page;
		})
	</script>
</body>
</html>