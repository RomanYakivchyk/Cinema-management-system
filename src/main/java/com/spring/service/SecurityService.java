package com.spring.service;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public interface SecurityService {

     String findLoggedInUsername();
     void autoLogin(String username, String password);
}
