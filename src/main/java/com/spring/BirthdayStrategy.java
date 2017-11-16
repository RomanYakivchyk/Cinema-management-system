package com.spring;

import com.spring.domain.Event;
import com.spring.domain.User;
import org.springframework.stereotype.Component;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.MonthDay;

@Component
public class BirthdayStrategy implements DiscountStrategy {

    public int calculateDiscount(@Nullable User user, @Nonnull Event event, @Nonnull LocalDateTime airDateTime, long numberOfTickets) {
        if (user.getBirthday() == null) return 0;

        MonthDay eventDate = MonthDay.of(airDateTime.getMonth(), airDateTime.getDayOfMonth());
        LocalDate from = user.getBirthday().minusDays(1);
        MonthDay startDate = MonthDay.of(from.getMonth(), from.getDayOfMonth());
        LocalDate to = user.getBirthday().plusDays(6);
        MonthDay endDate = MonthDay.of(to.getMonth(), to.getDayOfMonth());

        if (eventDate.isAfter(startDate) && eventDate.isBefore(endDate))
            return 5;
        else
            return 0;
    }
}
