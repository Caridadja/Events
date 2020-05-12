package com.caridadja.events.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.caridadja.events.models.Event;
@Repository
public interface EventRepository extends CrudRepository<Event, Long>{
	void deleteById(Long id);
	
}
