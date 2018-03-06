package com.spring.domain;

import org.springframework.stereotype.Component;


@Component
public class Auditorium extends DomainObject{

    private String name;
    private Integer rowNumber;
    private Integer seatsInEachRow;

    
	public Integer getRowNumber() {
		return rowNumber;
	}

	public void setRowNumber(Integer rowNumber) {
		this.rowNumber = rowNumber;
	}

	public Integer getSeatsInEachRow() {
		return seatsInEachRow;
	}

	public void setSeatsInEachRow(Integer seatsInEachRow) {
		this.seatsInEachRow = seatsInEachRow;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
    
    
}
