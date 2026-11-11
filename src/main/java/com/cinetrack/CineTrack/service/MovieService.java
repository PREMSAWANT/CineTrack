package com.cinetrack.CineTrack.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinetrack.CineTrack.dao.ActorDao;
import com.cinetrack.CineTrack.dao.DirectorDao;
import com.cinetrack.CineTrack.dao.GenreDao;
import com.cinetrack.CineTrack.dao.MovieDao;
import com.cinetrack.CineTrack.dto.RegisterMovieRequest;
import com.cinetrack.CineTrack.dto.RegisterMovieResponse;
import com.cinetrack.CineTrack.entity.Actor;
import com.cinetrack.CineTrack.entity.Director;
import com.cinetrack.CineTrack.entity.Genre;
import com.cinetrack.CineTrack.entity.Movie;
import com.cinetrack.CineTrack.enums.Certificate;
import com.cinetrack.CineTrack.enums.MovieStatus;
import com.cinetrack.CineTrack.exception.ActorNotFoundException;
import com.cinetrack.CineTrack.exception.DirectorNotFoundException;
import com.cinetrack.CineTrack.exception.GenreNotFoundException;
import com.cinetrack.CineTrack.exception.InvalidInputException;
import com.cinetrack.CineTrack.exception.MovieAlreadyExistsException;
import com.cinetrack.CineTrack.exception.MovieNotFoundException;

@Service
public class MovieService {

	@Autowired
	private MovieDao movieDao;

	@Autowired
	private GenreDao genreDao;

	@Autowired
	private DirectorDao directorDao;

	@Autowired
	private ActorDao actorDao;

	/* 1. Add single Movie using DTO */
	public RegisterMovieResponse addMovie(RegisterMovieRequest request) {
		if (request.getTitle() == null || request.getTitle().trim().isEmpty() || request.getTitle().equalsIgnoreCase("string")) {
			throw new InvalidInputException("Movie title cannot be empty or default string.");
		}

		if (request.getDuration() != null && request.getDuration() <= 0) {
			throw new InvalidInputException("Movie duration must be greater than 0.");
		}

		if (request.getRating() != null && (request.getRating() < 0.0 || request.getRating() > 10.0)) {
			throw new InvalidInputException("Movie rating must be between 0.0 and 10.0.");
		}

		if (movieDao.existsByTitle(request.getTitle().trim())) {
			throw new MovieAlreadyExistsException("Movie already exists with Title: " + request.getTitle());
		}

		Genre genre = null;
		if (request.getGenreId() != null) {
			genre = genreDao.fetchById(request.getGenreId())
					.orElseThrow(() -> new GenreNotFoundException("Genre Not Found with Genre ID : " + request.getGenreId()));
		}

		Director director = null;
		if (request.getDirectorId() != null) {
			director = directorDao.fetchById(request.getDirectorId())
					.orElseThrow(() -> new DirectorNotFoundException("Director Not Found with Director ID : " + request.getDirectorId()));
		}

		List<Actor> actors = new ArrayList<>();
		if (request.getActorIds() != null && !request.getActorIds().isEmpty()) {
			for (Integer actorId : request.getActorIds()) {
				Actor actor = actorDao.fetchById(actorId)
						.orElseThrow(() -> new ActorNotFoundException("Actor Not Found with Actor ID : " + actorId));
				actors.add(actor);
			}
		}

		Movie movie = convertToEntity(request, genre, director, actors);
		Movie savedMovie = movieDao.createMovie(movie);
		return convertToResponse(savedMovie, "Movie created successfully");
	}

	/* 2. Add multiple Movies in batch using DTO */
	public List<RegisterMovieResponse> addAllMovies(List<RegisterMovieRequest> requests) {
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (RegisterMovieRequest req : requests) {
			responses.add(addMovie(req));
		}
		return responses;
	}

	/* 3. Fetch Movie by ID */
	public RegisterMovieResponse fetchById(Integer id) {
		Optional<Movie> optional = movieDao.fetchById(id);
		if (optional.isPresent()) {
			return convertToResponse(optional.get(), "Movie found successfully");
		}
		return null;
	}

	/* 4. Update Movie using DTO */
	public RegisterMovieResponse updateMovie(Integer id, RegisterMovieRequest request) {
		Optional<Movie> optional = movieDao.fetchById(id);
		if (!optional.isPresent()) {
			throw new MovieNotFoundException("Cannot update. Movie Not Found with Movie ID : " + id);
		}

		if (request.getRating() != null && (request.getRating() < 0.0 || request.getRating() > 10.0)) {
			throw new InvalidInputException("Movie rating must be between 0.0 and 10.0.");
		}

		Movie existing = optional.get();

		Genre genre = existing.getGenre();
		if (request.getGenreId() != null) {
			genre = genreDao.fetchById(request.getGenreId())
					.orElseThrow(() -> new GenreNotFoundException("Genre Not Found with Genre ID : " + request.getGenreId()));
		}

		Director director = existing.getDirector();
		if (request.getDirectorId() != null) {
			director = directorDao.fetchById(request.getDirectorId())
					.orElseThrow(() -> new DirectorNotFoundException("Director Not Found with Director ID : " + request.getDirectorId()));
		}

		List<Actor> actors = existing.getActors();
		if (request.getActorIds() != null) {
			actors = new ArrayList<>();
			for (Integer actorId : request.getActorIds()) {
				Actor actor = actorDao.fetchById(actorId)
						.orElseThrow(() -> new ActorNotFoundException("Actor Not Found with Actor ID : " + actorId));
				actors.add(actor);
			}
		}

		Movie newMovie = convertToEntity(request, genre, director, actors);
		Movie updatedMovie = movieDao.updateMovie(id, newMovie);
		if (updatedMovie != null) {
			return convertToResponse(updatedMovie, "Movie updated successfully");
		}
		return null;
	}

	/* 5. Fetch all Movies */
	public List<RegisterMovieResponse> fetchAllMovies() {
		List<Movie> movies = movieDao.getAllMovies();
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (Movie m : movies) {
			responses.add(convertToResponse(m, "Movie fetched successfully"));
		}
		return responses;
	}

	/* 6. Delete Movie by ID */
	public String deleteMovie(Integer id) {
		return movieDao.deleteMovie(id);
	}

	/* 7. Delete Movie by ID */
	public String deleteMovieById(Integer id) {
		return movieDao.deleteMovieById(id);
	}

	/* 8. Search Movies by Title */
	public List<RegisterMovieResponse> searchByTitle(String title) {
		List<Movie> movies = movieDao.findByTitle(title);
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (Movie m : movies) {
			responses.add(convertToResponse(m, "Movie fetched successfully"));
		}
		return responses;
	}

	/* 9. Fetch Movies by Genre */
	public List<RegisterMovieResponse> fetchByGenre(Integer genreId) {
		Optional<Genre> genreOpt = genreDao.fetchById(genreId);
		if (!genreOpt.isPresent()) {
			throw new GenreNotFoundException("Genre Not Found with Genre ID : " + genreId);
		}
		List<Movie> movies = movieDao.findByGenreId(genreId);
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (Movie m : movies) {
			responses.add(convertToResponse(m, "Movie fetched successfully"));
		}
		return responses;
	}

	/* 10. Fetch Movies by Director */
	public List<RegisterMovieResponse> fetchByDirector(Integer directorId) {
		Optional<Director> directorOpt = directorDao.fetchById(directorId);
		if (!directorOpt.isPresent()) {
			throw new DirectorNotFoundException("Director Not Found with Director ID : " + directorId);
		}
		List<Movie> movies = movieDao.findByDirectorId(directorId);
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (Movie m : movies) {
			responses.add(convertToResponse(m, "Movie fetched successfully"));
		}
		return responses;
	}

	/* 11. Fetch Movies by Language */
	public List<RegisterMovieResponse> fetchByLanguage(String language) {
		List<Movie> movies = movieDao.findByLanguage(language);
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (Movie m : movies) {
			responses.add(convertToResponse(m, "Movie fetched successfully"));
		}
		return responses;
	}

	/* 12. Fetch Movies by Minimum Rating */
	public List<RegisterMovieResponse> fetchByMinRating(Double minRating) {
		if (minRating != null && (minRating < 0.0 || minRating > 10.0)) {
			throw new InvalidInputException("Rating must be between 0.0 and 10.0.");
		}
		List<Movie> movies = movieDao.findByRatingGreaterThan(minRating);
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (Movie m : movies) {
			responses.add(convertToResponse(m, "Movie fetched successfully"));
		}
		return responses;
	}

	/* 13. Fetch Movies by Status (Enum) */
	public List<RegisterMovieResponse> fetchByStatus(MovieStatus status) {
		List<Movie> movies = movieDao.findByMovieStatus(status);
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (Movie m : movies) {
			responses.add(convertToResponse(m, "Movie fetched by status successfully"));
		}
		return responses;
	}

	/* 14. Fetch Movies by Certificate (Enum) */
	public List<RegisterMovieResponse> fetchByCertificate(Certificate certificate) {
		List<Movie> movies = movieDao.findByCertificate(certificate);
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (Movie m : movies) {
			responses.add(convertToResponse(m, "Movie fetched by certificate successfully"));
		}
		return responses;
	}

	/* 15. Fetch Family Friendly Movies (U, UA, PG_13) */
	public List<RegisterMovieResponse> fetchFamilyFriendlyMovies() {
		List<Movie> movies = movieDao.findFamilyFriendlyMovies();
		List<RegisterMovieResponse> responses = new ArrayList<>();
		for (Movie m : movies) {
			responses.add(convertToResponse(m, "Family friendly movie fetched successfully"));
		}
		return responses;
	}

	/* 16. Change Movie Status */
	public RegisterMovieResponse changeMovieStatus(Integer movieId, MovieStatus newStatus) {
		Optional<Movie> optional = movieDao.fetchById(movieId);
		if (!optional.isPresent()) {
			throw new MovieNotFoundException("Cannot change status. Movie Not Found with Movie ID : " + movieId);
		}
		Movie movie = optional.get();
		movie.setMovieStatus(newStatus);
		Movie updatedMovie = movieDao.createMovie(movie);
		return convertToResponse(updatedMovie, "Movie status changed successfully to : " + newStatus);
	}

	/* 17. Delete all Movies */
	public String deleteAll() {
		return movieDao.deleteAll();
	}

	/* Helper: Convert RegisterMovieRequest to Movie entity */
	private Movie convertToEntity(RegisterMovieRequest request, Genre genre, Director director, List<Actor> actors) {
		Movie movie = new Movie();
		movie.setTitle(request.getTitle());
		movie.setDescription(request.getDescription());
		movie.setDuration(request.getDuration());
		movie.setLanguage(request.getLanguage());
		movie.setRating(request.getRating());
		movie.setMovieStatus(request.getMovieStatus() != null ? request.getMovieStatus() : MovieStatus.RELEASED);
		movie.setCertificate(request.getCertificate() != null ? request.getCertificate() : Certificate.UA);
		movie.setGenre(genre);
		movie.setDirector(director);
		movie.setActors(actors);
		return movie;
	}

	/* Helper: Convert Movie entity to RegisterMovieResponse */
	private RegisterMovieResponse convertToResponse(Movie movie, String message) {
		Integer genreId = movie.getGenre() != null ? movie.getGenre().getGenreId() : null;
		String genreName = movie.getGenre() != null ? movie.getGenre().getGenreName() : null;

		Integer directorId = movie.getDirector() != null ? movie.getDirector().getDirectorId() : null;
		String directorName = movie.getDirector() != null ? movie.getDirector().getDirectorName() : null;

		List<Integer> actorIds = new ArrayList<>();
		List<String> actorNames = new ArrayList<>();
		if (movie.getActors() != null) {
			for (Actor a : movie.getActors()) {
				actorIds.add(a.getActorId());
				actorNames.add(a.getActorName());
			}
		}

		return new RegisterMovieResponse(
				message,
				movie.getMovieId(),
				movie.getTitle(),
				movie.getDescription(),
				movie.getDuration(),
				movie.getLanguage(),
				movie.getRating(),
				movie.getMovieStatus(),
				movie.getCertificate(),
				genreId,
				genreName,
				directorId,
				directorName,
				actorIds,
				actorNames
		);
	}
}
