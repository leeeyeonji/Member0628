<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
</head>
<body>
		<form method="post" enctype="multypart/form-data" id=modifyForm>
		<input type=file name="modifyImg">
		<input type=button id=btn value='등록'>
		</form>
	<script>
		$("#btn").on("click",function(){
			var form = $("#modifyForm")[0];
			var formdata = new FormData(form);
			$.ajax({
				type:"post",
				enctype:"multipart/form-data",
				url:"modifyImgProc",
				data:formdata,
				cache: false,
				processData: false,
				contentType: false
			}).done(function(resp){
				opener.$("#profile").html("<img src=/image/"+resp+" width=100px>");
				self.close();
			})
		})
	</script>
</body>
</html>