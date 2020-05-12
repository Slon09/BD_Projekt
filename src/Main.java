public class Main {
    public static void main(String[] args){
        DataBaseConnector connector = new DataBaseConnector();
        print(connector.query("Select TABLE_NAME FROM ALL_TABLES WHERE TABLE_NAME LIKE 'WH%'"));
        print(connector.query("Select * FROM \"WH_Employees\""));
    }

    public static void print(Object arg){
        System.out.println(arg);
    }
}
