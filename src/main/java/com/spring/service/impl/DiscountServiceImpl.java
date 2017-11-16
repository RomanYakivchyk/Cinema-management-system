package com.spring.service.impl;

import com.spring.DiscountStrategy;
import com.spring.domain.Event;
import com.spring.domain.User;
import com.spring.service.DiscountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class DiscountServiceImpl implements DiscountService {

    @Autowired
    private List<DiscountStrategy> discountStrategies;

    public void setDiscountStrategies(List<DiscountStrategy> discountStrategies) {
        this.discountStrategies = discountStrategies;
    }

    @Override
    public byte getDiscount(@Nullable User user, @Nonnull Event event, @Nonnull LocalDateTime airDateTime, long numberOfTickets) {
        int maxDiscount = 0;
        for(DiscountStrategy strategy: discountStrategies){
            int discount = strategy.calculateDiscount(user,event,airDateTime,numberOfTickets);
            if(discount > maxDiscount) maxDiscount = discount;
        }
        return (byte)maxDiscount;
    }
}
