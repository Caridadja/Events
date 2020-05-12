package com.caridadja.events.repositories;

import org.springframework.data.repository.CrudRepository;

import com.caridadja.events.models.Message;

public interface MessageRepository extends CrudRepository<Message, Long>{
	void deleteById(Long id);
}
