package com.cinetrack.CineTrack.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinetrack.CineTrack.dao.GenreDao;
import com.cinetrack.CineTrack.dto.RegisterGenreRequest;
import com.cinetrack.CineTrack.dto.RegisterGenreResponse;
import com.cinetrack.CineTrack.entity.Genre;
import com.cinetrack.CineTrack.exception.GenreAlreadyExistsException;
import com.cinetrack.CineTrack.exception.GenreNotFoundException;
import com.cinetrack.CineTrack.exception.InvalidInputException;

@Service
public class GenreService {

	@Autowired
	private GenreDao genreDao;

	/* 1. Add single Genre using DTO */
	public RegisterGenreResponse addGenre(RegisterGenreRequest request) {
		if (request.getGenreName() == null || request.getGenreName().trim().isEmpty() || request.getGenreName().equalsIgnoreCase("string")) {
			throw new InvalidInputException("Genre name cannot be empty or default string.");
		}

		if (genreDao.existsByName(request.getGenreName().trim())) {
			throw new GenreAlreadyExistsException("Genre already exists with Name: " + request.getGenreName());
		}

		Genre genre = convertToEntity(request);
		Genre savedGenre = genreDao.createGenre(genre);
		return convertToResponse(savedGenre, "Genre created successfully");
	}

	/* 2. Add multiple Genres in batch using DTO */
	public List<RegisterGenreResponse> addAllGenres(List<RegisterGenreRequest> requests) {
		List<Genre> genresToSave = new ArrayList<>();
		for (RegisterGenreRequest req : requests) {
			if (req.getGenreName() != null && !req.getGenreName().trim().isEmpty() && !req.getGenreName().equalsIgnoreCase("string")) {
				if (!genreDao.existsByName(req.getGenreName().trim())) {
					genresToSave.add(convertToEntity(req));
				}
			}
		}

		List<Genre> savedGenres = genreDao.createAllGenres(genresToSave);
		List<RegisterGenreResponse> responses = new ArrayList<>();
		for (Genre g : savedGenres) {
			responses.add(convertToResponse(g, "Genre created successfully"));
		}
		return responses;
	}

	/* 3. Fetch Genre by ID */
	public RegisterGenreResponse fetchById(Integer id) {
		Optional<Genre> optional = genreDao.fetchById(id);
		if (optional.isPresent()) {
			return convertToResponse(optional.get(), "Genre found successfully");
		}
		return null;
	}

	/* 4. Update Genre using DTO */
	public RegisterGenreResponse updateGenre(Integer id, RegisterGenreRequest request) {
		Optional<Genre> optional = genreDao.fetchById(id);
		if (!optional.isPresent()) {
			throw new GenreNotFoundException("Cannot update. Genre Not Found with Genre ID : " + id);
		}

		Genre newGenre = convertToEntity(request);
		Genre updatedGenre = genreDao.updateGenre(id, newGenre);
		if (updatedGenre != null) {
			return convertToResponse(updatedGenre, "Genre updated successfully");
		}
		return null;
	}

	/* 5. Fetch all Genres */
	public List<RegisterGenreResponse> fetchAllGenres() {
		List<Genre> genres = genreDao.getAllGenres();
		List<RegisterGenreResponse> responses = new ArrayList<>();
		for (Genre g : genres) {
			responses.add(convertToResponse(g, "Genre fetched successfully"));
		}
		return responses;
	}

	/* 6. Delete Genre by ID */
	public String deleteGenre(Integer id) {
		return genreDao.deleteGenre(id);
	}

	/* 7. Delete Genre by ID */
	public String deleteGenreById(Integer id) {
		return genreDao.deleteGenreById(id);
	}

	/* 8. Delete all Genres */
	public String deleteAll() {
		return genreDao.deleteAll();
	}

	/* Helper: Convert RegisterGenreRequest to Genre entity */
	private Genre convertToEntity(RegisterGenreRequest request) {
		Genre genre = new Genre();
		genre.setGenreName(request.getGenreName());
		genre.setGenreDescription(request.getGenreDescription());
		return genre;
	}

	/* Helper: Convert Genre entity to RegisterGenreResponse */
	private RegisterGenreResponse convertToResponse(Genre genre, String message) {
		return new RegisterGenreResponse(
				message,
				genre.getGenreId(),
				genre.getGenreName(),
				genre.getGenreDescription()
		);
	}
}
