# Apex Stub as Mock

Although the definitions of Mock and Stub are contested, I found the following article 
[Mocks Aren't Stubs](https://martinfowler.com/articles/mocksArentStubs.html) very useful to advance my 
thoughts on mocking/stubbing for testing.

By the definition of the article, a Stub is an object that can stand in for a real implementation and has prepared basic 
responses to method calls. These responses don't do the work of the real implementation, they just return something 
simple to avoid something like a callout, or complex calculation.

A Mock in the article is an object which can also stand in for a real implementation. But a mock does verification itself.
It has expectations (set up in the test) of how the system under test should call it. And the mock is responsible for 
checking those expectations.   

The [Apex Subs API](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_stub_api.htm) is problematic for building a Stub in the above sense because it receives a method call as a string,
and Apex offers no reflection method to dynamically handle that call via a method (we would have to instantiate a 
class, or have a big switch-style statement). This would lead to an ugly implementation. 

However, if we use Stubs API to make a Mock in the sense of the article, we can set the expectations from the test and 
avoid having to put lots of ugly code in the `StubProvider`. The test can set a sequence of expectations, and the stub 
just verifies those, providing the responses given in the test.

A test in this scenario (where we are mocking the Warehouse class) looks like this:

    Mock warehouseMock = new Mock();
    Warehouse warehouse = (Warehouse)Test.createStub(Warehouse.class, warehouseMock);

    warehouseMock.expects(
            new Expectation()
                    .method('hasInventory')
                    .parameter(String.class, 'name', TALISKER)
                    .parameter(Integer.class, 'amount', 50)
                    .returnValue(true))
            .expects(
            new Expectation()
                    .parameter(String.class, 'name', TALISKER)
                    .parameter(Integer.class, 'amount', 50)
                    .method('remove'));

    Order order = new Order(TALISKER, 50);
    order.fill(warehouse);
    System.assert(warehouseMock.verify());

Note that the `Mock` class from this repo doesn't need to know anything special about Warehouse. The test sets 
expectations in a generic way.

An alternative way to set expectations is to use a recording mock. Here, you create two mocks: one to record and one to 
play back. The playback mock is provided to the recorder at setup, so that it can set expectations correctly e.g.

    Mock warehouseMock = new Mock();
    MockRecorder warehouseMockRecorder = new MockRecorder(warehouseMock);
    Warehouse warehouseRecorder = (Warehouse)Test.createStub(Warehouse.class, warehouseMockRecorder);
    Warehouse warehouse = (Warehouse)Test.createStub(Warehouse.class, warehouseMock);

    warehouseMockRecorder.setReturn(true, warehouseRecorder.hasInventory(TALISKER, 50));
    warehouseRecorder.remove(TALISKER, 50);

    Order order = new Order(TALISKER, 50);
    order.fill(warehouse);
    System.assert(warehouseMock.verify());


Note also that this is really just a proof-of-concept to explore the ideas in the above article, not necessarily 
something I advocate.  