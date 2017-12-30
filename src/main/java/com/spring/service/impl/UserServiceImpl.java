package com.spring.service.impl;

import com.spring.dao.RoleDao;
import com.spring.dao.UserDao;
import com.spring.domain.Role;
import com.spring.domain.User;
import com.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    public void setRoleDao(RoleDao roleDao) {
        this.roleDao = roleDao;
    }

    public void setbCryptPasswordEncoder(BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public User findByUsername(String username) {
        for (User user : findAll()) {
            if (username.equals(user.getUsername())) {
                for(Role role: user.getRoles()){
                    System.out.println(role.getName());
                }
                return user;
            }
        }
        return null;
    }

    @Override
    public User saveOrUpdate(@Nonnull User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setActive((byte)1);
        Role userRole = roleDao.findByName("ROLE_ADMIN");//todo
        user.setRoles(new HashSet<Role>(Arrays.asList(userRole)));
        if (user.getId() == 0)
            return userDao.create(user);
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
