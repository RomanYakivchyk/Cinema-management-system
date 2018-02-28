package com.spring.controller;

import com.spring.domain.Auditorium;
import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.service.AuditoriumService;
import com.spring.service.EventService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class EventController {

	private final EventService eventService;
	private final AuditoriumService auditoriumService;

	@Autowired
	public EventController(EventService eventService, AuditoriumService auditoriumService) {
		this.eventService = eventService;
		this.auditoriumService = auditoriumService;
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

		List<EventDateAndAuditorium> todayEvents = new ArrayList<>();
		List<EventDateAndAuditorium> tomorrowEvents = new ArrayList<>();
		List<EventDateAndAuditorium> weekEvents = new ArrayList<>();
		LocalDate today = LocalDate.now();
		LocalDate tomorrow = today.plusDays(1);
		LocalDate inWeek = today.plusDays(7);

		for (EventDateAndAuditorium edaa : event.getDateAndAuditoriums()) {
			LocalDate eventStart = edaa.getStartTime().toLocalDate();
			if (today.equals(eventStart)) {
				todayEvents.add(edaa);
			}

			if (tomorrow.equals(eventStart)) {
				tomorrowEvents.add(edaa);
			}

			if (today.equals(eventStart) || inWeek.equals(eventStart)
					|| (eventStart.isAfter(today) && eventStart.isBefore(inWeek))) {
				weekEvents.add(edaa);
			}
		}

		model.addAttribute("todayEvents", todayEvents);
		model.addAttribute("tomorrowEvents", tomorrowEvents);
		model.addAttribute("weekEvents", weekEvents);
		return "events/event";
	}

	@RequestMapping(value = "/events/{id}/{dateTime}/{auditoriumName}/select_place", method = RequestMethod.GET)
	public String selectPlace(@PathVariable("dateTime") String ldt, @PathVariable("id") Long id,
			@PathVariable("auditoriumName") String auditoriumName, Model model) {

		Event event = eventService.findById(id);

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		LocalDateTime dateTime = LocalDateTime.parse(ldt, formatter);
		EventDateAndAuditorium eda = null;
		for (EventDateAndAuditorium item : event.getDateAndAuditoriums()) {
			if (item.getStartTime().equals(dateTime) && item.getAuditorium().getName().equals(auditoriumName)) {
				eda = item;
				break;
			}
		}
		if (null == eda) {
			throw new NullPointerException();
		}

		model.addAttribute("eda", eda);
		model.addAttribute("event", event);

		return "events/selectPlace";

	}
	
	
	
	@RequestMapping(value = "/movies", method = RequestMethod.GET)
	public String showAllEvents(Model model, @RequestParam(name = "page", required = true) Integer page) {
		int total = 2;
		int offset;
		if (page == null || page <= 0) {
			offset = 1;
		} else
			offset = (page - 1) * total + 1;

		int tmp = eventService.findAll().size() / total;
		
		System.out.println("tmp="+tmp);
		int numOfPages = 0;
		if(tmp==1) 
			numOfPages = 1;
		else if (tmp % 2 == 0)
			numOfPages = tmp;
		else
			numOfPages = tmp + 1;
		System.out.println("numOfPages="+numOfPages);
		int pageCountToDisplay = 2;

		model.addAttribute("pageCountToDisplay", pageCountToDisplay);
		model.addAttribute("numOfPages", numOfPages);
		List<Event> events = eventService.findAll(offset, total);
		model.addAttribute("events", events);
		return "events/allEvents";
	}
	
	
	@GetMapping("/getAllAuditoriums")
	@ResponseBody
	public List<Auditorium> getAllAuditoriums() {
		
		return auditoriumService.findAll();
		
	}

}
