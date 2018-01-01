package com.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabase;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseBuilder;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseType;

import javax.sql.DataSource;
import javax.xml.crypto.Data;

@Configuration
public class JdbcConfig {

    @Bean
    public DataSource getDataSource() {

//        DriverManagerDataSource dataSource = new DriverManagerDataSource();
//        dataSource.setDriverClassName("org.h2.Driver");
//        dataSource.setUrl("jdbc:h2:~/test");//change url
//        dataSource.setUsername("sa");//change userid
//        dataSource.setPassword("");//change pwd
//        return dataSource;
////
        EmbeddedDatabaseBuilder builder = new EmbeddedDatabaseBuilder();
        EmbeddedDatabase db = builder.setName("testdb")
                .setType(EmbeddedDatabaseType.H2)
                .addScript("db/sql/create-event-table.sql")
                .addScript("db/sql/populate-event-table.sql")

                .addScript("db/sql/create-event-date-and-aud-table.sql")
                .addScript("db/sql/populate-event-date-and-aud-table.sql")

                .addScript("db/sql/create-role-table.sql")
                .addScript("db/sql/populate-role-table.sql")

                .addScript("db/sql/create-user-table.sql")
                .addScript("db/sql/populate-user-tabl.sql")

                .addScript("db/sql/create-user_role-table.sql")
                .addScript("db/sql/populate-user_role-table.sql")
                .build();

        return db;
    }


    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        jdbcTemplate.setResultsMapCaseInsensitive(true);
        return jdbcTemplate;
    }


}
