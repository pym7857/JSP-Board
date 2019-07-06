<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 만들기 강좌</title>
</head>
<body>
	<%
		try{
			PrintWriter outter = response.getWriter();
			/* 로그인이 안된사람은 먼저 로그인을 하도록 */
			String userID = null; 
			if(session.getAttribute("userID") != null){ 	//getAttribute 는 setAttribute가 우선 선행되어야한다.
				userID = (String) session.getAttribute("userID");
			}
			if(userID == null){
				outter.println("<script> alert('로그인을 하셔야 글쓰기가 가능합니다.'); location.href = 'login.jsp'; </script>");
			} 
			int bbsID = 0;
			if(request.getParameter("bbsID") != null){	
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
			}
			if(bbsID == 0){
				outter.println("<script>");
				outter.println("alert('유효하지 않은 글입니다.')");
				outter.println("location.href = 'bbs.jsp'");
				outter.println("</script>");
			}
			Bbs bbs = new BbsDAO().getBbs(bbsID); 	//bbsID 값을가지고 해당 글을 가져온 다음(getBbs)
			if(!userID.equals(bbs.getUserID())){
				outter.println("<script>");
				outter.println("alert('글 수정 권한이 없습니다.')");
				outter.println("location.href = 'bbs.jsp'");
				outter.println("</script>");
			} else {
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.delete(bbsID); 	// delete
					if(result == -1){
						outter.println("<script> alert('글 삭제에 실패했습니다.'); history.back(); </script>");
					}
					else{	//result가 0이상의 값을 갖을때 (정상일때)
						outter.println("<script> alert('글삭제완료!'); location.href='bbs.jsp'; </script>");
					}
			}
			
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
</body>
</html>