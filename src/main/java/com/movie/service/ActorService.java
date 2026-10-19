package com.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.ActorDao;
import com.movie.entity.Actor;

@Service
public class ActorService {

	@Autowired
	private ActorDao actorDao;

	/* call method --> createActor(Actor actor) */
	public Actor addActor(Actor actor) {
		return actorDao.createActor(actor);
	}

	/* call method --> getAllActors() */
	public List<Actor> getAllActors() {
		return actorDao.getAllActors();
	}

	/* call method --> getActorById(int actorId) */
	public Actor getActorById(int actorId) {
		return actorDao.getActorById(actorId);
	}

	/* call method --> updateActor(Actor actor) */
	public Actor updateActor(Actor actor) {
		return actorDao.updateActor(actor);
	}

	/* call method --> deleteActor(int actorId) */
	public boolean deleteActor(int actorId) {
		return actorDao.deleteActor(actorId);
	}

}
