<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
</head>
<body>
	<jsp:include page="Link.jsp"/>
	<div class="container">
		<h2 class="main_name">로그인페이지</h2>
		<%	
			//String Sp =  request.getServletPath().replace("/","");	// 로그아웃 할 시 현재페이지 파일명
			if(session.getAttribute("UserId") == null){
		%>
		<script>
			function validateForm(form){
				if(!form.user_id.value){
					alert('아이디를 입력하세요');
					return false;
				}
				if(form.user_pw.value==""){
					alert("패스워드를 입력하세요");
					return false;
				}
			}
		</script>
		<form class="inputForm" action="LoginProcess.jsp" method="post" name="LoginFrm" onsubmit="return validateForm(this);">
			<table>
				<tr>
					<td>
						<input class="input_login" type="text" name="user_id" placeholder="아이디"/>
					</td>
				</tr>
				<tr>
					<td>
						<input class="input_login" type="password" name="user_pw" placeholder="비밀번호"/>
					</td>
				</tr>
				<tr>
					<td>
						<span style="color : red ; font-size : 15px;">
						<%=request.getAttribute("LoginErrMsg") == null ?
						"" : request.getAttribute("LoginErrMsg")%>
						</span>
					</td>
				</tr>
				<tr>
					<td>
						<input class="input_login" value="로그인" type="submit"/>
					</td>
				</tr>
				<tr>
					<td>
						<a href="SignUp.jsp">회원가입</a>	
					</td>
				</tr>
			</table>
		</form>
		<%
			}else{
				%>
				
				<%=session.getAttribute("UserName") %> 회원님, 로그인했습니다.<br/>
				<a href="Logout.jsp">[로그아웃]</a>
				
		<%
			}
		%>
	</div>
</body>
<style>
	.inputForm{
		display: flex;
		justify-content: center;
	}
	.input_login{
		width:100%;
	}
	.main_name{
		text-align:center;
		margin-top:170px;
	}
</style>
</html>