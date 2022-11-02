<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "membership.MemberDTO" %>
<%@ page import = "membership.MemberDAO" %>
<%
	String userId = request.getParameter("user_id");
	String userPwd = request.getParameter("user_pw");
	
	System.out.println(userId);
	System.out.println(userPwd);
	
	MemberDAO dao = new MemberDAO();
	MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
	dao.close();

	if(memberDTO.getId() != null){
		session.setAttribute("UserId", memberDTO.getId());
		session.setAttribute("UserName", memberDTO.getName());
		response.sendRedirect("LoginForm.jsp");
	}else{
		request.setAttribute("LoginErrMsg", "로그인오류입니다.");
		request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
	}
%>
