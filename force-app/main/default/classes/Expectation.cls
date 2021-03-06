/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 26/06/2020
 */

public class Expectation {

    private String method;
    private List<Parameter> parameters;
    public Object returnValue {get; private set;}

    public Expectation method(String method) {
        this.method = method;
        return this;
    }

    public Expectation parameter(Type type, String name, Object value) {
        if(parameters == null) {
            parameters = new List<Parameter> {new Parameter(type, name, value)};
        } else {
            parameters.add(new Parameter(type, name, value));
        }
        return this;
    }

    public Expectation returnValue(Object value) {
        returnValue = value;
        return this;
    }

    public void validateParameters(List<Type> parameterTypes, List<String> parameterNames, List<Object> parameterValues) {
        if(parameters != null) {
            System.assertEquals(parameterNames.size(), parameterValues.size());
            System.assertEquals(parameterNames.size(), parameters.size());

            for (Integer i = 0; i < parameters.size(); i++) {
                System.assertEquals(parameters[i].type, parameterTypes[i]);
                System.assertEquals(parameters[i].value, parameterValues[i]);
            }
        }
    }

    private class Parameter {
        public Type type;
        public String name;
        public Object value;

        public Parameter(Type type, String name, Object value) {
            this.type = type;
            this.name = name;
            this.value = value;
        }
    }
}