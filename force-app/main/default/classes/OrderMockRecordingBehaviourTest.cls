/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 02/07/2020
 */

@IsTest
private class OrderMockRecordingBehaviourTest {

    private static String TALISKER = 'Talisker';
    private static Mock warehouseMock = new Mock();
    private static MockRecorder warehouseMockRecorder = new MockRecorder(warehouseMock);
    private static Warehouse warehouseRecorder = (Warehouse)Test.createStub(Warehouse.class, warehouseMockRecorder);
    private static Warehouse warehouse = (Warehouse)Test.createStub(Warehouse.class, warehouseMock);

    @IsTest
    static void testOrderIsFilledIfEnoughInWarehouse() {
        warehouseMockRecorder.setReturn(true, warehouseRecorder.hasInventory(TALISKER, 50));
        warehouseRecorder.remove(TALISKER, 50);

        Order order = new Order(TALISKER, 50);
        order.fill(warehouse);
        System.assert(warehouseMock.verify());
    }

    @IsTest
    static void testOrderDoesNotRemoveIfNotEnough() {
        warehouseMockRecorder.setReturn(false, warehouseRecorder.hasInventory(TALISKER, 51));

        Order order = new Order(TALISKER, 51);
        order.fill(warehouse);
        System.assert(!order.isFilled());
        System.assert(warehouseMock.verify());
    }
}