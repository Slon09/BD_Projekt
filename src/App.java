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
    private JMenuItem workerOrderListMenu;
    private JMenuItem managerOrderListMenu;
    private JMenuItem shopNewOrderMenu;
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
        this.shopMenuBar = new JMenuBar();
        this.workerMenuBar = new JMenuBar();
        this.managerMenuBar = new JMenuBar();

        this.shopModeMenu = new JMenu("Zmień tryb");
        this.workerModeMenu = new JMenu("Zmień tryb");
        this.managerModeMenu = new JMenu("Zmień tryb");

        this.shopToWorkerMode = new JMenuItem("Pracownik");
        this.shopToManagerMode = new JMenuItem("Manager");

        this.workerToShopMode = new JMenuItem("Sklep");
        this.workerToManagerMode = new JMenuItem("Manager");

        this.managerToShopMode = new JMenuItem("Sklep");
        this.managerToWorkerMode = new JMenuItem("Pracownik");

        this.shopToWorkerMode.addActionListener(this);
        this.shopToManagerMode.addActionListener(this);
        this.workerToShopMode.addActionListener(this);
        this.workerToManagerMode.addActionListener(this);
        this.managerToShopMode.addActionListener(this);
        this.managerToWorkerMode.addActionListener(this);


        this.shopModeMenu.add(this.shopToWorkerMode);
        this.shopModeMenu.add(this.shopToManagerMode);

        this.workerModeMenu.add(workerToShopMode);
        this.workerModeMenu.add(workerToManagerMode);

        this.managerModeMenu.add(managerToShopMode);
        this.managerModeMenu.add(managerToWorkerMode);

        this.shopMenuBar.add(this.shopModeMenu);
        this.workerMenuBar.add(this.workerModeMenu);
        this.managerMenuBar.add(managerModeMenu);


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
