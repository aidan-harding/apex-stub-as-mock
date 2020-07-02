/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 02/07/2020
 * @description Records function calls into an instance of Mock. For void methods, just call them. For returning methods,
 * call myRecorder.setReturn(aValue, myRecorderMock.function(params))
 */

public class MockRecorder implements StubProvider {

    private Mock mockToPopulate;
    private Expectation workingExpectation { get {
        if(workingExpectation == null) {
            workingExpectation = new Expectation();
        }
        return workingExpectation;
    } set; }

    public MockRecorder(Mock mockToPopulate) {
        this.mockToPopulate = mockToPopulate;
    }

    public Object handleMethodCall(Object stubbedObject, String stubbedMethod, Type returnType, List<Type> parameterTypes, List<String> parameterNames, List<Object> parameters) {
        workingExpectation = new Expectation().method(stubbedMethod);
        for(Integer i=0; i < parameterTypes.size(); i++) {
            workingExpectation.parameter(parameterTypes[i], parameterNames[i], parameters[i]);
        }
        mockToPopulate.expects(workingExpectation);
        return null;
    }

    public void setReturn(Object returnVal,  Object ignored) {
        workingExpectation.returnValue(returnVal);
    }
}