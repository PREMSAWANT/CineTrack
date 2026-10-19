package com.movie.service;

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

}

