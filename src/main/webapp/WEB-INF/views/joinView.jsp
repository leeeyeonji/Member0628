<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Join View</title>
<script>
if(${result} > 0){
	alert("회원가입을 축하드립니다.");
	location.href="/";
}else{
	alert("회원가입에 실패하였습니다.");
	location.href="joinForm";
}
</script>
</head>
<body>

</body>
</html>