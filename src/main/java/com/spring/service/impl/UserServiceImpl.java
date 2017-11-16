package com.spring.service.impl;

import com.spring.dao.UserDao;
import com.spring.domain.User;
import com.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.util.Collection;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Nullable
    @Override
    public User findUserByEmail(@Nonnull String email) {
        for(User user: findAll()){
            if(email.equals(user.getEmail()))
                return user;
        }
        return null;
    }

    @Override
    public User saveOrUpdate(@Nonnull User object) {
        return userDao.create(object);
    }

    @Override
    public void delete(@Nonnull long id) {
        userDao.delete(id);
    }

    @Override
    public User findById(@Nonnull Long id) {
        return userDao.findById(id);
    }

    @Nonnull
    @Override
    public Collection<User> findAll() {
        return userDao.findAll();
    }
}
