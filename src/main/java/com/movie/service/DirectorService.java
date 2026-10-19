package com.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.DirectorDao;
import com.movie.entity.Director;

@Service
public class DirectorService {

	@Autowired
	private DirectorDao directorDao;

	/* call method --> createDirector(Director director) */
	public Director addDirector(Director director) {
		return directorDao.createDirector(director);
	}

	/* call method --> getAllDirectors() */
	public List<Director> getAllDirectors() {
		return directorDao.getAllDirectors();
	}

	/* call method --> getDirectorById(int directorId) */
	public Director getDirectorById(int directorId) {
		return directorDao.getDirectorById(directorId);
	}

	/* call method --> updateDirector(Director director) */
	public Director updateDirector(Director director) {
		return directorDao.updateDirector(director);
	}

	/* call method --> deleteDirector(int directorId) */
	public boolean deleteDirector(int directorId) {
		return directorDao.deleteDirector(directorId);
	}

}
