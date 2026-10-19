package com.movie.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

import org.springframework.stereotype.Repository;

import com.movie.entity.Genre;

@Repository
public class GenreDao {

	private EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("cinetrack");

	/* create method --> insert genre table --> persist(Object Entity) */
	public Genre createGenre(Genre genre) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		EntityTransaction transaction = entityManager.getTransaction();

		transaction.begin();
		entityManager.persist(genre);
		transaction.commit();

		return genre;
	}

}

