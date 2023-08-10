package reserv;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


public class reservDAO {

	private Connection conn;
	private ResultSet rs;
	
	public reservDAO() {
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
	
	//예약내역 조회
	public ArrayList<reserv> Listreserv(String userid) {
		String SQL = "Select * from reserv WHERE userID = '" + userid + "'";
		ArrayList<reserv> list = new ArrayList<reserv>();
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);
			while(rs.next()) {
				reserv reserv1 = new reserv();
				reserv1.setid(rs.getInt("id"));
				reserv1.setuserID(rs.getString("userID"));
				reserv1.setreservID(rs.getString("reservID"));
				reserv1.settitle(rs.getString("title"));
				reserv1.setprice(rs.getInt("price"));
				reserv1.setcheckin(rs.getString("checkin"));
				reserv1.setcheckout(rs.getString("checkout"));
				list.add(reserv1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//예약취소
	public int deleteReserv( String id ) {
		int result = 0;
		try {
			String SQL = "delete from reserv where reservID ='" + id + "'";
			Statement  stmt = conn.createStatement();
			result = stmt.executeUpdate(SQL);		
		}catch (Exception e) {
			e.printStackTrace();
		}	
		return result;
	}
	
}