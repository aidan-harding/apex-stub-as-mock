/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 26/06/2020
 */

public class Order {

    private Boolean isFilled;
    private String name;
    private Integer amount;

    public Order(String name, Integer amount) {
        this.name = name;
        this.amount = amount;
    }
    public void fill(Warehouse warehouse) {
        isFilled = warehouse.take(name, amount);
    }

    public Boolean isFilled() {
        return isFilled;
    }
}