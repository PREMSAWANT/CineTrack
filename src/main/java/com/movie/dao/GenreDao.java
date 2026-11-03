package com.movie.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.entity.Genre;

@Repository
public class GenreDao {

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	/* create method --> insert genre table --> persist(Object Entity) */
	public Genre createGenre(Genre genre) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();
		try {
			transaction.begin();
			entityManager.persist(genre);
			transaction.commit();
			return genre;
		} catch (Exception e) {
			/* rollback transaction on any persistence error */
			if (transaction.isActive()) {
				transaction.rollback();
			}
			throw new RuntimeException("Failed to save genre: " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* fetch all method --> get all genre list --> createQuery() */
	public List<Genre> getAllGenres() {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		try {
			return entityManager.createQuery("select g from Genre g", Genre.class).getResultList();
		} catch (Exception e) {
			throw new RuntimeException("Failed to fetch genres: " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* find method --> get genre by id --> find(Class, id) */
	public Genre getGenreById(int genreId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		try {
			return entityManager.find(Genre.class, genreId);
		} catch (Exception e) {
			throw new RuntimeException("Failed to find genre with id " + genreId + ": " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* update method --> update genre table --> merge(Object Entity) */
	public Genre updateGenre(Genre genre) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();
		try {
			transaction.begin();
			Genre updated = entityManager.merge(genre);
			transaction.commit();
			return updated;
		} catch (Exception e) {
			/* rollback transaction on any persistence error */
			if (transaction.isActive()) {
				transaction.rollback();
			}
			throw new RuntimeException("Failed to update genre: " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	/* delete method --> delete genre from table --> remove(Object Entity) */
	public boolean deleteGenre(int genreId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();
		try {
			transaction.begin();
			Genre genre = entityManager.find(Genre.class, genreId);
			if (genre != null) {
				entityManager.remove(genre);
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
			throw new RuntimeException("Failed to delete genre with id " + genreId + ": " + e.getMessage(), e);
		} finally {
			entityManager.close();
		}
	}

	public List<Genre> fetchGenere() {
		return getAllGenres();
	}

}
