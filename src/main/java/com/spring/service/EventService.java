package com.spring.service;


import com.spring.domain.Event;

import java.util.List;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;

public interface EventService extends AbstractDomainObjectService<Event> {

    /**
     * Finding event by name
     * 
     * @param name
     *            Name of the event
     * @return found event or <code>null</code>
     */
    public @Nullable Event findByName(@Nonnull String name);
    public List<Event> findAll(int page,int total);

}
