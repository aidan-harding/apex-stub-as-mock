/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 26/06/2020
 */

public with sharing class ExpectationQueue {

    private List<Expectation> expectations = new List<Expectation>();

    public void add(Expectation expectation) {
        expectations.add(expectation);
    }

    public Expectation take() {
        Expectation returnValue = expectations.get(0);
        expectations.remove(0);
        return returnValue;
    }

    public Boolean isEmpty() {
        return expectations.isEmpty();
    }
}