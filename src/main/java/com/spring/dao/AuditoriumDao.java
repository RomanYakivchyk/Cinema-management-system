package com.spring.dao;

import com.spring.domain.Auditorium;

import java.util.List;

public interface AuditoriumDao {
    List<Auditorium> findAll();
    Auditorium findById(Long id);
    Auditorium create(Auditorium auditorium);
    Auditorium update(Auditorium auditorium);
    void delete(Auditorium auditorium);
}
