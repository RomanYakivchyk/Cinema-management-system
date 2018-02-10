package com.spring.utility;

import org.springframework.core.convert.converter.Converter;



import com.spring.domain.Technology;

public class TechnologyConverter implements Converter<String, Technology> {

	public TechnologyConverter() {
	}

	@Override
	public Technology convert(String source) {
		if (source == null || source.isEmpty()) {
			return null;
		}

		return Technology.valueOf(source);
	}
}