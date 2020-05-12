import java.util.*;

public class WarehouseServer{
    public DataBaseConnector connector;
    public List<EmployeeApp> employeeApps;
    public List<EmployeeApp> workQueue;

    public WarehouseServer(){
        connector = new DataBaseConnector();
        employeeApps = new ArrayList<>();
        workQueue = new ArrayList<>();
    }

    public void changeOrderStatus(String status, String orderID){
        connector.fetch(String.format("UPDATE \"WH_Orders\"\n" +
                "SET \"Status\" = '%s'\n" +
                "WHERE \"Order_id\" = %s", status, orderID));
    }

    public void changeOrderStatus(String status, int orderID){
        connector.query(String.format("UPDATE \"WH_Orders\"\n" +
                "SET \"Status\" = '%s'\n" +
                "WHERE \"Order_id\" = %d", status, orderID));
    }

    public void employeeCompleteOrder(EmployeeApp employee) {
        changeOrderStatus("Completed", employee.current_order_id);
        connector.query(String.format("UPDATE \"WH_Employees\"\n" +
                "    SET \"Completed_orders\" = (SELECT \"Completed_orders\" FROM \"WH_Employees\"\n" +
                "    WHERE \"Employee_id\" = %d) + 1\n" +
                "WHERE \"Employee_id\" = %d", employee.employee_id, employee.employee_id));
        workQueue.add(employee);
    }

    public void enlist(EmployeeApp employeeApp) {
        employeeApps.add(employeeApp);
        workQueue.add(employeeApp);
    }

    public void addOrder(int shopID){
        int orderID = Integer.parseInt(connector.fetch("SELECT MAX(\"Order_id\") FROM \"WH_Orders\"").get(0).get("MAX(\"ORDER_ID\")")) + 1;
        connector.query(String.format("INSERT INTO \"WH_Orders\"\n" +
                "    VALUES (%d, %d, NULL, 'Waiting')", orderID, shopID));
    }

    public void employeeGetOrder(int orderID){
        EmployeeApp employee = workQueue.remove(0);
        connector.query(String.format("UPDATE \"WH_Orders\"\n" +
                "SET \"Employee_id\" = '%d'\n" +
                "WHERE \"Order_id\" = %d", employee.employee_id, orderID));
        changeOrderStatus("In progress", orderID);
        employee.getOrder(orderID);
    }

    public void assignOrders(){
        List<Integer> orders = getWaitingOrders();
        while(workQueue.size() > 0 && orders.size() > 0){
            employeeGetOrder(orders.remove(0));
        }
    }

    public List<Integer> getWaitingOrders(){
        List<Map<String, String>> ordersRaw = connector.fetch("SELECT \"Order_id\" FROM \"WH_Orders\"\n" +
                "    WHERE \"Status\" = 'Waiting' ORDER BY \"Order_id\"");
        List<Integer> orders = new ArrayList<>();
        for(Map<String, String> row : ordersRaw){
            orders.add(Integer.parseInt(row.get("Order_id")));
        }
        return orders;
    }

    public void enlistEmployees(){
        List<Map<String, String>> employeesRaw = connector.fetch("SELECT \"Employee_id\" FROM \"WH_Employees\"" );
        for(Map<String, String> row : employeesRaw){
            new EmployeeApp(this, Integer.parseInt(row.get("Employee_id")));
        }
        List<Map<String, String>> pendingOrdersRaw = connector.fetch("SELECT \"Order_id\" " +
                " FROM \"WH_Orders\" WHERE \"Status\" = 'In progress'");
        for(Map<String, String> row : pendingOrdersRaw){
            int orderID = Integer.parseInt(row.get("Order_id"));
            employeeGetOrder(orderID);
        }
    }

    public void addEmployee(String firstName, String lastName, double salary){
        int employeeID = Integer.parseInt(connector.fetch("SELECT MAX(\"Employee_id\") FROM \"WH_Employees\"")
                .get(0).get("MAX(\"EMPLOYEE_ID\")")) + 1;
        connector.query(String.format(Locale.ROOT, "INSERT into \"WH_Employees\"\n" +
                "    values (%d, '%s', '%s', 0, %.2f)", employeeID, firstName, lastName, salary));
        new EmployeeApp(this, employeeID);
    }
}
