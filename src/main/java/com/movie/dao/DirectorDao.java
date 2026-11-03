package com.movie.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.entity.Director;

@Repository
public class DirectorDao {

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	/* create method --> insert director table --> persist(Object Entity) */
	public Director createDirector(Director director) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();
		try {
			transaction.begin();
			entityManager.persist(director);
			transaction.commit();
			return director;
		} catch (Exception e) {
			/* rollback transaction on any persistence error */
			if (transaction.isActive()) {
				transaction.rollback();
			}
			throw new RuntimeException("Failed to save director: " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* fetch all method --> get all director list --> createQuery() */
	public List<Director> getAllDirectors() {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		try {
			return entityManager.createQuery("select d from Director d", Director.class).getResultList();
		} catch (Exception e) {
			throw new RuntimeException("Failed to fetch directors: " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* find method --> get director by id --> find(Class, id) */
	public Director getDirectorById(int directorId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		try {
			return entityManager.find(Director.class, directorId);
		} catch (Exception e) {
			throw new RuntimeException("Failed to find director with id " + directorId + ": " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* update method --> update director table --> merge(Object Entity) */
	public Director updateDirector(Director director) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();
		try {
			transaction.begin();
			Director updated = entityManager.merge(director);
			transaction.commit();
			return updated;
		} catch (Exception e) {
			/* rollback transaction on any persistence error */
			if (transaction.isActive()) {
				transaction.rollback();
			}
			throw new RuntimeException("Failed to update director: " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* delete method --> delete director from table --> remove(Object Entity) */
	public boolean deleteDirector(int directorId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();
		try {
			transaction.begin();
			Director director = entityManager.find(Director.class, directorId);
			if (director != null) {
				entityManager.remove(director);
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
			throw new RuntimeException("Failed to delete director with id " + directorId + ": " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

}
