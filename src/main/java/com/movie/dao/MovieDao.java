package com.movie.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.movie.entity.Movie;

@Repository
public class MovieDao {

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	/* create method --> insert movie table --> persist(Object Entity) */
	public Movie createMovie(Movie movie) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();

		transaction.begin();
		entityManager.persist(movie);
		transaction.commit();

		return movie;
	}

	/* fetch all method --> get all movie list --> createQuery() */
	public List<Movie> getAllMovies() {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		List<Movie> list = entityManager.createQuery("select m from Movie m", Movie.class).getResultList();
		return list;
	}

	/* find method --> get movie by id --> find(Class, id) */
	public Movie getMovieById(int movieId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		return entityManager.find(Movie.class, movieId);
	}

	/* update method --> update movie table --> merge(Object Entity) */
	public Movie updateMovie(Movie movie) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();

		transaction.begin();
		Movie updated = entityManager.merge(movie);
		transaction.commit();

		return updated;
	}

	/* delete method --> delete movie from table --> remove(Object Entity) */
	public boolean deleteMovie(int movieId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();

		transaction.begin();
		Movie movie = entityManager.find(Movie.class, movieId);
		if (movie != null) {
			entityManager.remove(movie);
			transaction.commit();
			return true;
		}
		transaction.commit();
		return false;
	}

}
