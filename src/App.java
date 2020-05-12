import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;

public class App extends JFrame implements ActionListener {
    private static final long serialVersionUID = 1L;
    private JMenuBar shopMenuBar;
    private JMenuBar workerMenuBar;
    private JMenuBar managerMenuBar;
    private JMenu shopOrdersMenu;
    private JMenu workerOrdersMenu;
    private JMenu managerOrdersMenu;
    private JMenu managerWorkersMenu;
    private JMenu shopModeMenu;
    private JMenu workerModeMenu;
    private JMenu managerModeMenu;
    private JMenuItem shopOrderListMenu;
    private JMenuItem workerOrderListMenu;
    private JMenuItem managerOrderListMenu;
    private JMenuItem shopNewOrderMenu;
    private JMenuItem workerCurrentOrderMenu;
    private JMenuItem shopToWorkerMode;
    private JMenuItem shopToManagerMode;
    private JMenuItem workerToShopMode;
    private JMenuItem workerToManagerMode;
    private JMenuItem managerToShopMode;
    private JMenuItem managerToWorkerMode;
    private int shopId;
    private int workerId;

    public static void main(String[] args) {
        new App();
    }

    public App() {
        this.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        this.setSize(500, 500);
        this.setResizable(false);
        this.setLocationRelativeTo(null);
        this.add(new JLabel("Some dummy content"));
        this.createMenus();

        this.shopId = 0;
        this.workerId = 0;

        String[] choices = { "sklep", "pracownik", "manager" };
        String input = (String) JOptionPane.showInputDialog(null, "Kim jesteś:",
                "Wybór roli", JOptionPane.QUESTION_MESSAGE, null,
                choices,
                choices[0]);
        if(input == choices[0]) {
            this.runShopMode();
        } else if (input == choices[1]){
            this.runWorkerMode();
        } else if (input == choices[2]) {
            this.runManagerMode();
        }
    }

    private void runShopMode() {
        if(this.shopId < 1) {
            String[] choices = { "Nazwa Firmy 1", "Nazwa Firmy 2", "Nazwa Firmy 3" };
            String input = (String) JOptionPane.showInputDialog(null, "Wybierz swoją firmę:",
                    "Wybór sklepu", JOptionPane.QUESTION_MESSAGE, null,
                    choices,
                    choices[0]);

            for(int i = 0; i < choices.length; i++) {
                if(choices[i] == input) this.shopId = i+1;
            }
        }
        this.setTitle("Obsługa sklepu");
        this.setJMenuBar(this.shopMenuBar);
        this.setVisible(true);
    }

    private void runWorkerMode() {
        if(workerId < 1) {
            String[] choices = { "Adam Nowak", "Arutur śliwa", "Sracz 2" };
            String input = (String) JOptionPane.showInputDialog(null, "Wybierz siebie z listy:",
                    "Wybór pracownika", JOptionPane.QUESTION_MESSAGE, null,
                    choices,
                    choices[0]);

            for(int i = 0; i < choices.length; i++) {
                if(choices[i] == input) workerId = i+1;
            }
        }
        setTitle("Obsługa pracownika");
        this.setJMenuBar(this.workerMenuBar);
        setVisible(true);
    }

    private void runManagerMode() {
        setTitle("Obsługa managera");
        this.setJMenuBar(this.managerMenuBar);
        setVisible(true);
    }

    private void createMenus() {
        String changeMode = "Zmień tryb";
        String orders = "Zamówienie";
        String shop = "Sklep";
        String worker = "Pracownik";
        String manager = "Manager";
        String orderList = "Lista zamówień";

        this.shopMenuBar = new JMenuBar();
        this.workerMenuBar = new JMenuBar();
        this.managerMenuBar = new JMenuBar();

        this.shopModeMenu = new JMenu(changeMode);
        this.workerModeMenu = new JMenu(changeMode);
        this.managerModeMenu = new JMenu(changeMode);
        this.shopOrdersMenu = new JMenu(orders);
        this.workerOrdersMenu = new JMenu(orders);
        this.managerOrdersMenu = new JMenu(orders);
        this.managerWorkersMenu = new JMenu(worker);


        this.shopToWorkerMode = new JMenuItem(worker);
        this.shopToManagerMode = new JMenuItem(manager);

        this.workerToShopMode = new JMenuItem(shop);
        this.workerToManagerMode = new JMenuItem(manager);

        this.managerToShopMode = new JMenuItem(shop);
        this.managerToWorkerMode = new JMenuItem(worker);

        this.shopNewOrderMenu = new JMenuItem("Nowe zamówienie");
        this.shopOrderListMenu = new JMenuItem(orderList);
        this.workerOrderListMenu = new JMenuItem(orderList);
        this.managerOrderListMenu = new JMenuItem(orderList);
        this.workerCurrentOrderMenu = new JMenuItem("Obsługiwane zamówienie");

        this.shopToWorkerMode.addActionListener(this);
        this.shopToManagerMode.addActionListener(this);
        this.workerToShopMode.addActionListener(this);
        this.workerToManagerMode.addActionListener(this);
        this.managerToShopMode.addActionListener(this);
        this.managerToWorkerMode.addActionListener(this);
        this.shopNewOrderMenu.addActionListener(this);
        this.shopOrderListMenu.addActionListener(this);
        this.workerOrderListMenu.addActionListener(this);
        this.managerOrderListMenu.addActionListener(this);
        this.workerCurrentOrderMenu.addActionListener(this);

        this.shopModeMenu.add(this.shopToWorkerMode);
        this.shopModeMenu.add(this.shopToManagerMode);

        this.workerModeMenu.add(this.workerToShopMode);
        this.workerModeMenu.add(this.workerToManagerMode);

        this.managerModeMenu.add(this.managerToShopMode);
        this.managerModeMenu.add(this.managerToWorkerMode);

        this.shopOrdersMenu.add(this.shopNewOrderMenu);
        this.shopOrdersMenu.add(this.shopOrderListMenu);
        this.workerOrdersMenu.add(this.workerOrderListMenu);
        this.workerOrdersMenu.add(this.workerCurrentOrderMenu);
        this.managerOrdersMenu.add(this.managerOrderListMenu);

        this.shopMenuBar.add(this.shopOrdersMenu);
        this.workerMenuBar.add(this.workerOrdersMenu);
        this.managerMenuBar.add(this.managerOrdersMenu);

        this.shopMenuBar.add(this.shopModeMenu);
        this.workerMenuBar.add(this.workerModeMenu);
        this.managerMenuBar.add(this.managerModeMenu);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        final Object source = e.getSource();
        if(source == this.shopToWorkerMode) {
            this.workerId = 0;
            this.runWorkerMode();
        }
        if(source == this.shopToManagerMode) this.runManagerMode();
        if(source == this.workerToShopMode) {
            this.shopId = 0;
            this.runShopMode();
        }
        if(source == this.workerToManagerMode) this.runManagerMode();
        if(source == this.managerToShopMode) {
            this.shopId = 0;
            this.runShopMode();
        }
        if(source == this.managerToWorkerMode) {
            this.workerId = 0;
            this.runWorkerMode();
        }

    }

}
