package com.spring.domain;

public enum Technology {
	TWD_D("2D"),
	THREE_D("3D"),
	FOUR_D("4D");
	
	private String name;
	
	Technology(String name){
		this.name= name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
