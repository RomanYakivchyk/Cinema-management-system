package com.spring.domain;

public enum EventRating {

    LOW(0.9),

    MED(1.0),

    HIGH(1.1);

    EventRating(double coef){
        this.coef = coef;
    }

    private double coef;

    public double getCoef() {
        return coef;
    }
}
