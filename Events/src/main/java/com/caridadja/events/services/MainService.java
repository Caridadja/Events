package com.caridadja.events.services;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.caridadja.events.repositories.EventRepository;
import com.caridadja.events.repositories.MessageRepository;
import com.caridadja.events.repositories.UserRepository;
import com.caridadja.events.models.*;

@Service
public class MainService {
	private final UserRepository userRepository;
	private final EventRepository eventRepository;
	private final MessageRepository messageRepository;
	
	public MainService(EventRepository eventRepository, UserRepository userRepository, MessageRepository messageRepository) {
		this.eventRepository = eventRepository;
		this.userRepository = userRepository;
		this.messageRepository = messageRepository;
	}
	public User registerUser(User user) {
		String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepository.save(user);
	}
	public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    public User findUserById(Long id) {
    	Optional<User> u = userRepository.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    public void updateUser(User user) {
    	userRepository.save(user);
    }
    public Event findEventById(Long id) {
    	Optional<Event> e = eventRepository.findById(id);
    	
    	if(e.isPresent()) {
            return e.get();
    	} else {
    	    return null;
    	}
    }
    public List<Event> findAllEvents(){
    	return (List<Event>) eventRepository.findAll();
    }
    public Event createEvent(Event event) {
    	return eventRepository.save(event);
    }
    public void deleteEvent(Long id) {
    	eventRepository.deleteById(id);
    }
    public void updateEvent(Event event) {
    	eventRepository.save(event);
    }
    public boolean authenticateUser(String email, String password) {
        User user = userRepository.findByEmail(email);
        if(user == null) {
            return false;
        } else {
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
    public void createMessage(Message message) {
    	messageRepository.save(message);
    }
    public void deleteMessage(Long id) {
    	messageRepository.deleteById(id);
    }
}
