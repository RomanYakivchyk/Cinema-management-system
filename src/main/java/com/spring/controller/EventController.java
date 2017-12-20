package com.spring.controller;

import com.spring.domain.Event;
import com.spring.service.AuditoriumService;
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

    private final AuditoriumService auditoriumService;

    @Autowired
    public EventController(EventService eventService, AuditoriumService auditoriumService) {
        this.eventService = eventService;
        this.auditoriumService = auditoriumService;
    }

    @RequestMapping(value = "/events", method = RequestMethod.GET)
    public String showAllEvents(Model model) {

//        logger.debug("showAllEvents()");
        model.addAttribute("events", eventService.findAll());
        return "events/list";
    }

}
