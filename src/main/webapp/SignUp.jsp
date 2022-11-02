<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body style=background-color:#F0F0F0;>
	<jsp:include page="Link.jsp" />  <!-- 공통 링크 -->
	<div class="container">
	<h2 align="center">회원가입</h2>
	<script>
		function validateForm(form){
			if(!form.id.value){
				alert('아이디를 입력하세요');
				return false;
			}
			if(form.pw.value==""){
				alert("패스워드를 입력하세요");
				return false;
			}
			if(form.name.value==""){
				alert("활동명을 입력하세요");
				return false;
			}
		}			
	</script>
	<form class="inputForm" name="SignUpForm" action="SignUpProcess.jsp" onsubmit="return validateForm(this);">
		<table>
				<tr>
					<th>아이디</th>
				</tr>
				<tr>
					<td>
						<input type="text" id = "id" name="id"/>
					</td>
					<td>
						<span style="color : red ; font-size : 15px;">
						<%=request.getAttribute("idChkMsg") == null ?
						"" : request.getAttribute("idChkMsg")%>
						</span>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
				</tr>
				<tr>
					<td><input type="password" name="pw"></td>
				</tr>
				
				<tr>
					<th>활동명</th>
				</tr>
				<tr>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>
						<input type="submit" name="submit">
					</td>
				</tr>
			
		</table>
	</form>
	</div> 
</body>
<style>
	.inputForm{
		display: flex;
		justify-content: center;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.js">
	function checkId(){//
		//Ajax를 사용하여 실시간 아이디 체크
		//페이지 새로고침 없이 서버에 요청
		//서버로부터 데이터를 받고 작업을 수행
		// 아직 쓸줄 모름
	    var id = $('#id').val)();
	    $.ajax({
	        url:'/idDuplChk.do',
	        type:'post',
	        data:{id:id},
	        success:function(data){
	            if($.trim(data)==0){
	                $('#chkMsg').html("
	사용가능
	
	");                
	            }else{
	                $('#chkMsg').html("
	사용불가
	
	");
	            }
	        },
	        error:function(){
	                alert("에러입니다");
	        }
	    });
	};
</script>
</html>