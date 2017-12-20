package com.spring.controller;

import com.spring.dao.AuditoriumDao;
import com.spring.domain.Auditorium;
import com.spring.domain.Event;
import com.spring.domain.EventDateAndAuditorium;
import com.spring.service.AuditoriumService;
import com.spring.service.EventService;
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

import java.util.ArrayList;
import java.util.List;

@Controller
public class AdminEventController {
//
//    private static final Logger logger
//            = LoggerFactory.getLogger(EventController.class);

    private final EventService eventService;

    private final AuditoriumService auditoriumService;

    @Autowired
    public AdminEventController(EventService eventService, AuditoriumService auditoriumService) {
        this.eventService = eventService;
        this.auditoriumService = auditoriumService;
    }

    //todo it is temporary
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(Model model) {
        return "redirect:/admin/events";
    }

    // show event
    @RequestMapping(value = "/admin/events/{id}", method = RequestMethod.GET)
    public String showEvent(@PathVariable("id") long id, Model model) {
//        logger.debug("showEvent() id=", id);
        Event event = eventService.findById(id);
//        if (event == null) {
//            model.addAttribute("css", "danger");
//            model.addAttribute("msg", "Event not found");
//        }
        model.addAttribute("event", event);
        return "events/admin/show";
    }

    // delete event
    @RequestMapping(value = "/admin/events/{id}/delete", method = RequestMethod.GET)
    public String deleteEvent(@PathVariable("id") long id,
                              final RedirectAttributes redirectAttributes) {

//        logger.debug("deleteEvent() id=", id);

        eventService.delete(id);

//        redirectAttributes.addFlashAttribute("css", "success");
//        redirectAttributes.addFlashAttribute("msg", "Event is deleted!");

        return "redirect:/admin/events";

    }

    // todo
    @RequestMapping(value = "/admin/events/{id}/update", method = RequestMethod.GET)
    public String showUpdateEventForm(@PathVariable("id") long id, Model model) {

//        logger.debug("showUpdateEventForm() id=", id);

        Event event = eventService.findById(id);
        model.addAttribute("event", event);
        model.addAttribute("auditoriums", auditoriumService.findAll());

        return "events/admin/eventForm";

    }

    @RequestMapping(value = "/admin/events/add", method = RequestMethod.GET)
    public String showAddEventForm(Model model) {

//        logger.debug("showAddEventForm()");
        Event event = new Event();
        model.addAttribute("event", event);

        return "events/admin/eventForm";
    }


    @RequestMapping(value = "/admin/events", method = RequestMethod.POST)
    public String createOrUpdateEvent(@ModelAttribute("event") Event event,
                                      BindingResult result,
                                      final RedirectAttributes redirectAttributes) {

//        logger.debug("createOrUpdateEvent() event=", event);

        if (result.hasErrors()) {
            return "events/admin/eventForm";
        } else {

            // Add message to flash scope
//            redirectAttributes.addFlashAttribute("css", "success");
//            if (event.isNew()) {
//                redirectAttributes.addFlashAttribute("msg", "Event added successfully!");
//            } else {
//                redirectAttributes.addFlashAttribute("msg", "Event updated successfully!");
//            }
            for (EventDateAndAuditorium e : event.getDateAndAuditoriums()) {
                System.out.println(e.getStartTime() + " - " + e.getEndTime() + " | " + e.getAuditoriumName());
            }
            event.setDateAndAuditoriums(removeInvalidItems(event.getDateAndAuditoriums()));
            eventService.saveOrUpdate(event);

            return "redirect:/admin/events/" + event.getId();
        }
    }

    @RequestMapping(value = "/admin/events", method = RequestMethod.GET)
    public String showAllEvents(Model model) {

//        logger.debug("showAllEvents()");
        model.addAttribute("events", eventService.findAll());
        return "events/admin/list";
    }


    private List<EventDateAndAuditorium> removeInvalidItems(List<EventDateAndAuditorium> dateAndAuditoriums) {
        List<EventDateAndAuditorium> resultList = new ArrayList<>();
        for (EventDateAndAuditorium dateAndAuditorium : dateAndAuditoriums) {
            if (!"".equals(dateAndAuditorium.getAuditoriumName())
                    && dateAndAuditorium.getStartTime() != null
                    && dateAndAuditorium.getStartTime() != null) {
                resultList.add(dateAndAuditorium);
            }
        }
        return resultList;
    }

}
