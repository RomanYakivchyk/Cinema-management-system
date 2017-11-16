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
public class EventController {
//
//    private static final Logger logger
//            = LoggerFactory.getLogger(EventController.class);

    @Autowired
    private EventService eventService;

    @Autowired
    private AuditoriumService auditoriumService;

    public void setAuditoriumService(AuditoriumService auditoriumService) {
        this.auditoriumService = auditoriumService;
    }

    public void setEventService(EventService eventService) {
        this.eventService = eventService;
    }

    //todo it is temporary
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(Model model) {
        return "redirect:/events";
    }

    // show event
    @RequestMapping(value = "/events/{id}", method = RequestMethod.GET)
    public String showEvent(@PathVariable("id") long id, Model model) {

//        logger.debug("showEvent() id=", id);

        Event event = eventService.findById(id);
//        if (event == null) {
//            model.addAttribute("css", "danger");
//            model.addAttribute("msg", "Event not found");
//        }
        model.addAttribute("event", event);

        return "events/show";

    }

    // delete event
    @RequestMapping(value = "/events/{id}/delete", method = RequestMethod.GET)
    public String deleteEvent(@PathVariable("id") long id,
                              final RedirectAttributes redirectAttributes) {

//        logger.debug("deleteEvent() id=", id);

        eventService.delete(id);

//        redirectAttributes.addFlashAttribute("css", "success");
//        redirectAttributes.addFlashAttribute("msg", "Event is deleted!");

        return "redirect:/events";

    }

    // todo
    @RequestMapping(value = "/events/{id}/update", method = RequestMethod.GET)
    public String showUpdateEventForm(@PathVariable("id") long id, Model model) {

//        logger.debug("showUpdateEventForm() id=", id);

        Event event = eventService.findById(id);
        model.addAttribute("event", event);
        model.addAttribute("auditoriums", auditoriumService.findAll());

        return "events/eventForm";

    }

    @RequestMapping(value = "/events/add", method = RequestMethod.GET)
    public String showAddEventForm(Model model) {

//        logger.debug("showAddEventForm()");
        Event event = new Event();
        model.addAttribute("event", event);

        return "events/eventForm";
    }


    @RequestMapping(value = "/events", method = RequestMethod.POST)
    public String createOrUpdateEvent(@ModelAttribute("event") Event event,
                                      BindingResult result,
                                      final RedirectAttributes redirectAttributes) {

//        logger.debug("createOrUpdateEvent() event=", event);

        if (result.hasErrors()) {
            return "events/eventForm";
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

            return "redirect:/events/" + event.getId();
        }
    }

    @RequestMapping(value = "/events", method = RequestMethod.GET)
    public String showAllEvents(Model model) {

//        logger.debug("showAllEvents()");
        model.addAttribute("events", eventService.findAll());
        return "events/list";
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


//    @RequestMapping(value = "/createEvent", method = RequestMethod.POST)
//    public String createOrUpdateEvent(@ModelAttribute("EventModel") Event event, BindingResult result, ModelMap model) {
//        if (result.hasErrors()) {
//            return "error";
//        }
//        event.setDateAndAuditoriums(removeInvalidItems(event.getDateAndAuditoriums()));
//        //eventService.saveOrUpdate(event);
//
//        model.addAttribute("name", event.getName());
//        model.addAttribute("basePrice", event.getBasePrice());
//        model.addAttribute("rating", event.getRating());
//        model.addAttribute("dateAndAuditoriums", event.getDateAndAuditoriums());
//        return "event";
//    }

//    @RequestMapping(value = "/enterEventData", method = RequestMethod.GET)
//    public String showForm(Model model) {
//        EventModel eventModel = new EventModel();
//        model.addAttribute("EventModel", eventModel);
//        return "eventForm";
//        //  return "eventForm";
//    }
//
//


}
