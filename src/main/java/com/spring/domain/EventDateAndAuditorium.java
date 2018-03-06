package com.spring.domain;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

public class EventDateAndAuditorium  extends DomainObject{
	
    private LocalDateTime startTime;
    private LocalDateTime endTime;

    private Auditorium auditorium;

    public EventDateAndAuditorium() {
    }

   
    public Auditorium getAuditorium() {
		return auditorium;
	}

	public void setAuditorium(Auditorium auditorium) {
		this.auditorium = auditorium;
	}

	public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }
    
}
