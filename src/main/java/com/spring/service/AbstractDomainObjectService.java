package com.spring.service;

import com.spring.domain.DomainObject;

import javax.annotation.Nonnull;
import java.util.Collection;

/**
 * @param <T> DomainObject subclass
 */
public interface AbstractDomainObjectService<T extends DomainObject> {

    /**
     * Saving new object to storage or updating existing one
     *
     * @param object Object to saveOrUpdate
     * @return saved object with assigned id
     */
    public T saveOrUpdate(@Nonnull T object);

    /**
     * Removing object from storage
     *
     * @param id of the Object to delete
     */
    public void delete(long id);

    /**
     * Getting object by id from storage
     *
     * @param id id of the object
     * @return Found object or <code>null</code>
     */
    public T findById(@Nonnull Long id);

    /**
     * Getting all objects from storage
     *
     * @return collection of objects
     */
    public @Nonnull
    Collection<T> findAll();
}
