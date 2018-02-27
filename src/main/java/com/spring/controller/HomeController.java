package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.service.EventService;

@Controller
public class HomeController {

	       private final EventService eventService;
	   	   
	       @Autowired
	       public HomeController(EventService eventService) {
	           this.eventService = eventService;
	       }
	   
	       @RequestMapping(value = "/", method = RequestMethod.GET)
	       public String showAllEvents(Model model) {	   
	           model.addAttribute("events", eventService.findAll());
	           return "index";
	       }
}
