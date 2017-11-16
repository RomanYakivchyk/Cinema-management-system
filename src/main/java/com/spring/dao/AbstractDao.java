package com.spring.dao;


import com.spring.domain.DomainObject;

import java.util.List;

public interface AbstractDao<T extends DomainObject> {
    T create(T object);
    T update(T object);
    void delete(long id);
    T findById(long id);
    List<T> findAll();
}
