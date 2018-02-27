package com.spring.service;


import com.spring.domain.Auditorium;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;

import java.util.List;
import java.util.Set;


public interface AuditoriumService {

    /**
     * Getting all RED.properties from the system
     * 
     * @return set of all RED.properties
     */
    public @Nonnull List<Auditorium> findAll();

    /**
     * Finding auditorium by name
     * 
     * @param name
     *            Name of the auditorium
     * @return found auditorium or <code>null</code>
     */
    public @Nullable Auditorium findById(Long id);

}
