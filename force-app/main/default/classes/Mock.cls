/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 26/06/2020
 * @description A mock which just returns values based on the expectations set via .addExpectation()
 */

public class Mock implements StubProvider {

    private ExpectationQueue expectations = new ExpectationQueue();

    public Mock expects(Expectation expectation) {
        this.expectations.add(expectation);
        return this;
    }

    public Object handleMethodCall(Object stubbedObject, String stubbedMethod, Type returnType, List<Type> parameterTypes, List<String> parameterNames, List<Object> parameters) {
        System.assert(!expectations.isEmpty(), 'Ran out of expectations handling method ' + stubbedMethod);
        Expectation thisExpectation = expectations.take();
        thisExpectation.validateParameters(parameterTypes, parameterNames, parameters);
        return thisExpectation.returnValue;
    }

    public Boolean verify() {
        return expectations.isEmpty();
    }
}