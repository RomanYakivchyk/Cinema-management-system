package com.spring.controller;

import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.domain.EventRating;
import com.spring.domain.Technology;
import com.spring.service.AuditoriumService;
import com.spring.service.EventService;
import com.spring.service.GenreService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletContext;

@Controller
public class AdminEventController {
	private final Logger logger = LoggerFactory.getLogger(AdminEventController.class);
	private final EventService eventService;

	private final AuditoriumService auditoriumService;

	private final GenreService genreService;

	private ServletContext context;

	public ServletContext getContext() {
		return context;
	}

	@Autowired
	public void setContext(ServletContext context) {
		this.context = context;
	}

	@Autowired
	public AdminEventController(EventService eventService, AuditoriumService auditoriumService,
			GenreService genreService) {
		this.eventService = eventService;
		this.auditoriumService = auditoriumService;
		this.genreService = genreService;
	}


	@RequestMapping(value = "/admin/events/{id}/delete", method = RequestMethod.GET)
	public String deleteEvent(@PathVariable("id") long id, final RedirectAttributes redirectAttributes) {
		logger.debug("delete event; id="+id);
		eventService.delete(id);
		return "redirect:/admin/events";

	}

	@RequestMapping(value = "/admin/events/{id}/update", method = RequestMethod.GET)
	public String showUpdateEventForm(@PathVariable("id") long id, Model model) {
		logger.debug("update event; id="+id);
		Event event = eventService.findById(id);
		model.addAttribute("event", event);
		model.addAttribute("eventRatings", EventRating.values());
		model.addAttribute("technologies", Technology.values());
		model.addAttribute("auditoriums", auditoriumService.findAll());
		model.addAttribute("genres", genreService.findAll());
		return "events/admin/eventForm";

	}

	@RequestMapping(value = "/admin/events/add", method = RequestMethod.GET)
	public String showAddEventForm(Model model) {
		logger.debug("create new event");
		Event event = new Event();
		model.addAttribute("event", event);
		model.addAttribute("eventRatings", EventRating.values());
		model.addAttribute("technologies", Technology.values());
		model.addAttribute("auditoriums", auditoriumService.findAll());
		model.addAttribute("genres", genreService.findAll());
		return "events/admin/eventForm";
	}

	@RequestMapping(value = "/admin/events", method = RequestMethod.POST)
	public String createOrUpdateEvent(@ModelAttribute("event") Event event, BindingResult result) {
		logger.debug("event creted/updated; event="+event);
			List<EventDateAndAuditorium> validList = removeInvalidItems(event.getDateAndAuditoriums());
			List<EventDateAndAuditorium> sortedList = sortByDate(validList);
			event.setDateAndAuditoriums(sortedList);
			
			//TODO add validation of image in eventForm.jsp!
			
			
			try {
				if (event.getImage() == null || event.getImage().getBytes().length != 0) {
					File image = null;

					image = new File(context.getRealPath("/") + "/resources/images/events/" + event.getName() + ".png");
					if (image.exists()) {
						image.delete();
					}
					FileOutputStream fos = new FileOutputStream(image);
					fos.write(event.getImage().getBytes());
					fos.close();
					event.setImagePath("events/" + image.getName());
				} else {
					event.setImagePath(eventService.findById(event.getId()).getImagePath());
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			eventService.saveOrUpdate(event);
			
			
			return "redirect:/admin/events";
		

	}

	@RequestMapping(value = "/admin/events", method = RequestMethod.GET)
	public String showAllEvents(Model model) {
		logger.debug("show all events");
		model.addAttribute("events", eventService.findAll());
		return "events/admin/list";
	}

	private List<EventDateAndAuditorium> removeInvalidItems(List<EventDateAndAuditorium> dateAndAuditoriums) {
		logger.debug("remove invalid items");
		List<EventDateAndAuditorium> resultList = new ArrayList<>();
		for (EventDateAndAuditorium dateAndAuditorium : dateAndAuditoriums) {
			if (dateAndAuditorium.getStartTime() != null && dateAndAuditorium.getEndTime() != null) {
				resultList.add(dateAndAuditorium);
			}
		}
		return resultList;
	}

	private List<EventDateAndAuditorium> sortByDate(List<EventDateAndAuditorium> dateAndAuditoriums) {
		logger.debug("sort by date");
		List<EventDateAndAuditorium> sortedList = dateAndAuditoriums;
		Collections.sort(dateAndAuditoriums, new Comparator<EventDateAndAuditorium>() {
			public int compare(EventDateAndAuditorium e1, EventDateAndAuditorium e2) {
				return e1.getStartTime().isBefore(e2.getStartTime()) ? -1
						: e1.getStartTime().isAfter(e2.getStartTime()) ? 1 : 0;
			}
		});

		return sortedList;
	}

}
