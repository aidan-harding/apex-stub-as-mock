/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 26/06/2020
 */

@IsTest
private class OrderStateVerificationTest {
    private static String TALISKER = 'Talisker';
    private static String HIGHLAND_PARK = 'Highland Park';
    private static Warehouse warehouse = new Warehouse();

    static void setup() {
        warehouse.add(TALISKER, 50);
        warehouse.add(HIGHLAND_PARK, 50);
    }

    @IsTest
    static void testBehavior() {
        setup();
        Order order = new Order(TALISKER, 50);
        order.fill(warehouse);
        System.assert(order.isFilled());
        System.assertEquals(0, warehouse.getInventory(TALISKER));
    }
}