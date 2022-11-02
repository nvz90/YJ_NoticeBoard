<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model1.board.BoardDAO"%>
<%@ page import="model1.board.BoardDTO"%>
<!DOCTYPE html>
<html>
<!-- 접속한 사람만 글쓰기 권한 부여 -->
<% if(session.getAttribute("UserId") == null ){	// 세션에 id값 체크 %>
	<script>alert("로그인 먼저");
		var link = 'LoginForm.jsp';
		location.href=link;
	</script>
<%
	}
%>		
<head>
<meta charset="UTF-8">
<title>회원 게시판</title>
</head>
<body>
	<%
		String num = request.getParameter("num");
	%>
	<jsp:include page="Link.jsp" />  <!-- 공통 링크 -->
	<div class="container">
		<h2>회원게시판-수정하기(Edit)</h2>
		<form action="EditProcess.jsp?num=<%=num %>" name="EditForm" method="post">
		<table class="box" border="1" width="90%">
			<tr>
				<td class="box" >
					<input class="title" type="text" name="title" placeholder="수정할 제목 입력">
				</td>
			</tr>
			
			<tr>
				<td class="box" colspan="3" height="100">
					<textarea class="content" name="content" placeholder="수정할 내용입력"></textarea>
				</td>
			</tr>
			<tr>
				<td class="box" align="center">
					<button type="submit">완료</button>
				</td>
			
			</tr>
		</table>
	</form>
	</div>
</body>

<style>
	.title{
		width: 100%;
		height: 100%;
		outline:none;
		margin-bottom : 20px;
		
		font-size: 15px ;
		font-family: 돋움,arial;
		font-family:Verdana;
	}
	.content{
		width : 100%;
		height: 400px;
		outline:none;
		margin-bottom : 20px;
		
		font-size: 20px ;
		font-family: 돋움,arial;
		font-family:Verdana;
		
	}
	.box{
		border:none;
	}
</style>
</html>