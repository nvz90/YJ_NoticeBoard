<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel = "stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Link</title>
</head>
<style>
	.a_text{
		color:white;
		font-weight:bold;
	}
</style>
<body>
	<table border="1" width="90%" align="center" style=background-color:#343a40;>
		<tr>
			<td align="center">	
				<%if(session.getAttribute("UserId") == null){ %>
					<a href="LoginForm.jsp" class="a_text">로그인</a>
				<%}else{ %>
					<a href="Logout.jsp" class="a_text">로그아웃</a>
				<%} %>
					&nbsp;&nbsp;&nbsp;
					<a href="List.jsp" class="a_text">게시판</a>
			</td>
		</tr>
	</table>
</body>
</html>