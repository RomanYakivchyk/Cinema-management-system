package com.spring.dao.dao_impl;

import com.spring.dao.RoleDao;
import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.domain.EventRating;
import com.spring.domain.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class JDBCRoleDaoImpl implements RoleDao {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public JDBCRoleDaoImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Role findByName(String roleName) {
        final String sql1 = "SELECT * FROM ROLE WHERE NAME = ?";
        return jdbcTemplate.queryForObject(sql1, new Object[]{roleName}, (rs, i) -> {
            Role role = new Role();
            role.setId(rs.getLong("ID"));
            role.setName(rs.getString("NAME"));
            return role;
        });
    }
}
