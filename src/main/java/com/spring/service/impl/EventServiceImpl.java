package com.spring.service.impl;

import com.spring.dao.EventDao;
import com.spring.domain.Event;
import com.spring.service.EventService;
import com.spring.utility.Utilities;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Nonnull;
import java.util.Collection;
import java.util.List;

@Service
public class EventServiceImpl implements EventService {

	@Autowired
	private EventDao eventDao;

	public void setEventDao(EventDao eventDao) {
		this.eventDao = eventDao;
	}

	@Override
	public Event findByName(String name) {
		for (Event event : findAll()) {
			if (name.equals(event.getName())) {
				return event;
			}
		}
		return null;
	}

	@Override
	public void saveOrUpdate(@Nonnull Event event) {
		if (Utilities.isNew(event))
			eventDao.create(event);
		else
			eventDao.update(event);
	}

	@Override
	public void delete(long id) {
		eventDao.delete(id);
	}

	@Override
	public Event findById(@Nonnull Long id) {
		return eventDao.findById(id);
	}

	@Override
	public Collection<Event> findAll() {
		return eventDao.findAll();
	}

	@Override
	public List<Event> findAll(int page, int total) {
		return eventDao.findAll(page, total);
	}

}
