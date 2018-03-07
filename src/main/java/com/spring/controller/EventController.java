package com.spring.controller;

import com.spring.dao.dao_impl.JDBCSeatDaoImpl;
import com.spring.domain.Auditorium;
import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.domain.Seat;
import com.spring.service.AuditoriumService;
import com.spring.service.EventService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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
	private JDBCSeatDaoImpl seatDaoImpl;

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
			System.out.println(edaa.getId());
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
		for(EventDateAndAuditorium item : todayEvents) {
			
			System.out.println(item.getId());
			
		}
		model.addAttribute("tomorrowEvents", tomorrowEvents);
		model.addAttribute("weekEvents", weekEvents);
		return "events/event";
	}

	@RequestMapping(value = "/events/{id}/{eda_id}/select_place", method = RequestMethod.GET)
	public String selectPlace(@PathVariable Long id, @PathVariable Long eda_id, Model model) {

		Event event = eventService.findById(id);
		EventDateAndAuditorium eda = event.getDateAndAuditoriums().stream().filter(item -> item.getId() == eda_id)
				.findFirst().get();

		if (null == eda) {
			throw new NullPointerException();
		}

		Auditorium auditorium = auditoriumService.findById(eda.getAuditorium().getId());
		eda.setAuditorium(auditorium);

		model.addAttribute("eda", eda);
		model.addAttribute("event", event);

		return "events/selectPlace";

	}

	@RequestMapping(value = "/movies", method = RequestMethod.GET)
	public String showAllEvents(Model model, @RequestParam(name = "page", required = true) Integer page) {
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

		return auditoriumService.findAll();

	}

	@GetMapping("/{eda_id}/getSeats")
	@ResponseBody
	public List<Seat> getSeats(@PathVariable Long eda_id) {
		return seatDaoImpl.findByEdaId(eda_id);

	}

}
