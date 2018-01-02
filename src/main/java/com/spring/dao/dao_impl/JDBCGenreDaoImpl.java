package com.spring.dao.dao_impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.spring.dao.GenreDao;

@Repository
public class JDBCGenreDaoImpl implements GenreDao {
	
	 private JdbcTemplate jdbcTemplate;

	    @Autowired
	    public JDBCGenreDaoImpl(JdbcTemplate jdbcTemplate) {
	        this.jdbcTemplate = jdbcTemplate;
	    }

	   @Override
	    public List<String> findAll() {
	        final String sql = "SELECT * FROM GENRE";
	        return jdbcTemplate.queryForList(sql, String.class);
	    }
	    
	    
	    
	    

}
