package com.spring.dao.dao_impl;

import com.spring.dao.UserDao;
import com.spring.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class JDBCUserDaoImpl implements UserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;


    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public User update(User object) {
        return null;
    }

    @Override
    public User create(User user) {
        if (user.getId() == 0L) {
            final String sql = "INSERT INTO USER (FIRST_NAME, LAST_NAME, BIRTHDAY, EMAIL) VALUES (?, ?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(
                    con -> {
                        PreparedStatement pst = con.prepareStatement(sql, new String[]{"ID"});
                        pst.setString(1, user.getFirstName());
                        pst.setString(2, user.getLastName());
                        pst.setDate(3, Date.valueOf(user.getBirthday()));
                        pst.setString(4, user.getEmail());
                        return pst;
                    },
                    keyHolder);
            user.setId(keyHolder.getKey().longValue());
            return user;
        }

        final String sql = "UPDATE USER SET FIRST_NAME = ?, LAST_NAME = ?, BIRTHDAY = ?, EMAIL = ? WHERE ID = ?";
        jdbcTemplate.update(sql, user.getFirstName(), user.getLastName(), Date.valueOf(user.getBirthday()), user.getEmail(), user.getId());
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
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, (resultSet, i) -> {
            User user = new User();
            user.setFirstName(resultSet.getString("FIRST_NAME"));
            user.setLastName(resultSet.getString("LAST_NAME"));
            user.setBirthday((resultSet.getDate("BIRTHDAY")).toLocalDate());
            user.setEmail(resultSet.getString("EMAIL"));
            return user;
        });
    }

    @Override
    public List<User> findAll() {
        final String sql = "SELECT * FROM USER";
        List<User> users = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map row : rows) {
            User user = new User();
            user.setId((Long) row.get("ID"));
            user.setFirstName((String) row.get("FIRST_NAME"));
            user.setLastName((String) row.get("LAST_NAME"));
            user.setBirthday(((Date) row.get("BIRTHDAY")).toLocalDate());
            user.setEmail((String) row.get("EMAIL"));
            users.add(user);
        }
        return users;
    }
}