package com.spring.service;


import com.spring.domain.User;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;

public interface UserService extends AbstractDomainObjectService<User> {

     @Nullable User findByUsername(@Nonnull String email);

}
