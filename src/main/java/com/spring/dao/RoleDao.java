package com.spring.dao;

import com.spring.domain.Event;
import com.spring.domain.Role;

import java.util.List;

public interface RoleDao {
    //todo
    Role findByName(String roleName);
}
