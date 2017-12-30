package com.spring.domain;

import com.spring.dao.RoleDao;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component
public class Role {
    private Long id;
    private String name;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}