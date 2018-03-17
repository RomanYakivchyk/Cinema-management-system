package com.spring.controller;

import com.spring.dao.dao_impl.JDBCSeatDaoImpl;
import com.spring.domain.Auditorium;
import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.domain.Seat;
import com.spring.service.AuditoriumService;
import com.spring.service.EventService;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class EventController {
	private final Logger logger = LoggerFactory.getLogger(EventController.class);
	private final EventService eventService;
	private final AuditoriumService auditoriumService;

	@Autowired
	private JDBCSeatDaoImpl seatDaoImpl;

	@Autowired
	public EventController(EventService eventService, AuditoriumService auditoriumService) {
		this.eventService = eventService;
		this.auditoriumService = auditoriumService;
	}

	@RequestMapping(value = "/events/{id}", method = RequestMethod.GET)
	public String showEvent(@PathVariable("id") long id, Model model) {
		logger.debug("show event; id=" + id);
		Event event = eventService.findById(id);
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

	@RequestMapping(value = "/events/{id}/{eda_id}/select_place", method = RequestMethod.GET)
	public String selectPlace(@PathVariable Long id, @PathVariable Long eda_id, Model model) {
		logger.debug("select place; eda_id=" + eda_id);
		Event event = eventService.findById(id);
		EventDateAndAuditorium eda = event.getDateAndAuditoriums().stream().filter(item -> item.getId() == eda_id)
				.findFirst().get();

		Auditorium auditorium = auditoriumService.findById(eda.getAuditorium().getId());
		eda.setAuditorium(auditorium);

		model.addAttribute("eda", eda);
		model.addAttribute("event", event);

		return "events/selectPlace";

	}

	@RequestMapping(value = "/events/{id}/{eda_id}/verify", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public String verify(@PathVariable Long id, @PathVariable Long eda_id, @RequestBody List<Long> seatsId,Model model) {
		logger.debug("create ticket");
		seatDaoImpl.bookSeats(seatsId);
		//todo
		return "";

	}

	@RequestMapping(value = "/movies", method = RequestMethod.GET)
	public String showAllEvents(Model model, @RequestParam(name = "page", required = true) Integer page) {
		logger.debug("show all events on the page; page=" + page);
		int displayItemsOnPageNum = 2;
		int pageCountToDisplayOnPaginator = 2;

		int allEventsCount = eventService.findAll().size();
		int numOfPages;
		if (allEventsCount % displayItemsOnPageNum == 0) {
			numOfPages = allEventsCount / displayItemsOnPageNum;
		} else {
			numOfPages = allEventsCount / displayItemsOnPageNum + 1;
		}

		model.addAttribute("pageCountToDisplay", pageCountToDisplayOnPaginator);
		model.addAttribute("numOfPages", numOfPages);
		List<Event> events = eventService.findAll(page, displayItemsOnPageNum);
		model.addAttribute("events", events);
		return "events/allEvents";
	}

	@GetMapping("/getAllAuditoriums")
	@ResponseBody
	public List<Auditorium> getAllAuditoriums() {
		logger.debug("REST get all auditoriums event");
		return auditoriumService.findAll();

	}

	@GetMapping("/{eda_id}/getSeats")
	@ResponseBody
	public List<Seat> getSeats(@PathVariable Long eda_id) {
		logger.debug("REST get seats by eda_id; eda_id=" + eda_id);
		// return seatDaoImpl.findByEdaId(eda_id);
		List<Seat> list = seatDaoImpl.findByEdaId(eda_id);
		Seat s = list.get(5);
		s.setIsFree(false);
		list.set(5, s);
		return list;
	}

}
