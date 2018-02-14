package com.spring.controller;

import com.spring.domain.Event;
import com.spring.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class EventController {

	private final EventService eventService;

	@Autowired
	public EventController(EventService eventService) {
		this.eventService = eventService;
	}

	@RequestMapping(value = "/movies", method = RequestMethod.GET)
	public String showAllEvents(Model model) {

		model.addAttribute("events", eventService.findAll());
		return "events/allEvents";
	}

	@RequestMapping(value = "/events/{id}", method = RequestMethod.GET)
	public String showEvent(@PathVariable("id") long id, Model model) {
		// logger.debug("showEvent() id=", id);
		Event event = eventService.findById(id);
		// if (event == null) {
		// model.addAttribute("css", "danger");
		// model.addAttribute("msg", "Event not found");
		// }
		model.addAttribute("event", event);

		// return "events/admin/show";

		return "events/event";
	}

}
