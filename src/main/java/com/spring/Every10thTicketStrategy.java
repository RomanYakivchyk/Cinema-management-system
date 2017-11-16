package com.spring;

import com.spring.dao.UserDao;
import com.spring.domain.Event;
import com.spring.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.time.LocalDateTime;

@Component
public class Every10thTicketStrategy implements DiscountStrategy {

    @Autowired
    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    //TODO LOGIC!!!
    public int calculateDiscount(@Nullable User user, @Nonnull Event event, @Nonnull LocalDateTime airDateTime, long numberOfTickets) {
        if (!userDao.findAll().contains(user)) {
            if (numberOfTickets >= 10) return 50;
            else return 0;
        } else {

            if ((user.getTickets().size() + 1) % 10 == 0)
                return 50;
            else return 0;
        }
    }

}
