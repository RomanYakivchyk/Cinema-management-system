package com.spring.dao;


import java.util.List;

import com.spring.domain.Event;

public interface
EventDao extends AbstractDao<Event> {
	List<Event> findAll(int page, int total);
}
