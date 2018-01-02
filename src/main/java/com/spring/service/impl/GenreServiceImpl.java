package com.spring.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.dao.GenreDao;
import com.spring.service.GenreService;

@Service
public class GenreServiceImpl implements GenreService {

	@Autowired
	private GenreDao genreDao;
	
	@Override
	public List<String> findAll() {
		return genreDao.findAll();
	}

}
