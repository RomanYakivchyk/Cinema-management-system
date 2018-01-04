package com.spring.domain;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

public class EventDateAndAuditorium {
	
    private LocalDateTime startTime;
    private LocalDateTime endTime;

    private String auditoriumName;

    public EventDateAndAuditorium() {
    }

    public String getAuditoriumName() {
        return auditoriumName;
    }

    public void setAuditoriumName(String auditoriumName) {
        this.auditoriumName = auditoriumName;
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
