package search;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import search.Lodging;

public class lodgingDAO {

	private Connection conn;
	
	public lodgingDAO() {
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

	public List<Lodging> getAllLodgings(String orderBy, String orderDir) {
        List<Lodging> lodgings = new ArrayList<>();

        try {
            Statement statement = conn.createStatement();
            String query = "SELECT * FROM BBS.lodging ORDER BY " + orderBy + " " + orderDir;
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                Lodging lodging = new Lodging();

                lodging.setTitle(resultSet.getString("title"));
                lodging.setImg(resultSet.getString("img"));
                lodging.setPrice(resultSet.getInt("price"));
                lodging.setLocation(resultSet.getString("location"));
                lodging.setId(resultSet.getInt("id"));
                lodgings.add(lodging);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lodgings;
    }
	
	public List<Lodging> getSearchAllLodgings(String searchField, String searchText) {
        List<Lodging> lodgings = new ArrayList<>();

        try{
            Statement statement = conn.createStatement();
            String query = "SELECT * FROM lodging WHERE " + searchField.trim()
               + " LIKE '%" + searchText.trim() + "%'";
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
            Lodging lodging = new Lodging();
            lodging.setTitle(resultSet.getString("title"));
            lodging.setImg(resultSet.getString("img"));
            lodging.setPrice(resultSet.getInt("price"));
            lodging.setLocation(resultSet.getString("location"));
            lodging.setId(resultSet.getInt("id"));
               lodgings.add(lodging);
         }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lodgings;
    }
	
    public List<Lodging> getAllLodgingsSearchRst() {
        List<Lodging> lodgings = new ArrayList<>();

        try{
            Statement statement = conn.createStatement();
            String query = "SELECT * FROM BBS.lodging";
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
            Lodging lodging = new Lodging();

            lodging.setTitle(resultSet.getString("title"));
            lodging.setImg(resultSet.getString("img"));
            lodging.setPrice(resultSet.getInt("price"));
            lodging.setLocation(resultSet.getString("location"));
            lodging.setId(resultSet.getInt("id"));
               lodgings.add(lodging);


         }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lodgings;
    }
}

