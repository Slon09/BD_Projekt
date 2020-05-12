import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class DataBaseConnector {
    private String driverString = "jdbc:oracle:thin:@";
    private String host = "156.17.43.90";
    private String port = "1521";
    private String serviceName = "xe";
    private String user = "pwr_19_20_L_018248844";
    private String password = "248844";

    private Connection connection;

    public DataBaseConnector connect(){
        System.out.println("Connecting to database as " + user);
        try {
            connection = DriverManager.getConnection(
                    driverString+host+":"+port+":"+serviceName, user, password);

        } catch (SQLException e) {
            System.err.format("SQL State: %s\n%s", e.getSQLState(), e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return this;
    }

    public List<Map<String, String>> query(String query){
        try {
            connect();

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(query);

            ResultSetMetaData rsmd = rs.getMetaData();
            List<String> cols = new ArrayList<>();

            for(int i=1;i<=rsmd.getColumnCount(); ++i) cols.add(rsmd.getColumnName(i));

            List<Map<String, String>> result = new ArrayList<>();

            while(rs.next()){
                Map<String, String> row = new HashMap<>();
                for(String column : cols){
                    try {
                        row.put(column, rs.getString(column));
                    } catch (Exception e){
                        row.put(column, Integer.toString(rs.getInt(column)));
                    }
                }
                result.add(row);
            }
            connection.close();
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
