package com.spring.dao.dao_impl;

import com.spring.dao.EventDao;
import com.spring.dao.TicketDao;
import com.spring.dao.UserDao;
import com.spring.domain.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class JDBCTicketDaoImpl implements TicketDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private UserDao userDao;

    @Autowired
    private EventDao eventDao;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public void setEventDao(EventDao eventDao) {
        this.eventDao = eventDao;
    }

    @Override
    public void update(Ticket object) {
    }

    @Override
    public void create(Ticket ticket) {
        if (ticket.getId() == 0L) {
            final String sql = "INSERT INTO TICKET (USER_ID, EVENT_ID, DATE_TIME, SEAT) VALUES (?, ?, ?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(
                    con -> {
                        PreparedStatement pst = con.prepareStatement(sql, new String[]{"ID"});
                        pst.setLong(1, ticket.getUser().getId());
                        pst.setLong(2, ticket.getEvent().getId());
                        pst.setTimestamp(3, Timestamp.valueOf(ticket.getDateTime()));
                        pst.setLong(4, ticket.getSeat());
                        return pst;
                    },
                    keyHolder);
            ticket.setId((Long) keyHolder.getKey());
            return;
        }

        final String sql = "UPDATE TICKET SET USER_ID=?, EVENT_ID=?, DATE_TIME=?, SEAT=? WHERE ID=?";
        jdbcTemplate.update(sql, ticket.getUser().getId(), ticket.getEvent().getId(), ticket.getDateTime(), ticket.getSeat(), ticket.getId());
    }

    @Override
    public void delete(Long id) {
        final String sql = "DELETE FROM TICKET WHERE ID = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public Ticket findById(Long id) {
        final String sql1 = "SELECT * FROM TICKET WHERE ID = ?";
        return jdbcTemplate.queryForObject(sql1, new Object[]{id}, (resultSet, i) -> {
            Ticket ticket = new Ticket();
            ticket.setId(resultSet.getLong("ID"));
            ticket.setUser(userDao.findById(resultSet.getLong("USER_ID")));
            ticket.setEvent(eventDao.findById(resultSet.getLong("EVENT_ID")));
            ticket.setDateTime((resultSet.getTimestamp("DATE_TIME").toLocalDateTime()));
            ticket.setSeat(resultSet.getLong("SEAT"));
            return null;
        });
    }

    @Override
    public List<Ticket> findAll() {
        final String sql = "SELECT * FROM TICKET";
        List<Ticket> tickets = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map row : rows) {
            Ticket ticket = new Ticket();
            ticket.setId((Long) row.get("ID"));
            ticket.setUser(userDao.findById((Long) row.get("USER_ID")));
            ticket.setEvent(eventDao.findById((Long) row.get("EVENT_ID")));
            ticket.setDateTime(((Timestamp) row.get("DATE_TIME")).toLocalDateTime());
            ticket.setSeat((Long) row.get("SEAT"));
            tickets.add(ticket);
        }
        return tickets;
    }
}