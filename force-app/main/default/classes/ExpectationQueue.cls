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
        return expectations.remove(0);
    }

    public Boolean isEmpty() {
        return expectations.isEmpty();
    }
}