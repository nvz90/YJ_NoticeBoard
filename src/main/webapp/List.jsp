<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="model1.board.BoardDAO"%>
<%@ page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// DAO를 생성해 DB에 연결
	BoardDAO dao = new BoardDAO();
	
	// 사용자가 입력한 검색 조건을 Map에 저장
	Map<String, Object> param = new HashMap<String, Object>(); 
	
	//##############검색조건
	String searchField = request.getParameter("searchField"); //검색조건 받음
	String searchWord = request.getParameter("searchWord"); //검색단어 받음

	//System.out.println("before"+searchField);
	//System.out.println("before"+searchWord);
	
	if(searchWord != null) {
		session.setAttribute("searchField", searchField);
		session.setAttribute("searchWord", searchWord);
	    param.put("searchField", searchField);
	    param.put("searchWord", searchWord);
	}else{
		searchField = (String)session.getAttribute("searchField");
		searchWord = (String)session.getAttribute("searchWord");
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	//System.out.println("after"+searchField);
	//System.out.println("after"+searchWord);
	
	//@@@@@@@@@@@@@@@ 페이징
	String a = request.getParameter("pageNum");	//페이지번호 받음
	String b = request.getParameter("boardNum"); //출력할 게시물 개수 받음
	
	if(b != null){	//b에 게시물 수가 담겨져있다면
		session.setAttribute("boardNum",b);	//세션에 저장
	}else{
		b=(String)session.getAttribute("boardNum");	//b에 세션값넣음
	}
	
	int pageNum = Integer.parseInt(a == null ? a = "1" : a);
	String boardNum = b == null ? b = "10" : (boardNum = b);
	//System.out.println(boardNum);
	//int boardNum = Integer.parseInt(b == null ? b = "10" : b);
	
	
	// @@@@@@@@@@@@@@게시물 출력 부분
	int totalCount = dao.selectCount(param);  // 게시물 수 확인
	int boardCount = totalCount;
	List<BoardDTO> boardLists = dao.boardPaging(param,pageNum,boardNum);  // 게시물 목록 받기
	
	dao.close();  // DB 연결 닫기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<body>
    <jsp:include page="Link.jsp" />  <!-- 공통 링크 -->
	<div class="container">
		<h2>목록 보기(List)</h2>
	    <!-- 검색폼 --> 
	    <form method="get">  
		    <table width="90%">
			    <tr>
			        <td align="right">
			            <select name="searchField">
			                <option value="title">제목</option> 
			                <option value="content">내용</option>
			                <option value="name">작성자</option>
			            </select>
			            <input type="text" name="searchWord" />
			            <input type="submit" value="검색하기" />
			        </td>
			    </tr>   
		    </table>
	    </form>
	    <!-- 게시물 목록 테이블(표) --> 
	    <table class="table" width="90%" style=text-align:center;>
	        <!-- 각 칼럼의 이름 --> 
	        <tr>
	            <th width="10%">번호</th>
	            <th width="50%">제목</th>
	            <th width="15%">작성자</th>
	            <th width="10%">조회수</th>
	            <th width="15%">작성일</th>
	        </tr>
	        <!-- 목록의 내용 --> 
	<%
		if (boardLists.isEmpty()) {
		    // 게시물이 하나도 없을 때 
	%>
	        <tr>
	            <td colspan="5" align="center">
	                등록된 게시물이 없습니다^^*
	            </td>
	        </tr>
	<%
		}
		else {
		    // 게시물이 있을 때 
		    int virtualNum = 0;  // 화면상에서의 게시물 번호
		    int quotient = boardCount/(Integer.parseInt(boardNum));	// 페이지 개수
		    int remainder = (boardCount % Integer.parseInt(boardNum)) > 0 ? quotient+=1 : 0; // 나머지있으면 1추가
		  	virtualNum = boardCount - ((pageNum-1)*(Integer.parseInt(boardNum))); // 현재 게시판 레코드의 토탈 갯수 - ((현재 페이지-1) * 한 화면에 보여질 레코드의 갯수)
		  	
		  	if(boardCount <= 10) virtualNum+=1;
		    for (BoardDTO dto : boardLists){
		    	virtualNum--;
	%>		
	        <tr align="center">
	            <td><%= virtualNum %></td>  <!--게시물 번호-->
	            <td align="left">  <!--제목(+ 하이퍼링크)-->
	                <a href="View.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a> 
	            </td>
	            <td align="center"><%= dto.getName() %></td>          <!--작성자-->
	            <td align="center"><%= dto.getVisitcount() %></td>  <!--조회수-->
	            <td align="center"><%= dto.getPostdate() %></td>    <!--작성일-->
	        </tr>
	<%
	   		}
		}
	%>
	    </table>
	    <table align="center">	<!-- 페이지번호 -->
	    	<tr>
			    <%
				    int quotient = boardCount/(Integer.parseInt(boardNum));	// 페이지 개수 (몫)
				    int remainder = (boardCount % Integer.parseInt(boardNum)) > 0 ? quotient+=1 : 0; // 나머지있으면 1추가
					int pageNumber = 0;
					
			    	for(int i=0; i<quotient; i++){
						pageNumber++; 
			    %>    	
		    		<td>
		    			<a href="List.jsp?pageNum=<%=pageNumber%>"><%=pageNumber%></a>
		    		</td>
		    	<%
			    	}
		    	%>
	    	</tr>
	    </table>
	    <form method="get" action="List.jsp?pageNum="<%=0%>>
	    	<table width="90%">
	    		<tr>
	    			<td align="right">
	    				<select name="boardNum">
	    					<option value="10">10</option>
	    					<option value="15">15</option>
	    					<option value="30">30</option>
	    					<option value="50">50</option>
	    				</select>
	    				<input type="submit"/>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	     <!--목록 하단의 [글쓰기] 버튼-->
	    <form name="WriteForm">
	    	<table width="90%">
	        <tr align="right">
	            <td><button type="button" onclick="WritePost()">글쓰기</button></td>
	        </tr>
	    	</table>
	    </form>
	</div>
</body>
<script>
	function WritePost(){	// 접속한 사람만 글쓰기 권한 부여
		var form = document.WriteForm;
		<%
			if(session.getAttribute("UserId") != null ){	// 세션에 id값 체크
		%>
			form.method="post";
			form.action="Write.jsp";
			form.submit();
		<%
			}else{
		%>
			alert("로그인 먼저");
			form.method="post";
			form.action="LoginForm.jsp";
			form.submit();
		<%
			}
		%>
	}
</script>
</html>
