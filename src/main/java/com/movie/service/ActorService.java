package com.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.ActorDao;
import com.movie.dao.DirectorDao;
import com.movie.entity.Actor;
import com.movie.entity.Director;
import com.movie.exception.ResourceNotFoundException;

@Service
public class ActorService {

	private static final Logger log = LoggerFactory.getLogger(ActorService.class);

	@Autowired
	private ActorDao actorDao;

	@Autowired
	private DirectorDao directorDao;

	/* call method --> createActor(Actor actor) */
	public Actor addActor(Actor actor) {
		log.info("Adding new actor: {}", actor.getActorName());
		return actorDao.createActor(actor);
	}

	/* add actor with frequent director association */
	public Actor addActorWithDirector(Actor actor, Integer directorId) {
		if (directorId != null && directorId > 0) {
			Director director = directorDao.getDirectorById(directorId);
			actor.setDirector(director);
		}
		return addActor(actor);
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

	/* update actor with director synchronization */
	public Actor updateActorWithDirector(Actor actor, Integer directorId) {
		if (directorId != null && directorId > 0) {
			Director director = directorDao.getDirectorById(directorId);
			actor.setDirector(director);
		} else {
			actor.setDirector(null);
		}
		return updateActor(actor);
	}

	/* search actors by keyword across name or nationality */
	public List<Actor> searchActors(String keyword) {
		if (keyword == null || keyword.trim().isEmpty()) {
			return getAllActors();
		}
		log.info("Searching actors with keyword: '{}'", keyword);
		return actorDao.searchActors(keyword.trim());
	}

	/* filter actors by nationality */
	public List<Actor> getActorsByNationality(String nationality) {
		log.info("Filtering actors by nationality: '{}'", nationality);
		return actorDao.getActorsByNationality(nationality);
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
