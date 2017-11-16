package com.spring.domain;

import org.apache.commons.collections4.FactoryUtils;
import org.apache.commons.collections4.list.LazyList;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
@Scope("prototype")
public class Event extends DomainObject {

    private String name;
    private double basePrice;
    private EventRating rating;
    private List<EventDateAndAuditorium> dateAndAuditoriums = LazyList.lazyList(
            new ArrayList<>(), FactoryUtils.instantiateFactory(EventDateAndAuditorium.class));

    public Event() {
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

    public boolean isNew() {
        return (getId() == 0L);
    }

    @Override
    public String toString() {
        return "Event{" +
                "name='" + name + '\'' +
                ", basePrice=" + basePrice +
                ", rating=" + rating +
                ", dateAndAuditoriums=" + dateAndAuditoriums +
                '}';
    }


    //    private String name;
//    private double basePrice;
//    private EventRating rating;
//
//    private NavigableMap<LocalDateTime, Auditorium> dateAndAuditorium = new TreeMap<>();
//
//    public boolean removeAuditoriumAssignment(LocalDateTime dateTime) {
//        return dateAndAuditorium.delete(dateTime) != null;
//    }
//
//    public Auditorium addAirDateTime(LocalDateTime dateTime, Auditorium auditorium) {
//        return dateAndAuditorium.putIfAbsent(dateTime, auditorium);
//    }
//
//
//
//    /**
//     * Checks if event airs on particular date and time
//     *
//     * @param dateTime
//     *            Date and time to check
//     * @return <code>true</code> event airs on that date and time
//     */
//    public boolean airsOnDateTime(LocalDateTime dateTime) {
//        return dateAndAuditorium.keySet().stream().anyMatch(dt -> dt.equals(dateTime));
//    }
//
//    /**
//     * Checks if event airs on particular date
//     *
//     * @param date
//     *            Date to ckeck
//     * @return <code>true</code> event airs on that date
//     */
//    public boolean airsOnDate(LocalDate date) {
//        return dateAndAuditorium.keySet().stream().anyMatch(dt -> dt.toLocalDate().equals(date));
//    }
//
//    /**
//     * Checking if event airs on dates between <code>from</code> and
//     * <code>to</code> inclusive
//     *
//     * @param from
//     *            Start date to check
//     * @param to
//     *            End date to check
//     * @return <code>true</code> event airs on dates
//     */
//    public boolean airsOnDates(LocalDate from, LocalDate to) {
//        return dateAndAuditorium.keySet().stream()
//                .anyMatch(dt -> dt.toLocalDate().compareTo(from) >= 0 && dt.toLocalDate().compareTo(to) <= 0);
//    }
//
//    public String getName() {
//        return name;
//    }
//
//    public void setName(String name) {
//        this.name = name;
//    }
//
//    public double getBasePrice() {
//        return basePrice;
//    }
//
//    public void setBasePrice(double basePrice) {
//        this.basePrice = basePrice;
//    }
//
//    public EventRating getRating() {
//        return rating;
//    }
//
//    public void setRating(EventRating rating) {
//        this.rating = rating;
//    }
//
//    public NavigableMap<LocalDateTime, Auditorium> getDateAndAuditorium() {
//        return dateAndAuditorium;
//    }
//
//    public void setDateAndAuditorium(NavigableMap<LocalDateTime, Auditorium> dateAndAuditorium) {
//        this.dateAndAuditorium = dateAndAuditorium;
//    }
//
//    @Override
//    public int hashCode() {
//        return Objects.hash(name);
//    }
//
//    @Override
//    public boolean equals(Object obj) {
//        if (this == obj) {
//            return true;
//        }
//        if (obj == null) {
//            return false;
//        }
//        if (getClass() != obj.getClass()) {
//            return false;
//        }
//        Event other = (Event) obj;
//        if (name == null) {
//            if (other.name != null) {
//                return false;
//            }
//        } else if (!name.equals(other.name)) {
//            return false;
//        }
//        return true;
//    }

}