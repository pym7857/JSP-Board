package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/** DAO(Data Access Object) ��?
 *  1. DB�� ����� �����͸� ��ȸ �ϰų� �����ϴ� ����� �����ϵ��� ���� ������Ʈ�� ���Ѵ�.
 *  2. DB�� �����ϴ� ��ü�� �������� �ϳ��� �����, ��� ���������� �� ��ü�� ȣ���ش� ����Ѵ�. 
 *  	 �̷��� Ŀ�ؼ��� �ϳ��� �������� �� Ŀ�ؼ��� ������ ��ü�� ��� DB���� ������ �ϴ°��� �ٷ� DAO ��ü�Դϴ� */
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
				if(rs.getString(1).equals(userPassword)) { 	// rs�� �����(db���� �޾ƿ� userPassword)�� �Ű������� ���� userPassword ��
					return 1; // �α��� ����
				}
				else 
					return 0; // ��й�ȣ ����ġ 
			}
			return -1; // ���̵� ����
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // ������ ���̽� ����
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
		return -1; // ������ ���̽� ����
	}
}
