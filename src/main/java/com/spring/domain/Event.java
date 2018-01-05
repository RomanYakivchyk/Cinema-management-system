package com.spring.domain;

import org.apache.commons.collections4.FactoryUtils;

import org.apache.commons.collections4.list.LazyList;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.util.*;

@Component
public class Event extends DomainObject {

    private String name;
    private double basePrice;
    private EventRating rating;
    private CommonsMultipartFile image;
    private String country;
    private int year;
    private String language;
    private List<String> genres;
    private List<String> actors;
    private String directedBy;
    private String description;
    private int durationMin;
    private Technology technology;
    private int minAge;
    
    
    private List<EventDateAndAuditorium> dateAndAuditoriums = LazyList.lazyList(
            new ArrayList<>(), FactoryUtils.instantiateFactory(EventDateAndAuditorium.class));

    public Event() {
    }


    public boolean isNew() {
        return (getId() == 0L);
    }
    
    
    
    
    
	@Override
	public String toString() {
		return "Event [name=" + name + ", basePrice=" + basePrice + ", rating=" + rating + ", image=" + image
				+ ", country=" + country + ", year=" + year + ", language=" + language + ", genres=" + genres
				+ ", actors=" + actors + ", directedBy=" + directedBy + ", description=" + description
				+ ", durationMin=" + durationMin + ", technology=" + technology + ", minAge=" + minAge
				+ ", dateAndAuditoriums=" + dateAndAuditoriums + "]";
	}


	public CommonsMultipartFile getImage() {
		return image;
	}


	public void setImage(CommonsMultipartFile image) {
		this.image = image;
	}


	public String getCountry() {
		return country;
	}



	public void setCountry(String country) {
		this.country = country;
	}



	public int getYear() {
		return year;
	}



	public void setYear(int year) {
		this.year = year;
	}



	public String getLanguage() {
		return language;
	}



	public void setLanguage(String language) {
		this.language = language;
	}


	public List<String> getGenres() {
		return genres;
	}



	public void setGenres(List<String> genres) {
		this.genres = genres;
	}



	public List<String> getActors() {
		return actors;
	}



	public void setActors(List<String> actors) {
		this.actors = actors;
	}



	public String getDirectedBy() {
		return directedBy;
	}



	public void setDirectedBy(String directedBy) {
		this.directedBy = directedBy;
	}



	public String getDescription() {
		return description;
	}



	public void setDescription(String description) {
		this.description = description;
	}



	public int getDurationMin() {
		return durationMin;
	}



	public void setDurationMin(int durationMin) {
		this.durationMin = durationMin;
	}



	public int getMinAge() {
		return minAge;
	}



	public void setMinAge(int minAge) {
		this.minAge = minAge;
	}



	public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public EventRating getRating() {
        return rating;
    }

    public void setRating(EventRating rating) {
        this.rating = rating;
    }

    public List<EventDateAndAuditorium> getDateAndAuditoriums() {
        return dateAndAuditoriums;
    }

    public void setDateAndAuditoriums(List<EventDateAndAuditorium> dateAndAuditoriums) {
        this.dateAndAuditoriums = dateAndAuditoriums;
    }



	public Technology getTechnology() {
		return technology;
	}



	public void setTechnology(Technology technology) {
		this.technology = technology;
	}
	
	

}