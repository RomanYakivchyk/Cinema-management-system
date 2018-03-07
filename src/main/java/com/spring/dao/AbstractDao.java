package com.spring.dao;


import com.spring.domain.DomainObject;

import java.util.List;

public interface AbstractDao<T extends DomainObject> {
    void create(T object);
    void update(T object);
    void delete(Long id);
    T findById(Long id);
    List<T> findAll();
    
}
