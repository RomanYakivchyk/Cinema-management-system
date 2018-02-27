package com.spring.dao.dao_impl;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.spring.dao.AuditoriumDao;
import com.spring.domain.Auditorium;
import com.spring.domain.Seat;

@Repository
public class JDBCAuditoriumDaoImpl implements AuditoriumDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public List<Auditorium> findAll() {
		// TODO Auto-generated method stub
		final String sql1 = "SELECT * FROM AUDITORIUM";
		List<Auditorium> auditoriums = new ArrayList<>();
		List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql1);
		for (Map row : rows) {
			Long id = (Long) row.get("ID");
			Auditorium auditorium = findById(id);
			auditoriums.add(auditorium);
		}
		return auditoriums;
	}

	@Override
	public Auditorium findById(Long id) {
		// TODO Auto-generated method stub
		final String sql = "SELECT * FROM AUDITORIUM WHERE ID = ?";
		final String sql2 = "SELECT * FROM SEAT WHERE AUDITORIUM_ID = ?";
		Auditorium auditorium = jdbcTemplate.queryForObject(sql, new Object[] { id }, (resultSet, i) -> {
			Auditorium audRowMapper = new Auditorium();
			audRowMapper.setId(resultSet.getLong("ID"));
			audRowMapper.setName(resultSet.getString("NAME"));
			return audRowMapper;
		});
		
		Set<Seat> seats = new HashSet<>();
		List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql2, new Object[] {id});
        for (Map row : rows) {
            Seat seat = new Seat();
            seat.setId((Long) row.get("ID"));
            seat.setIsFree((Boolean)row.get("IS_FREE"));
            seat.setIsVip((Boolean)row.get("IS_VIP"));
            seat.setRow((Integer)row.get("ROW"));
            seat.setSeat((Integer)row.get("SEAT"));
            seats.add(seat);
        }
		auditorium.setSeats(seats);
		
		return auditorium;
	}

	@Override
	public Auditorium create(Auditorium auditorium) {
		// TODO Auto-generated method stub
		final String sql1 = "INSERT INTO AUDITORIUM (NAME) VALUES (?)";
		final String sql2 = "INSERT INTO SEAT(IS_FREE,IS_VIP,ROW_NUM,SEAT_NUM) VALUES(?,?,?,?)";

		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(con -> {
			PreparedStatement pst = con.prepareStatement(sql1, new String[] { "ID" });
			pst.setString(1, auditorium.getName());
			return pst;
		}, keyHolder);
		auditorium.setId(keyHolder.getKey().longValue());

		for (Seat seat : auditorium.getSeats())
			jdbcTemplate.update(sql2, seat.getIsFree(),seat.getIsVip(), seat.getRow(), seat.getSeat());

		return auditorium;
	}

	@Override
	public Auditorium update(Auditorium auditorium) {
		// TODO Auto-generated method stub
		final String sql1 = "UPDATE AUDITORIUM SET NAME = ? WHERE ID = ?";
		
		final String sql2 = "DELETE FROM SEAT WHERE AUDITORIUM_ID = ?";
		final String sql3 = "INSERT INTO SEAT(IS_FREE,IS_VIP,ROW_NUM,SEAT_NUM) VALUES(?,?,?,?)";


		jdbcTemplate.update(sql1, auditorium.getName(), auditorium.getId());

		jdbcTemplate.update(sql2, auditorium.getId());
		for (Seat seat : auditorium.getSeats()) {
			jdbcTemplate.update(sql3, seat.getIsFree(),seat.getIsVip(),seat.getRow(),seat.getSeat());
		}

		return auditorium;
	}

	@Override
	public void delete(Auditorium auditorium) {
		// TODO Auto-generated method stub
		
		final String sql1 = "DELETE FROM SEAT WHERE AUDITORIUM_ID = ?";
		final String sql2 = "DELETE FROM AUDITORIUM WHERE ID = ?";

		jdbcTemplate.update(sql1, auditorium.getId());
		jdbcTemplate.update(sql2, auditorium.getId());

	}

}
