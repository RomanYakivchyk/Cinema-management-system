package com.spring.dao;

import com.spring.domain.Auditorium;

import java.util.Set;

public interface AuditoriumDao {
    Set<Auditorium> findAll();
    Auditorium findByName(String name);
}
