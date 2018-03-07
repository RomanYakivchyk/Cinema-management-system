package com.spring.utility;

import com.spring.domain.DomainObject;

public class Utilities {
	public static Boolean isNew(DomainObject object) {
		return object.getId() == null;
	}
}
