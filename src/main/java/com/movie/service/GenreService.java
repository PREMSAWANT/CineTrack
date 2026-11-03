package com.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.GenreDao;
import com.movie.entity.Genre;
import com.movie.exception.ResourceNotFoundException;

@Service
public class GenreService {

	private static final Logger log = LoggerFactory.getLogger(GenreService.class);

	@Autowired
	private GenreDao genreDao;

	/* call method --> createGenre(Genre genre) */
	public Genre addGenre(Genre genre) {
		log.info("Adding new genre: {}", genre.getGenreName());
		return genreDao.createGenre(genre);
	}

	/* call method --> getAllGenres() */
	public List<Genre> getAllGenres() {
		return genreDao.getAllGenres();
	}

	/* call method --> getGenreById(int genreId) -- throws ResourceNotFoundException if not found */
	public Genre getGenreById(int genreId) {
		Genre genre = genreDao.getGenreById(genreId);
		if (genre == null) {
			log.warn("Genre not found with id: {}", genreId);
			throw new ResourceNotFoundException("Genre", genreId);
		}
		return genre;
	}

	/* call method --> updateGenre(Genre genre) */
	public Genre updateGenre(Genre genre) {
		log.info("Updating genre with id: {}", genre.getGenreId());
		return genreDao.updateGenre(genre);
	}

	/* call method --> deleteGenre(int genreId) */
	public boolean deleteGenre(int genreId) {
		log.info("Deleting genre with id: {}", genreId);
		return genreDao.deleteGenre(genreId);
	}

	/* call method --> countGenres() -- delegates to COUNT query, no full list fetch */
	public long getGenreCount() {
		return genreDao.countGenres();
	}

}
