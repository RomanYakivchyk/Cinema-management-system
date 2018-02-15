package com.spring.service.impl;

import com.spring.dao.EventDao;
import com.spring.domain.Event;
import com.spring.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Nonnull;
import java.util.Collection;

@Service
public class EventServiceImpl implements EventService {

    @Autowired
    private EventDao eventDao;

    public void setEventDao(EventDao eventDao) {
        this.eventDao = eventDao;
    }

    @Override
    public Event findByName(String name) {
        for (Event event : findAll()) {
            if (name.equals(event.getName())) {
                return event;
            }
        }
        return null;
    }

    @Override
    public Event saveOrUpdate(@Nonnull Event event) {
        if (event.getId() == 0)
            return eventDao.create(event);
        else
            return eventDao.update(event);
    }

    @Override
    public void delete(long id) {
        eventDao.delete(id);
    }

    @Override
    public Event findById(@Nonnull Long id) {
        return eventDao.findById(id);
    }

    
    @Override
    public Collection<Event> findAll() {
        return eventDao.findAll();
    }
    
    
}
