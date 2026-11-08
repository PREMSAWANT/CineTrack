package com.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.DirectorDao;
import com.movie.dao.GenreDao;
import com.movie.dao.MovieDao;
import com.movie.entity.Director;
import com.movie.entity.Genre;
import com.movie.entity.Movie;
import com.movie.exception.ResourceNotFoundException;

@Service
public class MovieService {

	private static final Logger log = LoggerFactory.getLogger(MovieService.class);

	@Autowired
	private MovieDao movieDao;

	@Autowired
	private GenreDao genreDao;

	@Autowired
	private DirectorDao directorDao;

	/* call method --> createMovie(Movie movie) */
	public Movie addMovie(Movie movie) {
		log.info("Adding new movie: {}", movie.getTitle());
		return movieDao.createMovie(movie);
	}

	/* add movie and link selected genre and director */
	public Movie addMovieWithRelations(Movie movie, Integer genreId, Integer directorId) {
		if (genreId != null && genreId > 0) {
			Genre genre = genreDao.getGenreById(genreId);
			movie.setGenre(genre);
		}
		if (directorId != null && directorId > 0) {
			Director director = directorDao.getDirectorById(directorId);
			movie.setDirector(director);
		}
		return addMovie(movie);
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

	/* update movie and synchronize genre and director relationships */
	public Movie updateMovieWithRelations(Movie movie, Integer genreId, Integer directorId) {
		if (genreId != null && genreId > 0) {
			Genre genre = genreDao.getGenreById(genreId);
			movie.setGenre(genre);
		} else {
			movie.setGenre(null);
		}
		if (directorId != null && directorId > 0) {
			Director director = directorDao.getDirectorById(directorId);
			movie.setDirector(director);
		} else {
			movie.setDirector(null);
		}
		return updateMovie(movie);
	}

	/* search movies by keyword across title, description, or language */
	public List<Movie> searchMovies(String keyword) {
		if (keyword == null || keyword.trim().isEmpty()) {
			return getAllMovies();
		}
		log.info("Searching movies with keyword: '{}'", keyword);
		return movieDao.searchMovies(keyword.trim());
	}

	/* filter movies by genre */
	public List<Movie> getMoviesByGenre(int genreId) {
		log.info("Filtering movies by genre id: {}", genreId);
		return movieDao.getMoviesByGenre(genreId);
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
