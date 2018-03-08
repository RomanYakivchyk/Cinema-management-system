package com.spring.dao.dao_impl;

import com.spring.dao.AuditoriumDao;
import com.spring.dao.EventDao;
import com.spring.domain.Auditorium;
import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.domain.EventRating;
import com.spring.domain.Technology;
import com.spring.service.EventService;
import com.spring.utility.Utilities;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.*;
import java.util.stream.Collectors;

@Repository
public class JDBCEventDaoImpl implements EventDao {
	private final Logger logger = LoggerFactory.getLogger(JDBCEventDaoImpl.class);
	@Autowired
	private AuditoriumDao auditoriumDao;
	@Autowired
	private JDBCSeatDaoImpl seatDaoImpl;

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JDBCEventDaoImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public void create(Event event) {
		logger.debug("create event; event=" + event);
		final String sql1 = "INSERT INTO EVENT (NAME, BASE_PRICE, RATING, IMAGE_PATH, COUNTRY, YEAR,"
				+ " LANGUAGE, DIRECTED_BY, DESCRIPTION,DURATION_MIN,TECHNOLOGY,MIN_AGE) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
		final String sql2 = "INSERT INTO EVENT_DATE_AND_AUDITORIUM "
				+ "(EVENT_ID, START_DATE_TIME, END_DATE_TIME, AUDITORIUM_ID) VALUES (?, ?, ?, ?)";
		final String sql3 = "INSERT INTO GENRE_EVENT (GENRE_NAME,EVENT_ID) VALUES (?,?)";
		final String sql4 = "INSERT INTO ACTOR (NAME,EVENT_ID) VALUES (?,?)";

		jdbcTemplate.update(sql1, event.getName(), event.getBasePrice(), event.getRating().name(), event.getImagePath(),
				event.getCountry(), event.getYear(), event.getLanguage(), event.getDirectedBy(), event.getDescription(),
				event.getDurationMin(), event.getTechnology().name(),
				(null != event.getMinAge() && 0 != event.getMinAge()) ? event.getMinAge() : java.sql.Types.INTEGER);

		for (EventDateAndAuditorium eda : event.getDateAndAuditoriums()) {
			jdbcTemplate.update(sql2, event.getId(), eda.getStartTime(), eda.getEndTime(), eda.getAuditorium().getId());
			// init seats
			seatDaoImpl.initializeSeats(eda.getAuditorium().getRowNumber(), eda.getAuditorium().getSeatsInEachRow(),
					eda.getId());
		}
		for (String genre : event.getGenres()) {
			jdbcTemplate.update(sql3, genre, event.getId());
		}
		for (String actor : event.getActors()) {
			jdbcTemplate.update(sql4, actor, event.getId());
		}
	}

	@Override
	public void delete(Long id) {
		logger.debug("delete event; id=" + id);
		final String sql1 = "DELETE FROM GENRE_EVENT WHERE ID = ?";
		final String sql2 = "DELETE FROM ACTOR WHERE ID = ?";
		final String sql3 = "DELETE FROM EVENT_DATE_AND_AUDITORIUM WHERE EVENT_ID = ?";
		final String sql4 = "DELETE FROM EVENT WHERE ID = ?";
		jdbcTemplate.update(sql1, id);
		jdbcTemplate.update(sql2, id);
		jdbcTemplate.update(sql3, id);
		jdbcTemplate.update(sql4, id);
	}

	@Override
	public Event findById(Long id) {
		logger.debug("find event by id; id=" + id);
		final String sql1 = "SELECT * FROM EVENT WHERE ID = ?";
		final String sql2 = "SELECT ID, START_DATE_TIME, END_DATE_TIME, AUDITORIUM_ID FROM EVENT_DATE_AND_AUDITORIUM WHERE EVENT_ID = ?";
		final String sql3 = "SELECT GENRE_NAME FROM GENRE_EVENT WHERE EVENT_ID = ?";
		final String sql4 = "SELECT NAME FROM ACTOR WHERE EVENT_ID = ?";

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
		logger.debug("find all events");
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

	@Override
	public List<Event> findAll(int page, int total) {
		logger.debug("find all events on page" + page);
		final String sql1 = "SELECT * FROM EVENT LIMIT " + ((page - 1) * total) + "," + total;
		List<Event> events = new ArrayList<>();
		List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql1);
		for (Map row : rows) {
			Long id = (Long) row.get("ID");
			Event event = findById(id);
			events.add(event);
		}
		return events;
	}

	@Override
	public void update(Event event) {
		logger.debug("update event; event=" + event);
		final String sql1 = "UPDATE EVENT SET NAME = ?, BASE_PRICE = ?, RATING = ?, "
				+ "  IMAGE_PATH = ?, COUNTRY = ?, YEAR = ?, LANGUAGE = ?, DIRECTED_BY = ?, "
				+ "DESCRIPTION = ? ,DURATION_MIN = ? ,TECHNOLOGY = ? ,MIN_AGE = ? WHERE ID = ?";

		final String sql2 = "DELETE FROM EVENT_DATE_AND_AUDITORIUM WHERE ID = ?";
		final String sql3 = "INSERT INTO EVENT_DATE_AND_AUDITORIUM "
				+ "(EVENT_ID, START_DATE_TIME, END_DATE_TIME, AUDITORIUM_ID) VALUES (?, ?, ?, ?)";

		final String sql4 = "DELETE FROM GENRE_EVENT WHERE EVENT_ID = ?";
		final String sql5 = "INSERT INTO GENRE_EVENT (GENRE_NAME, EVENT_ID) VALUES (?, ?)";

		final String sql6 = "DELETE FROM ACTOR WHERE EVENT_ID = ?";
		final String sql7 = "INSERT INTO ACTOR (NAME,EVENT_ID) VALUES (?, ?)";

		logger.debug("update Event table");
		jdbcTemplate.update(sql1, event.getName(), event.getBasePrice(), event.getRating().name(), event.getImagePath(),
				event.getCountry(), event.getYear(), event.getLanguage(), event.getDirectedBy(), event.getDescription(),
				event.getDurationMin(), event.getTechnology().name(), event.getMinAge(), event.getId());

		List<Long> oldIds = jdbcTemplate.queryForList("SELECT ID FROM EVENT_DATE_AND_AUDITORIUM WHERE EVENT_ID = ?",
				new Object[] { event.getId() }, Long.class);
		logger.debug("old eda ids:" + oldIds);
		List<Long> newIds = event.getDateAndAuditoriums().stream().map(EventDateAndAuditorium::getId)
				.collect(Collectors.toList());
		logger.debug("new eda ids:" + newIds);
		// delete removed eda
		for (Long id : oldIds) {
			if (!newIds.contains(id)) {
				logger.debug("delete eda; eda_id=" + id);
				jdbcTemplate.update("DELETE FROM SEAT WHERE EDA_ID =?", id);
				jdbcTemplate.update(sql2, id);
			}
		}

		// insert newly added eda
		for (EventDateAndAuditorium eda : event.getDateAndAuditoriums()) {
			if (Utilities.isNew(eda)) {

				KeyHolder keyHolder = new GeneratedKeyHolder();
				jdbcTemplate.update(con -> {
					PreparedStatement pst = con.prepareStatement(sql3, new String[] { "ID" });
					pst.setLong(1, event.getId());
					pst.setTimestamp(2, Timestamp.valueOf(eda.getStartTime()));
					pst.setTimestamp(3, Timestamp.valueOf(eda.getEndTime()));
					pst.setLong(4, eda.getAuditorium().getId());
					return pst;
				}, keyHolder);
				eda.setId(keyHolder.getKey().longValue());
				logger.debug("insert new eda; eda_id=" + eda.getId());

				Auditorium auditorium = auditoriumDao.findById(eda.getAuditorium().getId());

				seatDaoImpl.initializeSeats(auditorium.getRowNumber(), auditorium.getSeatsInEachRow(), eda.getId());
			}
		}

		jdbcTemplate.update(sql4, event.getId());
		for (String genre : event.getGenres()) {
			jdbcTemplate.update(sql5, genre, event.getId());
		}

		jdbcTemplate.update(sql6, event.getId());
		for (String actor : event.getActors()) {
			jdbcTemplate.update(sql7, actor, event.getId());
		}
	}

	private List<EventDateAndAuditorium> populateList(List<Map<String, Object>> list) {
		List<EventDateAndAuditorium> dateAndAuditoriums = new ArrayList<>();
		for (Map m : list) {
			EventDateAndAuditorium eda = new EventDateAndAuditorium();
			eda.setId((Long) m.get("ID"));
			eda.setStartTime(((Timestamp) m.get("START_DATE_TIME")).toLocalDateTime());
			eda.setEndTime(((Timestamp) m.get("END_DATE_TIME")).toLocalDateTime());
			eda.setAuditorium(auditoriumDao.findById((Long) m.get("AUDITORIUM_ID")));
			dateAndAuditoriums.add(eda);
		}
		return dateAndAuditoriums;
	}
}
