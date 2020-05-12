public class Main {
    public static void main(String[] args){
        WarehouseServer server = new WarehouseServer();
//        server.addEmployee("Kacper", "Bojarczuk", 3200);
//        server.addOrder(2);
//        server.addOrder(1);
//        server.addOrder(3);
//        server.addOrder(4);
//        server.addOrder(5);
//        server.addOrder(2);
        server.enlistEmployees();
        server.assignOrders();
        server.employeeApps.get(2).completeOrder();
        server.assignOrders();
    }

    public static void print(Object arg){
        System.out.println(arg);
    }
}
