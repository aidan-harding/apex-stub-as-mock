/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 26/06/2020
 */

@IsTest
private class OrderMockBehaviourTest {

    private static String TALISKER = 'Talisker';
    private static Mock warehouseMock = new Mock();
    private static Warehouse warehouse = (Warehouse)Test.createStub(Warehouse.class, warehouseMock);

    @IsTest
    static void testOrderIsFilledIfEnoughInWarehouse() {

        warehouseMock.expects(
                new Expectation()
                        .method('hasInventory')
                        .parameter('name', TALISKER)
                        .parameter('amount', 50)
                        .returnValue(true))
                .expects(
                new Expectation()
                        .parameter('name', TALISKER)
                        .parameter('amount', 50)
                        .method('remove'));

        Order order = new Order(TALISKER, 50);
        order.fill(warehouse);
        System.assert(warehouseMock.verify());
    }

    @IsTest
    static void testOrderDoesNotRemoveIfNotEnough() {
        warehouseMock.expects(
                new Expectation()
                        .method('hasInventory')
                        .returnValue(true));

        Order order = new Order(TALISKER, 51);
        order.fill(warehouse);
        System.assert(!order.isFilled());
        System.assert(warehouseMock.verify());
    }
}