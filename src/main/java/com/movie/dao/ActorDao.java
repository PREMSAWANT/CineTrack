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
		try {
			transaction.begin();
			entityManager.persist(actor);
			transaction.commit();
			return actor;
		} catch (Exception e) {
			/* rollback transaction on any persistence error */
			if (transaction.isActive()) {
				transaction.rollback();
			}
			throw new RuntimeException("Failed to save actor: " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* fetch all method --> get all actor list --> createQuery() */
	public List<Actor> getAllActors() {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		try {
			return entityManager.createQuery("select a from Actor a", Actor.class).getResultList();
		} catch (Exception e) {
			throw new RuntimeException("Failed to fetch actors: " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* find method --> get actor by id --> find(Class, id) */
	public Actor getActorById(int actorId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		try {
			return entityManager.find(Actor.class, actorId);
		} catch (Exception e) {
			throw new RuntimeException("Failed to find actor with id " + actorId + ": " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* update method --> update actor table --> merge(Object Entity) */
	public Actor updateActor(Actor actor) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();
		try {
			transaction.begin();
			Actor updated = entityManager.merge(actor);
			transaction.commit();
			return updated;
		} catch (Exception e) {
			/* rollback transaction on any persistence error */
			if (transaction.isActive()) {
				transaction.rollback();
			}
			throw new RuntimeException("Failed to update actor: " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* delete method --> delete actor from table --> remove(Object Entity) */
	public boolean deleteActor(int actorId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();
		try {
			transaction.begin();
			Actor actor = entityManager.find(Actor.class, actorId);
			if (actor != null) {
				entityManager.remove(actor);
				transaction.commit();
				return true;
			}
			transaction.commit();
			return false;
		} catch (Exception e) {
			/* rollback transaction on any persistence error */
			if (transaction.isActive()) {
				transaction.rollback();
			}
			throw new RuntimeException("Failed to delete actor with id " + actorId + ": " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

}
