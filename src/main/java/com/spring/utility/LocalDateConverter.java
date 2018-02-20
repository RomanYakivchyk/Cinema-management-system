package com.spring.utility;

import org.springframework.core.convert.converter.Converter;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
 
public final class LocalDateConverter implements Converter<String, LocalDate> {
 
    private final DateTimeFormatter formatter;
 
    public LocalDateConverter(String dateFormat) {
        this.formatter = DateTimeFormatter.ofPattern(dateFormat,Locale.ENGLISH);
    }
 
    @Override
    public LocalDate convert(String source) {
        if (source == null || source.isEmpty()) {
            return null;
        }
 
        return LocalDate.parse(source, formatter);
    }
}