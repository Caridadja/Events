package com.caridadja.events.models;

import java.util.*;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id")
	private Long id;
	
	@NotNull
	private String first_name;
	
	@NotNull
	private String last_name;
	
	@Email
	private String email;
	
	@NotNull
	private String location;
	
	@NotNull
	private String state;
	
	@Size(min=5, message = "Password must be greater than 5 characters")
	private String password;
	
	@Transient
	private String pwConfirmation;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name="users_events", joinColumns=@JoinColumn(name="user_id"), inverseJoinColumns = @JoinColumn(name="event_id"))
	private List<Event> events;
	
	@OneToMany(mappedBy = "host", fetch = FetchType.LAZY)
	private List<Event> events_hosting;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Message> messages;
	
	@DateTimeFormat(pattern = "MM/dd/yyyy HH:mm:ss")
	private Date created_at;
	@DateTimeFormat(pattern = "MM/dd/yyyy HH:mm:ss")
	private Date updated_at;
	 @PrePersist
	 protected void onCreate(){
	     this.created_at = new Date();
	 }
	 @PreUpdate
	 protected void onUpdate(){
	     this.updated_at = new Date();
	 }
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPwConfirmation() {
		return pwConfirmation;
	}
	public void setPwConfirmation(String pwConfirmation) {
		this.pwConfirmation = pwConfirmation;
	}
	public List<Event> getEvents() {
		return events;
	}
	public void setEvents(List<Event> events) {
		this.events = events;
	}
	public List<Event> getEvents_hosting() {
		return events_hosting;
	}
	public void setEvents_hosting(List<Event> events_hosting) {
		this.events_hosting = events_hosting;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public Date getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Date updated_at) {
		this.updated_at = updated_at;
	}
	
}
