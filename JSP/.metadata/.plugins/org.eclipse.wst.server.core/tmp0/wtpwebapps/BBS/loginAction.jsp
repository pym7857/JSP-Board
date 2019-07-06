<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 만들기 강좌</title>
</head>
<body>
	<%
		try{
			/* 이미 로그인된사람은 다시 로그인하지 못하도록 하는과정 (세션이용) */
			String userID = null;
			if(session.getAttribute("userID") != null){ 	//getAttribute 는 setAttribute가 우선 선행되어야한다.
				userID = (String) session.getAttribute("userID");
			}
			if(userID != null){
				PrintWriter outter = response.getWriter();
				outter.println("<script> alert('이미 로그인이 되어있습니다.'); location.href = 'main.jsp'; </script>");
			}
			
			/* 로직 */
			UserDAO userDAO = new UserDAO();
			int result = userDAO.login(user.getUserID(), user.getUserPassword());	
			PrintWriter outter = response.getWriter();
			if(result == 1){
				session.setAttribute("userID", user.getUserID());			// session 을 setAttribute
				outter.println("<script> alert('로그인완료!'); location.href = 'main.jsp'; </script>");
			}
			else if(result == 0){
				outter.println("<script> alert('비밀번호가 틀립니다.'); history.back(); </script>");
			}
			else if(result == -1){
				outter.println("<script> alert('존재하지 않는 아이디입니다.'); history.back(); </script>");
			}
			else if(result == -2){
				outter.println("<script> alert('데이터베이스 오류가 나타났습니다.'); history.back(); </script>");
			}
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
</body>
</html>