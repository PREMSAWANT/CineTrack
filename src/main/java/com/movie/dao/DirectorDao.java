package com.movie.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.entity.Director;
import com.movie.exception.DataPersistenceException;

@Repository
public class DirectorDao {

	private static final Logger log = LoggerFactory.getLogger(DirectorDao.class);

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	/* create method --> insert director table --> persist(Object Entity) */
	public Director createDirector(Director director) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(director);
			tx.commit();
			log.info("Director saved successfully with id: {}", director.getDirectorId());
			return director;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to save director [name={}]: {}", director.getDirectorName(), e.getMessage(), e);
			throw new DataPersistenceException("Failed to save director", e);
		} finally {
			em.close();
		}
	}

	/* fetch all method --> get all director list --> createQuery() */
	public List<Director> getAllDirectors() {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Fetching all directors");
			return em.createQuery("select d from Director d", Director.class).getResultList();
		} catch (Exception e) {
			log.error("Failed to fetch directors: {}", e.getMessage(), e);
			throw new DataPersistenceException("Failed to fetch directors", e);
		} finally {
			em.close();
		}
	}

	/* find method --> get director by id --> find(Class, id) */
	public Director getDirectorById(int directorId) {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Looking up Director with id: {}", directorId);
			return em.find(Director.class, directorId);
		} catch (Exception e) {
			log.error("Failed to find director [id={}]: {}", directorId, e.getMessage(), e);
			throw new DataPersistenceException("Failed to find director with id " + directorId, e);
		} finally {
			em.close();
		}
	}

	/* update method --> update director table --> merge(Object Entity) */
	public Director updateDirector(Director director) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Director updated = em.merge(director);
			tx.commit();
			log.info("Director updated successfully with id: {}", updated.getDirectorId());
			return updated;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to update director [id={}]: {}", director.getDirectorId(), e.getMessage(), e);
			throw new DataPersistenceException("Failed to update director with id " + director.getDirectorId(), e);
		} finally {
			em.close();
		}
	}

	/* delete method --> delete director from table --> remove(Object Entity) */
	public boolean deleteDirector(int directorId) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Director director = em.find(Director.class, directorId);
			if (director != null) {
				em.remove(director);
				tx.commit();
				log.info("Director deleted successfully with id: {}", directorId);
				return true;
			}
			tx.commit();
			log.warn("Delete requested but Director not found with id: {}", directorId);
			return false;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to delete director [id={}]: {}", directorId, e.getMessage(), e);
			throw new DataPersistenceException("Failed to delete director with id " + directorId, e);
		} finally {
			em.close();
		}
	}

	/* count method --> get total director count --> COUNT query (efficient, no full fetch) */
	public long countDirectors() {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			return em.createQuery("select count(d) from Director d", Long.class).getSingleResult();
		} catch (Exception e) {
			log.error("Failed to count directors: {}", e.getMessage(), e);
			throw new DataPersistenceException("Failed to count directors", e);
		} finally {
			em.close();
		}
	}

}
