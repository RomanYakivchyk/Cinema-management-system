package com.spring.dao.dao_impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.spring.domain.Event;
import com.spring.domain.EventRating;
import com.spring.domain.Seat;
import com.spring.domain.Technology;

@Repository
public class JDBCSeatDaoImpl {
	private final Logger logger = LoggerFactory.getLogger(JDBCSeatDaoImpl.class);
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<Seat> findByEdaId(Long id) {
		logger.debug("find seats by eda id; eda_id=" + id);
		final String sql = "SELECT * FROM SEAT WHERE EDA_ID = ?";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, new Object[] { id });
		List<Seat> seats = new ArrayList<>();
		for (Map m : list) {
			Seat seat = new Seat();
			seat.setId((Long) m.get("ID"));
			seat.setIsFree((Boolean) m.get("IS_FREE"));
			seat.setIsVip(false);// TODO vip doesnt work
			seat.setRow((Integer) m.get("ROW"));
			seat.setSeat((Integer) m.get("SEAT"));
			seats.add(seat);
		}
		return seats;
	}

	public Seat findById(Long id) {
		String sql1 = "SELECT * FROM SEAT WHERE ID = ?";
		Seat seat = jdbcTemplate.queryForObject(sql1, new Object[] { id }, (rs, i) -> {
			Seat s = new Seat();
			s.setId(rs.getLong("ID"));
			s.setIsFree(rs.getBoolean("IS_FREE"));
			s.setRow(rs.getInt("ROW"));
			s.setSeat(rs.getInt("SEAT"));
			return s;
		});
		return seat;
	}

	public void bookSeats(List<Long> ids) {
		String sql1 = "UPDATE SEAT SET IS_FREE = ? WHERE ID =?";
		for (Long id : ids) {
			jdbcTemplate.update(sql1, false, id);
		}
	}

	public void initializeSeats(int rows, int seatsInRow, Long eda_id) {
		logger.debug("init seats; eda_id=" + eda_id);
		final String sql = "INSERT INTO SEAT (IS_FREE,ROW,SEAT,EDA_ID) VALUES (?,?,?,?)";
		for (int r = 1; r <= rows; r++) {
			for (int s = 1; s <= seatsInRow; s++) {
				jdbcTemplate.update(sql, true, r, s, eda_id);
			}
		}
	}

}
