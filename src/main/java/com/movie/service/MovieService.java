package com.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.MovieDao;
import com.movie.entity.Movie;

@Service
public class MovieService {

	@Autowired
	private MovieDao movieDao;

	/* call method --> createMovie(Movie movie) */
	public Movie addMovie(Movie movie) {
		return movieDao.createMovie(movie);
	}

	/* call method --> getAllMovies() */
	public List<Movie> getAllMovies() {
		return movieDao.getAllMovies();
	}

	/* call method --> getMovieById(int movieId) */
	public Movie getMovieById(int movieId) {
		return movieDao.getMovieById(movieId);
	}

	/* call method --> updateMovie(Movie movie) */
	public Movie updateMovie(Movie movie) {
		return movieDao.updateMovie(movie);
	}

	/* call method --> deleteMovie(int movieId) */
	public boolean deleteMovie(int movieId) {
		return movieDao.deleteMovie(movieId);
	}

}
