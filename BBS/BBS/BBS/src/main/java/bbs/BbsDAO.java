package bbs;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	private ResultSet rs2;
	
	public BbsDAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB ERROR
	}
	
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);
			if(rs.next()) {
				return rs.getInt(1) + 1; // 첫 번째 게시물 + 1
			}
			return 1; // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERROR
	}
	
	public int write(String bbsTitle, String userID, String bbsContent, String fileName, String fileRealName) {
			
		String SQL = "INSERT INTO BBS VALUES (" + getNext() + ", '" + bbsTitle + "', '" + userID + "', '" + getDate() + "', '" + bbsContent + "', 1, '"+fileName+"', '" +fileRealName+"')";
		try {
			Statement stmt = conn.createStatement();
			int rowsAffected = stmt.executeUpdate(SQL);
	        return rowsAffected;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERROR
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < " + (getNext() - (pageNumber - 1) * 10) + " AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = '" + bbsID + "'";
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent, String fileName, String fileRealName) {
		String SQL = "UPDATE BBS SET bbsTitle = '" + bbsTitle + "', bbsContent = '" + bbsContent + "', fileName = '" + fileName + "', fileRealName = '" + fileRealName + "' WHERE bbsID = " + bbsID + ";";
		try {
			Statement stmt = conn.createStatement();
			int rowsAffected = stmt.executeUpdate(SQL);
	        return rowsAffected;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERROR
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = " + bbsID;
		try {
			Statement stmt = conn.createStatement();
			int rowsAffected = stmt.executeUpdate(SQL);
	        return rowsAffected;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ERROR
	}
	
	public ArrayList<Bbs> getList(int pageNumber, String orderBy, String orderDir) {
	    String SQL = "SELECT * FROM BBS WHERE bbsID < " + (getNext() - (pageNumber - 1) * 10) + " AND bbsAvailable = 1 ORDER BY " + orderBy + " " + orderDir + " LIMIT 10";
	    ArrayList<Bbs> list = new ArrayList<Bbs>();
	    try {
	        Statement stmt = conn.createStatement();
	        rs = stmt.executeQuery(SQL);
	        while (rs.next()) {
	            Bbs bbs = new Bbs();
	            bbs.setBbsID(rs.getInt(1));
	            bbs.setBbsTitle(rs.getString(2));
	            bbs.setUserID(rs.getString(3));
	            bbs.setBbsDate(rs.getString(4));
	            bbs.setBbsContent(rs.getString(5));
	            bbs.setBbsAvailable(rs.getInt(6));
	            list.add(bbs);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
   public ArrayList<Bbs> getSearch(int pageNumber, String orderBy, String orderDir, String searchField, String searchText, HttpServletResponse response) throws IOException {//특정한 리스트를 받아서 반환
	      ArrayList<Bbs> list = new ArrayList<Bbs>();
	      String SQL ="SELECT * FROM BBS WHERE bbsID < " + (getSearchNext(searchField, searchText) - (pageNumber - 1) * 10) + " AND " + searchField.trim();
	       try {
	           SQL +=" LIKE '%"+searchText.trim()+"%' AND bbsAvailable = 1 ORDER BY " + orderBy + " " + orderDir + " LIMIT 10";
	       
	           Statement stmt = conn.createStatement();
	           rs = stmt.executeQuery(SQL);
	           while (rs.next()) {
	               Bbs bbs = new Bbs();
	               bbs.setBbsID(rs.getInt(1));
	               bbs.setBbsTitle(rs.getString(2));
	               bbs.setUserID(rs.getString(3));
	               bbs.setBbsDate(rs.getString(4));
	               bbs.setBbsContent(rs.getString(5));
	               bbs.setBbsAvailable(rs.getInt(6));
	               list.add(bbs);
	              }

	       } catch (Exception e) {
	              e.printStackTrace();
	              response.setContentType("text/plain");
	             response.setCharacterEncoding("UTF-8");
	             response.getWriter().write("SQL Error: " + e.getMessage());
	       }
	       return list;
	   }
   
   public int getSearchNext(String searchField, String searchText) {
      String SQL = "SELECT bbsID FROM BBS WHERE " + searchField.trim() +" LIKE '%" + searchText.trim()+ "%' ORDER BY bbsID DESC";
      try {
         Statement stmt = conn.createStatement();
         rs = stmt.executeQuery(SQL);
         if(rs.next()) {
            return rs.getInt(1) + 1; // 첫 번째 게시물 + 1
         }
         return 1; // 첫 번째 게시물인 경우
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1; // DB ERROR
   }
   
   public boolean searchNextPage(int pageNumber, String orderBy, String orderDir, String searchField, String searchText) {
      List<String> names = new ArrayList<>();
      String SQL2 = "SELECT COUNT(*) FROM BBS WHERE " + searchField.trim();
      String SQL = "SELECT * FROM BBS WHERE bbsID < " + (getSearchNext(searchField, searchText) - (pageNumber - 1) * 10) + " AND " + searchField.trim();
      try {
        SQL += " LIKE '%"+searchText.trim()+"%' AND bbsAvailable = 1 ORDER BY " + orderBy + " " + orderDir + " LIMIT 10";
        SQL2 += " LIKE '%"+searchText.trim()+"%' AND bbsAvailable = 1";
        Statement stmt = conn.createStatement();
        Statement stmt2 = conn.createStatement();
        rs = stmt.executeQuery(SQL);
        rs2 = stmt2.executeQuery(SQL2);
        while(rs2.next()) {
           String name  = rs2.getString("count(*)");
           names.add(name);
        }
        
        if (Integer.parseInt(names.get(0)) > 10 && rs.next()) {
           return true;
        }
     } catch (Exception e) {
        e.printStackTrace();
     }
     return false;
   }
   
   public ArrayList<String> getFileList(int bbsID) {
	    String SQL = "SELECT fileName FROM BBS WHERE bbsID = " + bbsID;
	    ArrayList<String> fileList = new ArrayList<String>();
	    try {
	        Statement stmt = conn.createStatement();
	        rs = stmt.executeQuery(SQL);
	        while (rs.next()) {
	            String fileName = rs.getString(1);
	            fileList.add(fileName);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return fileList;
	}
}