package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/** DAO(Data Access Object) 란?
 *  1. DB를 사용해 데이터를 조회 하거나 조작하는 기능을 전담하도록 만든 오브젝트를 말한다.
 *  2. DB에 접속하는 객체를 전용으로 하나만 만들고, 모든 페이지에서 그 객체를 호출해다 사용한다. 
 *  	 이렇게 커넥션을 하나만 가져오고 그 커넥션을 가져온 객체가 모든 DB와의 연결을 하는것이 바로 DAO 객체입니다 */
public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?useSSL=false";
			String dbID = "root";
			String dbPassword = "1562";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) { 	// rs의 결과값(db에서 받아온 userPassword)와 매개변수로 받은 userPassword 비교
					return 1; // 로그인 성공
				}
				else 
					return 0; // 비밀번호 불일치 
			}
			return -1; // 아이디가 없음
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터 베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터 베이스 오류
	}
}
