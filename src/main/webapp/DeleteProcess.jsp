<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model1.board.BoardDTO" %>
<%@ page import="model1.board.BoardDAO" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String num = request.getParameter("num");
	
	System.out.println(num);
	
	BoardDAO dao = new BoardDAO();
	BoardDTO dto = dao.selectView(num);
	
	dao.deleteBoard(num);
	
	response.sendRedirect("List.jsp");
	
%>