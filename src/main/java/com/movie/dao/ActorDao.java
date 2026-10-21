package com.movie.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.entity.Actor;

@Repository
public class ActorDao {

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	/* create method --> insert actor table --> persist(Object Entity) */
	public Actor createActor(Actor actor) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();

		transaction.begin();
		entityManager.persist(actor);
		transaction.commit();

		return actor;
	}

	/* fetch all method --> get all actor list --> createQuery() */
	public List<Actor> getAllActors() {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		List<Actor> list = entityManager.createQuery("select a from Actor a", Actor.class).getResultList();
		return list;
	}

	/* find method --> get actor by id --> find(Class, id) */
	public Actor getActorById(int actorId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		return entityManager.find(Actor.class, actorId);
	}

	/* update method --> update actor table --> merge(Object Entity) */
	public Actor updateActor(Actor actor) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();

		transaction.begin();
		Actor updated = entityManager.merge(actor);
		transaction.commit();

		return updated;
	}

	/* delete method --> delete actor from table --> remove(Object Entity) */
	public boolean deleteActor(int actorId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();

		transaction.begin();
		Actor actor = entityManager.find(Actor.class, actorId);
		if (actor != null) {
			entityManager.remove(actor);
			transaction.commit();
			return true;
		}
		transaction.commit();
		return false;
	}

}
