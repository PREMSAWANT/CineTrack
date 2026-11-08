package com.movie.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.entity.Actor;
import com.movie.exception.DataPersistenceException;

@Repository
public class ActorDao {

	private static final Logger log = LoggerFactory.getLogger(ActorDao.class);

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	/* create method --> insert actor table --> persist(Object Entity) */
	public Actor createActor(Actor actor) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(actor);
			tx.commit();
			log.info("Actor saved successfully with id: {}", actor.getActorId());
			return actor;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to save actor [name={}]: {}", actor.getActorName(), e.getMessage(), e);
			throw new DataPersistenceException("Failed to save actor", e);
		} finally {
			em.close();
		}
	}

	/* fetch all method with eager director relation --> createQuery() */
	public List<Actor> getAllActors() {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Fetching all actors with relations");
			return em.createQuery(
				"select distinct a from Actor a left join fetch a.director order by a.actorId asc",
				Actor.class).getResultList();
		} catch (Exception e) {
			log.error("Failed to fetch actors: {}", e.getMessage(), e);
			throw new DataPersistenceException("Failed to fetch actors", e);
		} finally {
			em.close();
		}
	}

	/* find method --> get actor by id with relations */
	public Actor getActorById(int actorId) {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Looking up Actor with id: {}", actorId);
			List<Actor> results = em.createQuery(
				"select distinct a from Actor a left join fetch a.director where a.actorId = :id",
				Actor.class)
				.setParameter("id", actorId)
				.getResultList();
			return results.isEmpty() ? null : results.get(0);
		} catch (Exception e) {
			log.error("Failed to find actor [id={}]: {}", actorId, e.getMessage(), e);
			throw new DataPersistenceException("Failed to find actor with id " + actorId, e);
		} finally {
			em.close();
		}
	}

	/* search actors by keyword in name or nationality */
	public List<Actor> searchActors(String keyword) {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Searching actors with keyword: {}", keyword);
			return em.createQuery(
				"select distinct a from Actor a left join fetch a.director " +
				"where lower(a.actorName) like lower(:kw) or lower(a.nationality) like lower(:kw) " +
				"order by a.actorId asc", Actor.class)
				.setParameter("kw", "%" + keyword.trim() + "%")
				.getResultList();
		} catch (Exception e) {
			log.error("Failed to search actors with keyword [{}]: {}", keyword, e.getMessage(), e);
			throw new DataPersistenceException("Failed to search actors", e);
		} finally {
			em.close();
		}
	}

	/* filter actors by nationality */
	public List<Actor> getActorsByNationality(String nationality) {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Filtering actors by nationality: {}", nationality);
			return em.createQuery(
				"select distinct a from Actor a left join fetch a.director " +
				"where lower(a.nationality) = lower(:nat) order by a.actorId asc", Actor.class)
				.setParameter("nat", nationality.trim())
				.getResultList();
		} catch (Exception e) {
			log.error("Failed to filter actors by nationality [{}]: {}", nationality, e.getMessage(), e);
			throw new DataPersistenceException("Failed to filter actors by nationality", e);
		} finally {
			em.close();
		}
	}

	/* update method --> update actor table --> merge(Object Entity) */
	public Actor updateActor(Actor actor) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Actor updated = em.merge(actor);
			tx.commit();
			log.info("Actor updated successfully with id: {}", updated.getActorId());
			return updated;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to update actor [id={}]: {}", actor.getActorId(), e.getMessage(), e);
			throw new DataPersistenceException("Failed to update actor with id " + actor.getActorId(), e);
		} finally {
			em.close();
		}
	}

	/* delete method --> delete actor from table --> remove(Object Entity) */
	public boolean deleteActor(int actorId) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Actor actor = em.find(Actor.class, actorId);
			if (actor != null) {
				em.remove(actor);
				tx.commit();
				log.info("Actor deleted successfully with id: {}", actorId);
				return true;
			}
			tx.commit();
			log.warn("Delete requested but Actor not found with id: {}", actorId);
			return false;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to delete actor [id={}]: {}", actorId, e.getMessage(), e);
			throw new DataPersistenceException("Failed to delete actor with id " + actorId, e);
		} finally {
			em.close();
		}
	}

	/* count method --> get total actor count --> COUNT query (efficient, no full fetch) */
	public long countActors() {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			return em.createQuery("select count(a) from Actor a", Long.class).getSingleResult();
		} catch (Exception e) {
			log.error("Failed to count actors: {}", e.getMessage(), e);
			throw new DataPersistenceException("Failed to count actors", e);
		} finally {
			em.close();
		}
	}

}
