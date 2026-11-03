package com.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.MovieDao;
import com.movie.entity.Movie;
import com.movie.exception.ResourceNotFoundException;

@Service
public class MovieService {

	private static final Logger log = LoggerFactory.getLogger(MovieService.class);

	@Autowired
	private MovieDao movieDao;

	/* call method --> createMovie(Movie movie) */
	public Movie addMovie(Movie movie) {
		log.info("Adding new movie: {}", movie.getTitle());
		return movieDao.createMovie(movie);
	}

	/* call method --> getAllMovies() */
	public List<Movie> getAllMovies() {
		return movieDao.getAllMovies();
	}

	/* call method --> getMovieById(int movieId) -- throws ResourceNotFoundException if not found */
	public Movie getMovieById(int movieId) {
		Movie movie = movieDao.getMovieById(movieId);
		if (movie == null) {
			log.warn("Movie not found with id: {}", movieId);
			throw new ResourceNotFoundException("Movie", movieId);
		}
		return movie;
	}

	/* call method --> updateMovie(Movie movie) */
	public Movie updateMovie(Movie movie) {
		log.info("Updating movie with id: {}", movie.getMovieId());
		return movieDao.updateMovie(movie);
	}

	/* call method --> deleteMovie(int movieId) */
	public boolean deleteMovie(int movieId) {
		log.info("Deleting movie with id: {}", movieId);
		return movieDao.deleteMovie(movieId);
	}

	/* call method --> countMovies() -- delegates to COUNT query, no full list fetch */
	public long getMovieCount() {
		return movieDao.countMovies();
	}

}
