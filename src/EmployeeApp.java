public class EmployeeApp {
    public int current_order_id;
    public int employee_id;
    public boolean is_working = false;
    public WarehouseServer server;

    public EmployeeApp(WarehouseServer server, int employee_id){
        this.server = server;
        this.employee_id = employee_id;
        server.enlist(this);
    }

    public void completeOrder(){
        server.employeeCompleteOrder(this);
        is_working = false;
        current_order_id = 0;
    }

    public void getOrder(int id){
        this.current_order_id = id;
        is_working = true;
    }

    public String toString(){
        return String.format("Employee: %d\nIs working: %b\nOrder: %d\n", employee_id, is_working, current_order_id);
    }
}
