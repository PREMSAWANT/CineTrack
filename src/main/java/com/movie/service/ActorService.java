package com.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.ActorDao;
import com.movie.entity.Actor;
import com.movie.exception.ResourceNotFoundException;

@Service
public class ActorService {

	private static final Logger log = LoggerFactory.getLogger(ActorService.class);

	@Autowired
	private ActorDao actorDao;

	/* call method --> createActor(Actor actor) */
	public Actor addActor(Actor actor) {
		log.info("Adding new actor: {}", actor.getActorName());
		return actorDao.createActor(actor);
	}

	/* call method --> getAllActors() */
	public List<Actor> getAllActors() {
		return actorDao.getAllActors();
	}

	/* call method --> getActorById(int actorId) -- throws ResourceNotFoundException if not found */
	public Actor getActorById(int actorId) {
		Actor actor = actorDao.getActorById(actorId);
		if (actor == null) {
			log.warn("Actor not found with id: {}", actorId);
			throw new ResourceNotFoundException("Actor", actorId);
		}
		return actor;
	}

	/* call method --> updateActor(Actor actor) */
	public Actor updateActor(Actor actor) {
		log.info("Updating actor with id: {}", actor.getActorId());
		return actorDao.updateActor(actor);
	}

	/* call method --> deleteActor(int actorId) */
	public boolean deleteActor(int actorId) {
		log.info("Deleting actor with id: {}", actorId);
		return actorDao.deleteActor(actorId);
	}

	/* call method --> countActors() -- delegates to COUNT query, no full list fetch */
	public long getActorCount() {
		return actorDao.countActors();
	}

}
