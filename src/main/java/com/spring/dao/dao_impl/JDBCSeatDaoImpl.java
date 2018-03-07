package com.spring.dao.dao_impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.domain.Seat;

@Repository
public class JDBCSeatDaoImpl {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public List<Seat> findByEdaId(Long id) {
		final String sql = "SELECT * FROM SEAT WHERE EDA_ID = ?";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, new Object[] { id });
		List<Seat> seats = new ArrayList<>();
		for (Map m : list) {
			Seat seat = new Seat();
			seat.setId((Long) m.get("ID"));
			seat.setIsFree((Boolean) m.get("IS_FREE"));
			seat.setIsVip(false);//TODO vip doesnt work
			seat.setRow((Integer) m.get("ROW"));
			seat.setSeat((Integer) m.get("SEAT"));
			seats.add(seat);
		}
		return seats;
	}

	public void initializeSeats(int rows, int seatsInRow, Long eda_id) {

		final String sql = "INSERT INTO SEAT (IS_FREE,ROW,SEAT,EDA_ID) VALUES (?,?,?,?)";

		for (int r = 1; r <= rows; r++) {
			for (int s = 1; s <= seatsInRow; s++) {
				jdbcTemplate.update(sql, true, r, s, eda_id);
			}
		}
	}

}
