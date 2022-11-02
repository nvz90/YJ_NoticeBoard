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
<title>글쓰기</title>
</head>
<body>
	<jsp:include page="Link.jsp" />  <!-- 공통 링크 -->
	<div class="container">
		<h2>회원게시판-글쓰기(Write)</h2>
		<form action="WriteProcess.jsp" name="WriteForm" method="post">
			<table class="box" border="1" width="90%">
				<tr>
					<td class="box" >
						<input class="title" type="text" name="title" placeholder="제목 입력">
					</td>
				</tr>
				<tr>
					<td class="box" colspan="3" height="100">
						<textarea class="content" name="content" placeholder="내용입력"></textarea>
					</td>
				</tr>
				<tr>
					<td class="box" align="center">
						<button type="button" onclick="writeFormSubmit()">완료</button>
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
<script>	
	var checkUnload = true;
	var form = document.WriteForm;
	function writeFormSubmit(){
		if(form.title.value==""){
			alert("제목 입력");
			form.title.focus();
			return false;
		}else if(form.content.value==""){
			alert("내용 입력");
			form.content.focus();
			return false;
		}
		checkUnload = false;	//form submit은 onbeforeunload 해당 X
		form.submit();
	}
	
	window.onbeforeunload=function() {	// 새로고침,뒤로가기 등 발생시 창
	if(checkUnload)
	    return true;
	}
</script>
</html>