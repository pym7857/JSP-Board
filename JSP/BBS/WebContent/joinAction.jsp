<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 만들기 강좌</title>
</head>
<body>
	<%
		try{
			/* 이미 로그인된사람은 다시 회원가입하지 못하도록 하는과정 (세션이용) */
			String userID = null;
			if(session.getAttribute("userID") != null){ //getAttribute 는 setAttribute가 우선 선행되어야한다.
				userID = (String) session.getAttribute("userID");
			}
			if(userID != null){
				PrintWriter outter = response.getWriter();
				outter.println("<script> alert('이미 로그인이 되어있습니다.'); location.href = 'main.jsp'; </script>");
			}
			
			/* 로직 */
			if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || 
					user.getUserGender() == null || user.getUserEmail() == null)
			{
				PrintWriter outter = response.getWriter();
				outter.println("<script> alert('입력이 안된 부분이 있습니다.'); history.back(); </script>");
			} 
			else{
				UserDAO userDAO = new UserDAO();
				int result = userDAO.join(user);
			
				if(result == -1){
					PrintWriter outter = response.getWriter();
					outter.println("<script> alert('중복되는 아이디값입니다.(데이터베이스 오류)'); history.back(); </script>");
				}
				else{
					session.setAttribute("userID", user.getUserID());
					PrintWriter outter = response.getWriter();
					outter.println("<script> alert('회원가입완료!.'); location.href='main.jsp'; </script>");
				}
			}
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
</body>
</html>