import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args){
        WarehouseServer server = new WarehouseServer();
//        server.addEmployee("Kacper", "Bojarczuk", 3200);
//        server.addOrder(2);
//        server.addOrder(1);
//        server.addOrder(3);
//        server.addOrder(4);
//        server.addOrder(5);
        List<List<Integer>> order = new ArrayList<>();
        List<Integer> order_det = new ArrayList<>();
        order_det.add(1);
        order_det.add(2);
        order.add(order_det);
        order_det.clear();
        order_det.add(2);
        order_det.add(1);
        order.add(order_det);
        server.addOrder(3, order);
        server.enlistEmployees();
        server.assignOrders();
        server.employeeApps.get(2).completeOrder();
        server.assignOrders();
    }

    public static void print(Object arg){
        System.out.println(arg);
    }
}
