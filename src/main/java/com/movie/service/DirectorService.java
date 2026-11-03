package com.movie.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.dao.DirectorDao;
import com.movie.entity.Director;
import com.movie.exception.ResourceNotFoundException;

@Service
public class DirectorService {

	private static final Logger log = LoggerFactory.getLogger(DirectorService.class);

	@Autowired
	private DirectorDao directorDao;

	/* call method --> createDirector(Director director) */
	public Director addDirector(Director director) {
		log.info("Adding new director: {}", director.getDirectorName());
		return directorDao.createDirector(director);
	}

	/* call method --> getAllDirectors() */
	public List<Director> getAllDirectors() {
		return directorDao.getAllDirectors();
	}

	/* call method --> getDirectorById(int directorId) -- throws ResourceNotFoundException if not found */
	public Director getDirectorById(int directorId) {
		Director director = directorDao.getDirectorById(directorId);
		if (director == null) {
			log.warn("Director not found with id: {}", directorId);
			throw new ResourceNotFoundException("Director", directorId);
		}
		return director;
	}

	/* call method --> updateDirector(Director director) */
	public Director updateDirector(Director director) {
		log.info("Updating director with id: {}", director.getDirectorId());
		return directorDao.updateDirector(director);
	}

	/* call method --> deleteDirector(int directorId) */
	public boolean deleteDirector(int directorId) {
		log.info("Deleting director with id: {}", directorId);
		return directorDao.deleteDirector(directorId);
	}

	/* call method --> countDirectors() -- delegates to COUNT query, no full list fetch */
	public long getDirectorCount() {
		return directorDao.countDirectors();
	}

}
