package com.caridadja.events.controllers;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.caridadja.events.models.Event;
import com.caridadja.events.models.Message;
import com.caridadja.events.models.User;
import com.caridadja.events.services.MainService;
import com.caridadja.events.validator.UserValidator;

@Controller
public class MainController {
	private final MainService mainService;
	private final UserValidator userValidator;
	
	public MainController(MainService mainService, UserValidator userValidator) {
		this.mainService = mainService;
		this.userValidator = userValidator;
	}
	ArrayList<String> states = new ArrayList<String>(Arrays.asList("AL", "AK", "AZ", "AR", "CA", "CO", "CT",
			"DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN",
			"MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI",
			"SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"));
	@RequestMapping("")
	public String loginPage(@ModelAttribute("user") User user, Model model) {
		model.addAttribute("states", states);
		return "index.jsp";
	}
	@PostMapping("/login")
	public String loginUser(@RequestParam("logEmail") String email, @RequestParam("password") String password, Model model, @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		boolean authenticateUser = mainService.authenticateUser(email, password);
		if(result.hasErrors()) {
			model.addAttribute("error", "Invalid credentials");
			return "index.jsp";
		}
		if(authenticateUser) {
			User u = mainService.findByEmail(email);
			session.setAttribute("userId", u.getId());
			return "redirect:/home";
		}
		else {
			model.addAttribute("error", "Invalid credentials");
			return "index.jsp";
		}
	}
	@PostMapping("/registration")
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		userValidator.validate(user, result);
		if(result.hasErrors()) {
			return "index.jsp";
		}
		else {
			User u = mainService.registerUser(user);
			session.setAttribute("userId", u.getId());
			return "redirect:/home";
		}
	}
	@RequestMapping("/home")
	public String home(@Valid @ModelAttribute("event") Event newEvent, BindingResult result, HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId == null) {
			return "redirect:/";
		}
		else {
		User u = mainService.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("user", u);
		ArrayList<Event> events = (ArrayList<Event>) mainService.findAllEvents();
		ArrayList<Event> in_state = new ArrayList<Event>();
		ArrayList<Event> out_state = new ArrayList<Event>();
		for(Event event : events) {
			if(u.getState().equals(event.getState())) {
				in_state.add(event);
			}
			else {
				out_state.add(event);
			}
		}
		model.addAttribute("states", states);
		model.addAttribute("in_state", in_state);
		model.addAttribute("out_state", out_state);
		model.addAttribute("myevents", u.getEvents_hosting());
		return "home.jsp";
	}
}
	@PostMapping("/addevent")
	public String createEvent(@Valid @ModelAttribute("event") Event newEvent, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			return "home.jsp";
		}
		else {
			mainService.createEvent(newEvent);
			return "redirect:/home";
		}
	}
	@RequestMapping("/event/{id}")
	public String showEvent(@PathVariable("id") Long id,@Valid @ModelAttribute("newMessage") Message message, BindingResult result, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId == null) {
			return "redirect:/";
		}
		else {
		Event e = mainService.findEventById(id);
		User u = mainService.findUserById((Long)session.getAttribute("userId"));
		List<User> attendees = e.getAttendees();
		model.addAttribute("event", e);
		model.addAttribute("user", u);
		model.addAttribute("location", e.getLocation());
		model.addAttribute("host", e.getHost());
		model.addAttribute("date", e.getDate());
		model.addAttribute("attendees", attendees);
		model.addAttribute("messages", e.getMessages());
		session.setAttribute("eventId", id.toString());
		return "showEvent.jsp";
	}
	}
	@RequestMapping("/event/{id}/join")
	public String joinEvent(@PathVariable("id") Long id, HttpSession session) {
		Event e = mainService.findEventById(id);
		User u = mainService.findUserById((Long) session.getAttribute("userId"));
		List<User> attendees = e.getAttendees();
		attendees.add(u);
		e.setAttendees(attendees);
		mainService.updateUser(u);
		return "redirect:/home";
	}
	@RequestMapping("/event/{id}/edit")
	public String showEditEvent(@Valid @ModelAttribute("event") Event event, @PathVariable("id") Long id, BindingResult result, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId == null) {
			return "redirect:/";
		}
		else {
		model.addAttribute("event", mainService.findEventById(id));
		model.addAttribute("states", states);
		model.addAttribute("host", mainService.findUserById((Long) session.getAttribute("userId")));
		return "edit.jsp";
	}
	}
	@PostMapping("/{id}/update")
	public String editEvent(@Valid @ModelAttribute("event") Event event, @PathVariable("id") Long id, BindingResult result, Model model, HttpSession session) {
		if(result.hasErrors()) {
			return "home.jsp";
		}
		else {
		Event e = mainService.findEventById(id);
		model.addAttribute("states", states);
		model.addAttribute("host", mainService.findUserById((Long) session.getAttribute("userId")));
		event.setId(e.getId());
		mainService.updateEvent(event);
		return "redirect:/home";
		}
	}
	@RequestMapping("/event/{id}/cancel")
	public String cancelEvent(@PathVariable("id") Long id, HttpSession session) {
		Event e = mainService.findEventById(id);
		User u = mainService.findUserById((Long) session.getAttribute("userId"));
		List<User> attendees = e.getAttendees();
		for(int i = 0; i < attendees.size(); i++) {
			if(attendees.get(i).getId() == u.getId()) {
				attendees.remove(u);
			}
		}
		e.setAttendees(attendees);
		mainService.updateUser(u);
		return "redirect:/home";
	}
	@RequestMapping("/event/{id}/delete")
	public String deleteEvent(@PathVariable("id") Long id) {
		Event e = mainService.findEventById(id);
		List<User> at = e.getAttendees();
		List<Message> msg = e.getMessages();
		for(User u: at) {
			List<Event> userEvents = u.getEvents();
			userEvents.remove(e);
			u.setEvents(userEvents);
			at.remove(u);
		}
		for(Message m : msg) {
			mainService.deleteMessage(m.getId());
		}
		e.setAttendees(at);
		e.setMessages(msg);
		mainService.deleteEvent(id);
		return "redirect:/home";
	}
	@PostMapping("/addmessage")
	public String addMessage(@ModelAttribute("newMessage") Message message,Model model, HttpSession session) {
		User user = mainService.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("user", user);
		mainService.createMessage(message);
		return "redirect:/event/"+session.getAttribute("eventId");
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
