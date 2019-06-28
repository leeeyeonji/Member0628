<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로필사진 등록</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
</head>
<body>
	<form action="joinImg" method=post enctype="multipart/form-data" id=imgForm>
		<input type="file" accept="image/*" name=fileImg id=file> 
		<input type="button" value="등록" id=fileBtn>
	</form>
	<script>
	
	$("#fileBtn").on("click",function(){
		var form = $("#imgForm")[0];
		var formdata = new FormData(form);
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
			opener.$("#img").html("<img src=/image/"+resp+" width=100px>")
			opener.$("#image").val(resp);
			self.close();
		})
	})
		
	</script>
</body>
</html>