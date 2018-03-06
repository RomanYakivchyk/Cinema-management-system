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

@Repository
public class JDBCAuditoriumDaoImpl implements AuditoriumDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public List<Auditorium> findAll() {
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
	public Auditorium findById(long id) {
		final String sql = "SELECT * FROM AUDITORIUM WHERE ID = ?";
		Auditorium auditorium = jdbcTemplate.queryForObject(sql, new Object[] { id }, (resultSet, i) -> {
			Auditorium audRowMapper = new Auditorium();
			audRowMapper.setId(resultSet.getLong("ID"));
			audRowMapper.setName(resultSet.getString("NAME"));
			return audRowMapper;
		});
		
		return auditorium;
	}

	@Override
	public void create(Auditorium auditorium) {
		final String sql1 = "INSERT INTO AUDITORIUM (NAME) VALUES (?)";
		jdbcTemplate.update(sql1,new Object[] {auditorium.getName()});
	}

	@Override
	public void update(Auditorium auditorium) {
		final String sql1 = "UPDATE AUDITORIUM SET NAME = ? WHERE ID = ?";
		jdbcTemplate.update(sql1, auditorium.getName(), auditorium.getId());
	}


	@Override
	public void delete(long id) {
		final String sql2 = "DELETE FROM AUDITORIUM WHERE ID = ?";
		jdbcTemplate.update(sql2, id);
	}


}