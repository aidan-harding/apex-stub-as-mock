/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 26/06/2020
 */

public class Warehouse {

    private Map<String, Integer> stock = new Map<String, Integer>();

    public void add(String name, Integer amount) {
        stock.put(name, amount);
    }

    public Integer getInventory(String name) {
        return stock.get(name);
    }

    public Boolean take(String name, Integer amount) {
        Integer warehouseAmount = stock.get(name);
        if(warehouseAmount == null || warehouseAmount < amount) {
            return false;
        } else {
            stock.put(name, warehouseAmount - amount);
            return true;
        }
    }
}