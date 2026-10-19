package com.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.GenreDao;
import com.movie.entity.Genre;

@Service
public class GenreService {

	@Autowired
	private GenreDao genreDao;

	/* call method --> createGenre(Genre genre) */
	public Genre addGenre(Genre genre) {
		return genreDao.createGenre(genre);
	}

	/* call method --> getAllGenres() */
	public List<Genre> getAllGenres() {
		return genreDao.getAllGenres();
	}

	/* call method --> getGenreById(int genreId) */
	public Genre getGenreById(int genreId) {
		return genreDao.getGenreById(genreId);
	}

	/* call method --> updateGenre(Genre genre) */
	public Genre updateGenre(Genre genre) {
		return genreDao.updateGenre(genre);
	}

	/* call method --> deleteGenre(int genreId) */
	public boolean deleteGenre(int genreId) {
		return genreDao.deleteGenre(genreId);
	}

}
