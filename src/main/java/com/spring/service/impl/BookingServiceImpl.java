package com.spring.service.impl;

import com.spring.dao.TicketDao;
import com.spring.domain.Event;
import com.spring.domain.Ticket;
import com.spring.domain.User;
import com.spring.service.BookingService;
import com.spring.service.DiscountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Service
public class BookingServiceImpl implements BookingService {

    @Autowired
    private TicketDao ticketDao;

    @Autowired
    private DiscountService discountService;

    public void setTicketDao(TicketDao ticketDao) {
        this.ticketDao = ticketDao;
    }

    public void setDiscountService(DiscountService discountService) {
        this.discountService = discountService;
    }

    @Override
    public double getTicketsPrice(@Nonnull Event event, @Nonnull LocalDateTime dateTime, @Nullable User user, @Nonnull Set<Long> seats) {
        return 0;
    }

    //    @Override
//    public double getTicketsPrice(@Nonnull Event event, @Nonnull LocalDateTime dateTime, @Nullable User user, @Nonnull Set<Long> seats) {
//        final double vipTax = 1.2;
//        Auditorium auditorium = event.getDateAndAuditorium().get(dateTime);
//        long vipSeatsNumber = auditorium.countVipSeats(seats);
//        long seatsNumber = seats.size() - vipSeatsNumber;
//        double price = seatsNumber * event.getBasePrice() * event.getRating().getCoef();
//        double priceVip = vipSeatsNumber * event.getBasePrice() * event.getRating().getCoef() * vipTax;
//        int discount = discountService.getDiscount(user, event, dateTime, seats.size());
//        return (1.0 - discount / 100.0) * (price + priceVip);
//    }

    @Override
    public void bookTickets(@Nonnull Set<Ticket> tickets) {
        for (Ticket ticket : tickets) {
            if (ticket.getUser() != null) {
                ticketDao.create(ticket);
            }
        }
    }

    @Nonnull
    @Override
    public Set<Ticket> getPurchasedTicketsForEvent(@Nonnull Event event, @Nonnull LocalDateTime dateTime) {
        Set<Ticket> tickets = new HashSet<>();
        for (Ticket ticket : ticketDao.findAll()) {
            if (ticket.getEvent().equals(event) && ticket.getDateTime().equals(dateTime)) {
                tickets.add(ticket);
            }
        }
        return tickets;
    }
}
