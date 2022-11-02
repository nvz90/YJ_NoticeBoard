<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="membership.MemberDAO" %>
<%@ page import="membership.MemberDTO" %>

<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	
	MemberDAO dao = new MemberDAO();
	
	boolean checkId = dao.checkId(id); // 아이디 같으면 true

	if(!checkId){
		dao.insertMember(id, pw, name);
		dao.close();
		response.sendRedirect("LoginForm.jsp");
	}else{
		dao.close();
		System.out.println("@@@");
		request.setAttribute("idChkMsg","아이디 중복");
		request.getRequestDispatcher("SignUp.jsp").forward(request, response);
	}
%>