package com.spring.service.impl;

import com.spring.dao.UserDao;
import com.spring.domain.User;
import com.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.util.Collection;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

//    @Autowired
//    private BCryptPasswordEncoder passwordEncoder;

//    public void setPasswordEncoder(BCryptPasswordEncoder passwordEncoder) {
//        this.passwordEncoder = passwordEncoder;
//    }

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
    public User saveOrUpdate(@Nonnull User user) {
        if (user.getId() == 0) {
            return userDao.create(user);
        }
        else
            return userDao.update(user);
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
