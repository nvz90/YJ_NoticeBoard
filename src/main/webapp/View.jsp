<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model1.board.BoardDTO" %>
<%@ page import="model1.board.BoardDAO" %>

<%
	String num = request.getParameter("num");
	
	BoardDAO dao = new BoardDAO();
	dao.updateVisitCount(num);	//조회수 +1
	
	BoardDTO dto = dao.selectView(num);
	dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 게시판</title>
</head>
<body>
	<jsp:include page="Link.jsp"/>
	<div class="container">
		<h2>회원게시판-상세보기(view)</h2>
		<form name="ListForm">
		<input type="hidden" name="num" value="<%=num%>"/>
		<table border="1" width="90%">
			<tr>
				<td>번호</td>
				<td><%=dto.getNum() %></td>
				<td>작성자</td>
				<td><%=dto.getName() %></td>	
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=dto.getPostdate() %></td>
				<td>조회수</td>
				<td><%=dto.getVisitcount() %></td>	
			</tr>
			<tr>
				<td>제목</td>
				<td colspan="3"><%=dto.getTitle() %></td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3" height="500"><%=dto.getContent().replace("\r\n", "<br/>") %></td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<%
						if(session.getAttribute("UserId") != null 
						&& session.getAttribute("UserId").toString().equals(dto.getId())){
					%>
					<button type="button" onclick="location.href='Edit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
					<button type="button" onclick="DeletePost()">삭제하기</button>
					<%
						}
					%>
					<button type="button" onclick="location.href='List.jsp';">목록하기</button>
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
<script>
	function DeletePost(){
		if(confirm("정말로 삭제하겠습니까?")){
			var form = document.ListForm;
			form.method ="post";
			form.action="DeleteProcess.jsp?num=<%=dto.getNum()%>";
			form.submit();
		}
	}
</script>
</html>