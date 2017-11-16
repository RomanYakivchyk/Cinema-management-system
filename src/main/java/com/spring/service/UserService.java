package com.spring.service;


import com.spring.domain.User;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;

public interface UserService extends AbstractDomainObjectService<User> {

    /**
     * Finding user by email
     * 
     * @param email
     *            Email of the user
     * @return found user or <code>null</code>
     */
    public @Nullable User findUserByEmail(@Nonnull String email);

}
