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

		transaction.begin();
		entityManager.persist(genre);
		transaction.commit();

		return genre;
	}

	/* fetch all method --> get all genre list --> createQuery() */
	public List<Genre> getAllGenres() {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		List<Genre> list = entityManager.createQuery("select g from Genre g", Genre.class).getResultList();
		return list;
	}

	/* find method --> get genre by id --> find(Class, id) */
	public Genre getGenreById(int genreId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		return entityManager.find(Genre.class, genreId);
	}

	/* update method --> update genre table --> merge(Object Entity) */
	public Genre updateGenre(Genre genre) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();

		transaction.begin();
		Genre updated = entityManager.merge(genre);
		transaction.commit();

		return updated;
	}

	/* delete method --> delete genre from table --> remove(Object Entity) */
	public boolean deleteGenre(int genreId) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();

		transaction.begin();
		Genre genre = entityManager.find(Genre.class, genreId);
		if (genre != null) {
			entityManager.remove(genre);
			transaction.commit();
			return true;
		}
		transaction.commit();
		return false;
	}

	public List<Genre> fetchGenere() {
		return getAllGenres();
	}

}
