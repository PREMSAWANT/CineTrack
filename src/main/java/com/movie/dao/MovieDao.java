package com.movie.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.entity.Movie;
import com.movie.exception.DataPersistenceException;

@Repository
public class MovieDao {

	private static final Logger log = LoggerFactory.getLogger(MovieDao.class);

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	/* create method --> insert movie table --> persist(Object Entity) */
	public Movie createMovie(Movie movie) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			em.persist(movie);
			tx.commit();
			log.info("Movie saved successfully with id: {}", movie.getMovieId());
			return movie;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to save movie [title={}]: {}", movie.getTitle(), e.getMessage(), e);
			throw new DataPersistenceException("Failed to save movie", e);
		} finally {
			em.close();
		}
	}

	/* fetch all method --> get all movie list --> createQuery() */
	public List<Movie> getAllMovies() {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Fetching all movies");
			return em.createQuery("select m from Movie m", Movie.class).getResultList();
		} catch (Exception e) {
			log.error("Failed to fetch movies: {}", e.getMessage(), e);
			throw new DataPersistenceException("Failed to fetch movies", e);
		} finally {
			em.close();
		}
	}

	/* find method --> get movie by id --> find(Class, id) */
	public Movie getMovieById(int movieId) {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			log.debug("Looking up Movie with id: {}", movieId);
			return em.find(Movie.class, movieId);
		} catch (Exception e) {
			log.error("Failed to find movie [id={}]: {}", movieId, e.getMessage(), e);
			throw new DataPersistenceException("Failed to find movie with id " + movieId, e);
		} finally {
			em.close();
		}
	}

	/* update method --> update movie table --> merge(Object Entity) */
	public Movie updateMovie(Movie movie) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Movie updated = em.merge(movie);
			tx.commit();
			log.info("Movie updated successfully with id: {}", updated.getMovieId());
			return updated;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to update movie [id={}]: {}", movie.getMovieId(), e.getMessage(), e);
			throw new DataPersistenceException("Failed to update movie with id " + movie.getMovieId(), e);
		} finally {
			em.close();
		}
	}

	/* delete method --> delete movie from table --> remove(Object Entity) */
	public boolean deleteMovie(int movieId) {
		EntityManager em = entityManagerFactory.createEntityManager();
		EntityTransaction tx = em.getTransaction();
		try {
			tx.begin();
			Movie movie = em.find(Movie.class, movieId);
			if (movie != null) {
				em.remove(movie);
				tx.commit();
				log.info("Movie deleted successfully with id: {}", movieId);
				return true;
			}
			tx.commit();
			log.warn("Delete requested but Movie not found with id: {}", movieId);
			return false;
		} catch (Exception e) {
			if (tx.isActive()) tx.rollback();
			log.error("Failed to delete movie [id={}]: {}", movieId, e.getMessage(), e);
			throw new DataPersistenceException("Failed to delete movie with id " + movieId, e);
		} finally {
			em.close();
		}
	}

	/* count method --> get total movie count --> COUNT query (efficient, no full fetch) */
	public long countMovies() {
		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			return em.createQuery("select count(m) from Movie m", Long.class).getSingleResult();
		} catch (Exception e) {
			log.error("Failed to count movies: {}", e.getMessage(), e);
			throw new DataPersistenceException("Failed to count movies", e);
		} finally {
			em.close();
		}
	}

}
