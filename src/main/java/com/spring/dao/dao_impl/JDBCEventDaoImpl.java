package com.spring.dao.dao_impl;

import com.spring.dao.EventDao;
import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.domain.EventRating;
import com.spring.domain.Technology;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.*;

@Repository
public class JDBCEventDaoImpl implements EventDao {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JDBCEventDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public Event create(Event event) {
		final String sql1 = "INSERT INTO EVENT (NAME, BASE_PRICE, RATING, IMAGE_PATH, COUNTRY, YEAR, LANGUAGE, DIRECTED_BY, DESCRIPTION,DURATION_MIN,TECHNOLOGY,MIN_AGE) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
		final String sql2 = "INSERT INTO EVENT_DATE_AND_AUDITORIUM "
				+ "(EVENT_ID, START_DATE_TIME, END_DATE_TIME, AUDITORIUM_NAME) VALUES (?, ?, ?, ?)";
		final String sql3 = "INSERT INTO GENRE_EVENT (GENRE_NAME,EVENT_ID) VALUES (?,?)";
		final String sql4 = "INSERT INTO ACTOR (NAME,EVENT_ID) VALUES (?,?)";
		KeyHolder keyHolder = new GeneratedKeyHolder();
		jdbcTemplate.update(con -> {
			PreparedStatement pst = con.prepareStatement(sql1, new String[] { "ID" });
			pst.setString(1, event.getName());
			pst.setDouble(2, event.getBasePrice());
			pst.setString(3, event.getRating().name());
			return pst;
		}, keyHolder);
		event.setId((Long) keyHolder.getKey());
		for (EventDateAndAuditorium entry : event.getDateAndAuditoriums()) {
			jdbcTemplate.update(sql2, event.getId(), entry.getStartTime(), entry.getEndTime(),
					entry.getAuditoriumName());
		}
		for (String genre : event.getGenres()) {
			jdbcTemplate.update(sql3, event.getId(), genre, event.getId());
		}
		for (String actor : event.getActors()) {
			jdbcTemplate.update(sql4, event.getId(), actor, event.getId());
		}
		return event;
	}

	@Override
	public void delete(long id) {
		final String sql1 = "DELETE FROM EVENT_DATE_AND_AUDITORIUM WHERE EVENT_ID = ?";
		final String sql2 = "DELETE FROM EVENT WHERE ID = ?";
		final String sql3 = "DELETE FROM GENRE_EVENT WHERE ID = ?";
		final String sql4 = "DELETE FROM ACTOR WHERE ID = ?";

		jdbcTemplate.update(sql1, id);
		jdbcTemplate.update(sql2, id);
		jdbcTemplate.update(sql3, id);
		jdbcTemplate.update(sql4, id);
	}

	@Override
	public Event findById(long id) {
		final String sql1 = "SELECT * FROM EVENT WHERE ID = ?";
		final String sql2 = "SELECT START_DATE_TIME,END_DATE_TIME, AUDITORIUM_NAME FROM EVENT_DATE_AND_AUDITORIUM WHERE EVENT_ID = ?";
		final String sql3 = "SELECT GENRE_NAME,EVENT_ID FROM GENRE_EVENT WHERE EVENT_ID = ?";
		final String sql4 = "SELECT NAME,EVENT_ID FROM ACTOR WHERE EVENT_ID = ?";

		Event event = jdbcTemplate.queryForObject(sql1, new Object[] { id }, (rs, i) -> {
			Event e = new Event();
			e.setId(rs.getLong("ID"));
			e.setName(rs.getString("NAME"));
			e.setBasePrice(rs.getDouble("BASE_PRICE"));
			e.setRating(EventRating.valueOf(rs.getString("RATING")));
			e.setImagePath(rs.getString("IMAGE_PATH"));
			e.setCountry(rs.getString("COUNTRY"));
			e.setYear(rs.getInt("YEAR"));
			e.setLanguage(rs.getString("LANGUAGE"));
			e.setDirectedBy(rs.getString("DIRECTED_BY"));
			e.setDescription(rs.getString("DESCRIPTION"));
			e.setDurationMin(rs.getInt("DURATION_MIN"));
			e.setTechnology(Technology.valueOf(rs.getString("TECHNOLOGY")));
			e.setMinAge(rs.getInt("MIN_AGE"));
			return e;
		});

		List<EventDateAndAuditorium> dateAndAudList = populateList(jdbcTemplate.queryForList(sql2, event.getId()));
		event.setDateAndAuditoriums(dateAndAudList);
		List<String> genres = jdbcTemplate.queryForList(sql3, new Object[] { event.getId() }, String.class);
		event.setGenres(genres);
		List<String> actors = jdbcTemplate.queryForList(sql4, new Object[] { event.getId() }, String.class);
		event.setActors(actors);
		return event;
	}

	@Override
	public List<Event> findAll() {
		final String sql1 = "SELECT * FROM EVENT";
		List<Event> events = new ArrayList<>();
		List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql1);
		for (Map row : rows) {
			Long id = (Long) row.get("ID");
			Event event = findById(id);
			events.add(event);
		}
		return events;
	}

	@Override // todo!!! update with no data deletes previous data
	public Event update(Event event) {

		final String sql1 = "UPDATE EVENT SET NAME = ?, BASE_PRICE = ?, RATING = ? WHERE ID = ?";
		final String sql2 = "DELETE FROM EVENT_DATE_AND_AUDITORIUM WHERE EVENT_ID = ?";
		final String sql3 = "INSERT INTO EVENT_DATE_AND_AUDITORIUM "
				+ "(EVENT_ID, START_DATE_TIME, END_DATE_TIME, AUDITORIUM_NAME) VALUES (?, ?, ?, ?)";

		final String sql4 = "DELETE FROM GENRE_EVENT WHERE EVENT_ID = ?";
		final String sql5 = "INSERT INTO GENRE_EVENT (GENRE_NAME, EVENT_ID) VALUES (?, ?)";

		final String sql6 = "DELETE FROM ACTOR WHERE EVENT_ID = ?";
		final String sql7 = "INSERT INTO ACTOR (NAME,EVENT_ID) VALUES (?, ?)";

		jdbcTemplate.update(sql1, event.getName(), event.getBasePrice(), event.getRating().name(), event.getId());

		jdbcTemplate.update(sql2, event.getId());
		for (EventDateAndAuditorium entry : event.getDateAndAuditoriums()) {
			jdbcTemplate.update(sql3, event.getId(), entry.getStartTime(), entry.getEndTime(),
					entry.getAuditoriumName());
		}

		jdbcTemplate.update(sql4, event.getId());
		for (String genre : event.getGenres()) {
			jdbcTemplate.update(sql5, genre, event.getId());
		}

		jdbcTemplate.update(sql6, event.getId());
		for (String actor : event.getActors()) {
			jdbcTemplate.update(sql7, actor, event.getId());
		}

		return event;
	}

	private List<EventDateAndAuditorium> populateList(List<Map<String, Object>> list) {
		List<EventDateAndAuditorium> dateAndAuditoriums = new ArrayList<>();
		for (Map m : list) {
			EventDateAndAuditorium eda = new EventDateAndAuditorium();
			eda.setStartTime(((Timestamp) m.get("START_DATE_TIME")).toLocalDateTime());
			eda.setEndTime(((Timestamp) m.get("END_DATE_TIME")).toLocalDateTime());
			eda.setAuditoriumName((String) m.get("AUDITORIUM_NAME"));
			dateAndAuditoriums.add(eda);
		}
		return dateAndAuditoriums;
	}
}
