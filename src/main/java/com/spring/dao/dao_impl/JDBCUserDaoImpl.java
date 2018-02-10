package com.spring.dao.dao_impl;

import com.spring.dao.UserDao;

import com.spring.domain.Role;
import com.spring.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.util.*;

@Repository
public class JDBCUserDaoImpl implements UserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;


    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public User update(User user) {
        final String sql1 = "UPDATE USER SET FIRST_NAME = ?, LAST_NAME = ?, BIRTHDAY = ?," +
                " EMAIL = ?, USERNAME = ?, PASSWORD = ?, PASSWORD_CONFIRM = ?, ACTIVE = ? WHERE ID = ?";
        final String sql2 = "DELETE * FROM USER_ROLE WHERE USER_ID = ?";
        final String sql3 = "INSERT INTO USER_ROLE (USER_ID,ROLE_ID) VALUES (?, ?)";

        jdbcTemplate.update(
                sql1, user.getFirstName(), user.getLastName(), Date.valueOf(user.getBirthday()), user.getEmail(),
                user.getUsername(), user.getPassword(), user.getPasswordConfirm(), user.getActive(), user.getId());

        jdbcTemplate.update(sql2, user.getId());

        for (Role role : user.getRoles()) {
            jdbcTemplate.update(sql3, user.getId(), role.getId());
        }

        return user;
    }

    //TODO
    @Override
    public User create(User user) {
        final String sql1 = "INSERT INTO USER (FIRST_NAME, LAST_NAME, BIRTHDAY, EMAIL," +
                " USERNAME, PASSWORD, PASSWORD_CONFIRM, ACTIVE) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        final String sql2 = "INSERT INTO USER_ROLE (USER_ID,ROLE_ID) VALUES (?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(
                con -> {
                    PreparedStatement pst = con.prepareStatement(sql1, new String[]{"ID"});
                    pst.setString(1, user.getFirstName());
                    pst.setString(2, user.getLastName());
                    pst.setDate(3, Date.valueOf(user.getBirthday()));
                    pst.setString(4, user.getEmail());
                    pst.setString(5, user.getUsername());
                    pst.setString(6, user.getPassword());
                    pst.setString(7, user.getPasswordConfirm());
                    pst.setByte(8, user.getActive());
                    return pst;
                },
                keyHolder);
        user.setId(keyHolder.getKey().longValue());
        for (Role role : user.getRoles()) {
            System.out.println(role.getId() + "|" + role.getName());
        }
        for (Role role : user.getRoles()) {
            jdbcTemplate.update(sql2, user.getId(), role.getId());
        }

        return user;
    }

    @Override
    public void delete(long id) {
        final String sql = "DELETE FROM USER WHERE ID = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public User findById(long id) {
        final String sql = "SELECT * FROM USER WHERE ID = ?";
        final String sql2 = "SELECT * FROM ROLE WHERE ID IN (SELECT ROLE_ID FROM USER_ROLE WHERE USER_ID = ?)";
        User user = jdbcTemplate.queryForObject(sql, new Object[]{id}, (resultSet, i) -> {
            User userRowMapper = new User();
            userRowMapper.setId(resultSet.getLong("ID"));
            userRowMapper.setFirstName(resultSet.getString("FIRST_NAME"));
            userRowMapper.setLastName(resultSet.getString("LAST_NAME"));
            userRowMapper.setBirthday((resultSet.getDate("BIRTHDAY")).toLocalDate());
            userRowMapper.setEmail(resultSet.getString("EMAIL"));
            userRowMapper.setUsername(resultSet.getString("USERNAME"));
            userRowMapper.setPassword(resultSet.getString("PASSWORD"));
            userRowMapper.setPasswordConfirm(resultSet.getString("PASSWORD_CONFIRM"));
            userRowMapper.setActive(resultSet.getByte("ACTIVE"));
            return userRowMapper;
        });

        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql2, user.getId());
        user.setRoles(getRoles(rows));
        return user;
    }

    //TOdo
    @Override
    public List<User> findAll() {
        final String sql = "SELECT * FROM USER";
        final String sql2 = "SELECT * FROM ROLE WHERE ID IN (SELECT ROLE_ID FROM USER_ROLE WHERE USER_ID = ?)";
        List<User> users = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map row : rows) {
            User user = new User();
            user.setId((Long) row.get("ID"));
            user.setFirstName((String) row.get("FIRST_NAME"));
            user.setLastName((String) row.get("LAST_NAME"));
            user.setBirthday(((Date) row.get("BIRTHDAY")).toLocalDate());
            user.setEmail((String) row.get("EMAIL"));
            user.setUsername((String) row.get("USERNAME"));
            user.setPassword((String) row.get("PASSWORD"));
            user.setPasswordConfirm((String) row.get("PASSWORD_CONFIRM"));
            user.setActive((byte) row.get("ACTIVE"));

            List<Map<String, Object>> roleRows = jdbcTemplate.queryForList(sql2, user.getId());
            user.setRoles(getRoles(roleRows));
            users.add(user);
        }
        return users;
    }

    private Set<Role> getRoles(List<Map<String, Object>> rows) {
        Set<Role> roles = new HashSet<>();
        for (Map row : rows) {
            Role role = new Role();
            role.setId((Long) row.get("ID"));
            role.setName((String) row.get("NAME"));
            roles.add(role);
        }
        return roles;
    }
}