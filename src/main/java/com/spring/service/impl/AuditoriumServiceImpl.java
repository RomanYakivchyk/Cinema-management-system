package com.spring.service.impl;

import com.spring.dao.AuditoriumDao;
import com.spring.domain.Auditorium;
import com.spring.service.AuditoriumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;

import java.util.List;
import java.util.Set;

@Service
public class AuditoriumServiceImpl implements AuditoriumService {

    @Autowired
    private AuditoriumDao auditoriumDao;

    public void setAuditoriumDao(AuditoriumDao auditoriumDao) {
        this.auditoriumDao = auditoriumDao;
    }

    @Override
    public List<Auditorium> findAll() {
        return auditoriumDao.findAll();
    }

    @Override
    public Auditorium findById(Long id) {
        return auditoriumDao.findById(id);
    }

}
