package user;

import java.sql.Statement;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;
	private Statement stmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost/BBS?serverTimezone=UTC&characterEncoding=UTF-8";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = '" + userID + "' AND userPassword = '" + userPassword + "'";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);
			if (rs.next()) {
				return 1;
//				if(rs.getString(1).equals(userPassword)) {
//					return 1; // Login Success
//				}
//				else
//					return 0; // Login Failed
			}
			return -1; // No ID
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // DB Error
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES ('" + user.getUserID() + "', '" + user.getUserPassword() + "', '" + user.getUserName() + "', '" + user.getUserEmail() + "',1000000)";
		try {
			stmt = conn.createStatement();
			int rowsAffected = stmt.executeUpdate(SQL);
			return rowsAffected;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
    public int changePassword(String userID, String newPassword) {
        String updateSQL = "UPDATE USER SET userPassword = ? WHERE userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(updateSQL);
            pstmt.setString(1, newPassword);
            pstmt.setString(2, userID);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0; // DB 오류
    }
    
  //멤버정보 추출
  	public ArrayList<User> selectMember(String userid) {
  		String SQL = "Select * from USER WHERE userID = '" + userid + "'";
  		ArrayList<User> list = new ArrayList<User>();
  		try {
  			stmt = conn.createStatement();
  			rs = stmt.executeQuery(SQL);
  			while(rs.next()) {
  				User user = new User();
  				user.setUserName(rs.getString("username"));
  				user.setUserEmail( rs.getString("userEmail"));
				user.setUserPoint( rs.getInt("userPoint"));
  				list.add(user);
  			}
  		} catch (Exception e) {
  			e.printStackTrace();
  		}
  		return list;
  	}
  	
  	public int deleteMember(String id) {
		int result = 0;
		try {
			String SQL = "delete from USER where userID ='" + id + "'";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(SQL);		
		}catch (Exception e) {
			e.printStackTrace();
		}	
		return result;
	}
}
