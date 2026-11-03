package com.movie.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.entity.Genre;
import com.movie.exception.DataPersistenceException;

@Repository
public class GenreDao {

	private static final Logger log = LoggerFactory.getLogger(GenreDao.class);

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	/* create method --> insert genre table --> persist(Object Entity) */
	public Genre createGenre(Genre genre) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(genre);
			tx.commit();
			log.info("Genre saved successfully with id: {}", genre.getGenreId());
			return genre;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to save genre [name={}]: {}", genre.getGenreName(), e.getMessage(), e);
			throw new DataPersistenceException("Failed to save genre", e);
		} finally {
			em.close();
		}
	}

	/* fetch all method --> get all genre list --> createQuery() */
	public List<Genre> getAllGenres() {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Fetching all genres");
			return em.createQuery("select g from Genre g", Genre.class).getResultList();
		} catch (Exception e) {
			log.error("Failed to fetch genres: {}", e.getMessage(), e);
			throw new DataPersistenceException("Failed to fetch genres", e);
		} finally {
			em.close();
		}
	}

	/* find method --> get genre by id --> find(Class, id) */
	public Genre getGenreById(int genreId) {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Looking up Genre with id: {}", genreId);
			return em.find(Genre.class, genreId);
		} catch (Exception e) {
			log.error("Failed to find genre [id={}]: {}", genreId, e.getMessage(), e);
			throw new DataPersistenceException("Failed to find genre with id " + genreId, e);
		} finally {
			em.close();
		}
	}

	/* update method --> update genre table --> merge(Object Entity) */
	public Genre updateGenre(Genre genre) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Genre updated = em.merge(genre);
			tx.commit();
			log.info("Genre updated successfully with id: {}", updated.getGenreId());
			return updated;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to update genre [id={}]: {}", genre.getGenreId(), e.getMessage(), e);
			throw new DataPersistenceException("Failed to update genre with id " + genre.getGenreId(), e);
		} finally {
			em.close();
		}
	}

	/* delete method --> delete genre from table --> remove(Object Entity) */
	public boolean deleteGenre(int genreId) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Genre genre = em.find(Genre.class, genreId);
			if (genre != null) {
				em.remove(genre);
				tx.commit();
				log.info("Genre deleted successfully with id: {}", genreId);
				return true;
			}
			tx.commit();
			log.warn("Delete requested but Genre not found with id: {}", genreId);
			return false;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to delete genre [id={}]: {}", genreId, e.getMessage(), e);
			throw new DataPersistenceException("Failed to delete genre with id " + genreId, e);
		} finally {
			em.close();
		}
	}

	/* count method --> get total genre count --> COUNT query (efficient, no full fetch) */
	public long countGenres() {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			return em.createQuery("select count(g) from Genre g", Long.class).getSingleResult();
		} catch (Exception e) {
			log.error("Failed to count genres: {}", e.getMessage(), e);
			throw new DataPersistenceException("Failed to count genres", e);
		} finally {
			em.close();
		}
	}

	public List<Genre> fetchGenere() {
		return getAllGenres();
	}

}
