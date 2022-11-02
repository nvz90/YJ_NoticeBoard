<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model1.board.BoardDAO" %>
<%@ page import="model1.board.BoardDTO" %>
    
<%
	request.setCharacterEncoding("utf-8");	
	BoardDAO dao = new BoardDAO();
	
	String id = (String)session.getAttribute("UserId");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String name = (String)session.getAttribute("UserName");	
	dao.insertWrite(id, title, content, name);	//검증은 일단 생략
	dao.close();
	response.sendRedirect("List.jsp");
%>