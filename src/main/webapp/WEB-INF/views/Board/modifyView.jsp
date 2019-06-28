<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글수정</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
</head>
<body>
	<script>
		if(${result}>0){
			alert("글이 수정되었습니다.");
			location.href = "readProc?seq="+${seq};
		}else{
			alert("글수정에 실패하였습니다.");
		}
	</script>
</body>
</html>