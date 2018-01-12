package com.spring.domain;

public enum EventRating {

    LOW("Low",0.9),

    MED("Medium",1.0),

    HIGH("High",1.1);
	
	
	private String name;
	private Double coef;
	
	private EventRating(String name, Double coef) {
		this.name = name;
		this.coef = coef;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getCoef() {
		return coef;
	}

	public void setCoef(Double coef) {
		this.coef = coef;
	}
	
	

  
}
