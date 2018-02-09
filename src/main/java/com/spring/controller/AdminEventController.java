package com.spring.controller;

import com.spring.dao.AuditoriumDao;

import com.spring.domain.Auditorium;
import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.domain.EventRating;
import com.spring.domain.Technology;
import com.spring.service.AuditoriumService;
import com.spring.service.EventService;
import com.spring.service.GenreService;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.security.crypto.codec.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletContext;

@Controller
public class AdminEventController {
	//
	// private static final Logger logger
	// = LoggerFactory.getLogger(EventController.class);

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

	// show event
	@RequestMapping(value = "/admin/events/{id}", method = RequestMethod.GET)
	public String showEvent(@PathVariable("id") long id, Model model) {
		// logger.debug("showEvent() id=", id);
		Event event = eventService.findById(id);
		// if (event == null) {
		// model.addAttribute("css", "danger");
		// model.addAttribute("msg", "Event not found");
		// }
		model.addAttribute("event", event);
		return "events/admin/show";
	}

	// delete event
	@RequestMapping(value = "/admin/events/{id}/delete", method = RequestMethod.GET)
	public String deleteEvent(@PathVariable("id") long id, final RedirectAttributes redirectAttributes) {

		// logger.debug("deleteEvent() id=", id);

		eventService.delete(id);

		// redirectAttributes.addFlashAttribute("css", "success");
		// redirectAttributes.addFlashAttribute("msg", "Event is deleted!");

		return "redirect:/admin/events";

	}

	// todo
	@RequestMapping(value = "/admin/events/{id}/update", method = RequestMethod.GET)
	public String showUpdateEventForm(@PathVariable("id") long id, Model model) {

		// logger.debug("showUpdateEventForm() id=", id);

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

		// logger.debug("showAddEventForm()");
		Event event = new Event();
		model.addAttribute("event", event);
		model.addAttribute("eventRatings", EventRating.values());
		model.addAttribute("technologies", Technology.values());
		model.addAttribute("auditoriums", auditoriumService.findAll());
		model.addAttribute("genres", genreService.findAll());
		return "events/admin/eventForm";
	}

	@RequestMapping(value = "/admin/events", method = RequestMethod.POST)
	public String createOrUpdateEvent(@ModelAttribute("event") Event event, BindingResult result,
			final RedirectAttributes redirectAttributes) {

		// logger.debug("createOrUpdateEvent() event=", event);

		if (result.hasErrors()) {
			System.out.println(result.getFieldError());
			return "events/admin/eventForm";
		} else {

			redirectAttributes.addFlashAttribute("css", "success");
			if (event.isNew()) {
				redirectAttributes.addFlashAttribute("msg", "Event added successfully!");
			} else {
				redirectAttributes.addFlashAttribute("msg", "Event updated successfully!");
			}

			System.out.println(event);
			event.setDateAndAuditoriums(removeInvalidItems(event.getDateAndAuditoriums()));
			File image = null;
			try {
				image = new File(context.getRealPath("/") + "/resources/images/events/" + event.getName() + ".png");
				if (image.exists()) {
					image.delete();
				}
				FileOutputStream fos = new FileOutputStream(image);
				fos.write(event.getImage().getBytes());
				fos.close();
				System.out.println(image.getAbsolutePath() + " , name " + image.getName());
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			// TODO
			event.setImagePath("events/" + image.getName());
			System.out.println(image.getName()+"---"+image.getPath());
			eventService.saveOrUpdate(event);
			return "redirect:/admin/events";
		}
	}

	@RequestMapping(value = "/admin/events", method = RequestMethod.GET)
	public String showAllEvents(Model model) {

		// logger.debug("showAllEvents()");
		model.addAttribute("events", eventService.findAll());
		return "events/admin/list";
	}

	private List<EventDateAndAuditorium> removeInvalidItems(List<EventDateAndAuditorium> dateAndAuditoriums) {
		List<EventDateAndAuditorium> resultList = new ArrayList<>();
		for (EventDateAndAuditorium dateAndAuditorium : dateAndAuditoriums) {
			if (!"".equals(dateAndAuditorium.getAuditoriumName()) && dateAndAuditorium.getStartTime() != null
					&& dateAndAuditorium.getStartTime() != null) {
				resultList.add(dateAndAuditorium);
			}
		}
		return resultList;
	}

}
