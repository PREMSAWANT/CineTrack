package com.cinetrack.CineTrack.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinetrack.CineTrack.dao.DirectorDao;
import com.cinetrack.CineTrack.dto.RegisterDirectorRequest;
import com.cinetrack.CineTrack.dto.RegisterDirectorResponse;
import com.cinetrack.CineTrack.entity.Director;
import com.cinetrack.CineTrack.exception.DirectorNotFoundException;
import com.cinetrack.CineTrack.exception.InvalidInputException;

@Service
public class DirectorService {

	@Autowired
	private DirectorDao directorDao;

	/* 1. Add single Director using DTO */
	public RegisterDirectorResponse addDirector(RegisterDirectorRequest request) {
		if (request.getDirectorName() == null || request.getDirectorName().trim().isEmpty() || request.getDirectorName().equalsIgnoreCase("string")) {
			throw new InvalidInputException("Director name cannot be empty or default string.");
		}

		Director director = convertToEntity(request);
		Director savedDirector = directorDao.createDirector(director);
		return convertToResponse(savedDirector, "Director created successfully");
	}

	/* 2. Add multiple Directors in batch using DTO */
	public List<RegisterDirectorResponse> addAllDirectors(List<RegisterDirectorRequest> requests) {
		List<Director> directorsToSave = new ArrayList<>();
		for (RegisterDirectorRequest req : requests) {
			if (req.getDirectorName() != null && !req.getDirectorName().trim().isEmpty() && !req.getDirectorName().equalsIgnoreCase("string")) {
				directorsToSave.add(convertToEntity(req));
			}
		}

		List<Director> savedDirectors = directorDao.createAllDirectors(directorsToSave);
		List<RegisterDirectorResponse> responses = new ArrayList<>();
		for (Director d : savedDirectors) {
			responses.add(convertToResponse(d, "Director created successfully"));
		}
		return responses;
	}

	/* 3. Fetch Director by ID */
	public RegisterDirectorResponse fetchById(Integer id) {
		Optional<Director> optional = directorDao.fetchById(id);
		if (optional.isPresent()) {
			return convertToResponse(optional.get(), "Director found successfully");
		}
		return null;
	}

	/* 4. Update Director using DTO */
	public RegisterDirectorResponse updateDirector(Integer id, RegisterDirectorRequest request) {
		Optional<Director> optional = directorDao.fetchById(id);
		if (!optional.isPresent()) {
			throw new DirectorNotFoundException("Cannot update. Director Not Found with Director ID : " + id);
		}

		Director newDirector = convertToEntity(request);
		Director updatedDirector = directorDao.updateDirector(id, newDirector);
		if (updatedDirector != null) {
			return convertToResponse(updatedDirector, "Director updated successfully");
		}
		return null;
	}

	/* 5. Fetch all Directors */
	public List<RegisterDirectorResponse> fetchAllDirectors() {
		List<Director> directors = directorDao.getAllDirectors();
		List<RegisterDirectorResponse> responses = new ArrayList<>();
		for (Director d : directors) {
			responses.add(convertToResponse(d, "Director fetched successfully"));
		}
		return responses;
	}

	/* 6. Delete Director by ID */
	public String deleteDirector(Integer id) {
		return directorDao.deleteDirector(id);
	}

	/* 7. Delete Director by ID */
	public String deleteDirectorById(Integer id) {
		return directorDao.deleteDirectorById(id);
	}

	/* 8. Find Directors by Name */
	public List<RegisterDirectorResponse> findByName(String name) {
		List<Director> directors = directorDao.findByName(name);
		List<RegisterDirectorResponse> responses = new ArrayList<>();
		for (Director d : directors) {
			responses.add(convertToResponse(d, "Director fetched successfully"));
		}
		return responses;
	}

	/* 9. Delete all Directors */
	public String deleteAll() {
		return directorDao.deleteAll();
	}

	/* Helper: Convert RegisterDirectorRequest to Director entity */
	private Director convertToEntity(RegisterDirectorRequest request) {
		Director director = new Director();
		director.setDirectorName(request.getDirectorName());
		director.setNationality(request.getNationality());
		return director;
	}

	/* Helper: Convert Director entity to RegisterDirectorResponse */
	private RegisterDirectorResponse convertToResponse(Director director, String message) {
		return new RegisterDirectorResponse(
				message,
				director.getDirectorId(),
				director.getDirectorName(),
				director.getNationality()
		);
	}
}
