<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="model1.board.BoardDTO" %>
<%@ page import="model1.board.BoardDAO" %>
    
<%
	request.setCharacterEncoding("utf-8");	

	String num = request.getParameter("num");
	String id = (String)session.getAttribute("UserId");
	
	String title = (String)request.getParameter("title");
	String content = (String)request.getParameter("content");
	
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = dao.selectView(num);
	
	if(title.trim().isEmpty()) title = dto.getTitle();
	if(content.trim().isEmpty()) content = dto.getContent();

	dao.updateTitle(title,num);
	dao.updateContent(content,num);
	dao.close();
	
	if(id == null | !id.equals(dto.getId())){
%>
	<script>
		alert("로그인하세요");
		location.href="LoginForm.jsp";
	</script>
<%
	}else{
%>
	<script>
		location.href="List.jsp";
	</script>
<%
	}
%>

