<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//String id = (String)session.getAttribute("UserId");
	//String fileName = request.getParameter("Sp");
	//session.invalidate();
	session.removeAttribute("UserId");
	session.removeAttribute("UserName");

	response.sendRedirect("List.jsp");
%>