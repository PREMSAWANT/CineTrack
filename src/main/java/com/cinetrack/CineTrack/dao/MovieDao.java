package com.cinetrack.CineTrack.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cinetrack.CineTrack.entity.Movie;
import com.cinetrack.CineTrack.enums.Certificate;
import com.cinetrack.CineTrack.enums.MovieStatus;
import com.cinetrack.CineTrack.repository.MovieRepository;

@Repository
public class MovieDao {

	@Autowired
	private MovieRepository movieRepository;

	/*
	 * 1. Saves movie using movieRepository.save() and returns the saved Movie
	 * (with generated ID) to the service.
	 */
	public Movie createMovie(Movie movie) {
		return movieRepository.save(movie);
	}

	/*
	 * 2. Uses saveAll() method from MovieRepository (JpaRepository) to batch
	 * insert multiple movies and returns the saved list to the service.
	 */
	public List<Movie> createAllMovies(List<Movie> movies) {
		return movieRepository.saveAll(movies);
	}

	/*
	 * 3. Uses findById() method from MovieRepository (JpaRepository) to fetch a
	 * movie record by ID and returns an Optional to the service.
	 */
	public Optional<Movie> fetchById(Integer movieId) {
		Optional<Movie> byId = movieRepository.findById(movieId);
		if (byId.isPresent())
			return byId;
		return Optional.empty();
	}

	/*
	 * 4. create method --> update a record --> save(T Entity)
	 */
	public Movie updateMovie(Integer movieId, Movie newMovie) {
		Optional<Movie> byId = movieRepository.findById(movieId);
		if (byId.isPresent()) {
			Movie existingMovie = byId.get();
			Movie finalMovie = new Movie();

			finalMovie.setMovieId(existingMovie.getMovieId());

			// Title check: if null, empty, or Swagger default "string", keep existing
			if (newMovie.getTitle() != null && !newMovie.getTitle().trim().isEmpty()
					&& !newMovie.getTitle().equalsIgnoreCase("string")) {
				finalMovie.setTitle(newMovie.getTitle());
			} else {
				finalMovie.setTitle(existingMovie.getTitle());
			}

			// Description check: if null, empty, or Swagger default "string", keep existing
			if (newMovie.getDescription() != null && !newMovie.getDescription().trim().isEmpty()
					&& !newMovie.getDescription().equalsIgnoreCase("string")) {
				finalMovie.setDescription(newMovie.getDescription());
			} else {
				finalMovie.setDescription(existingMovie.getDescription());
			}

			// Duration check
			if (newMovie.getDuration() != null && newMovie.getDuration() > 0) {
				finalMovie.setDuration(newMovie.getDuration());
			} else {
				finalMovie.setDuration(existingMovie.getDuration());
			}

			// Language check: if null, empty, or Swagger default "string", keep existing
			if (newMovie.getLanguage() != null && !newMovie.getLanguage().trim().isEmpty()
					&& !newMovie.getLanguage().equalsIgnoreCase("string")) {
				finalMovie.setLanguage(newMovie.getLanguage());
			} else {
				finalMovie.setLanguage(existingMovie.getLanguage());
			}

			// Rating check
			if (newMovie.getRating() != null && newMovie.getRating() >= 0.0) {
				finalMovie.setRating(newMovie.getRating());
			} else {
				finalMovie.setRating(existingMovie.getRating());
			}

			// MovieStatus check
			if (newMovie.getMovieStatus() != null) {
				finalMovie.setMovieStatus(newMovie.getMovieStatus());
			} else {
				finalMovie.setMovieStatus(existingMovie.getMovieStatus());
			}

			// Certificate check
			if (newMovie.getCertificate() != null) {
				finalMovie.setCertificate(newMovie.getCertificate());
			} else {
				finalMovie.setCertificate(existingMovie.getCertificate());
			}

			// Genre check
			if (newMovie.getGenre() != null) {
				finalMovie.setGenre(newMovie.getGenre());
			} else {
				finalMovie.setGenre(existingMovie.getGenre());
			}

			// Director check
			if (newMovie.getDirector() != null) {
				finalMovie.setDirector(newMovie.getDirector());
			} else {
				finalMovie.setDirector(existingMovie.getDirector());
			}

			// Actors check
			if (newMovie.getActors() != null) {
				finalMovie.setActors(newMovie.getActors());
			} else {
				finalMovie.setActors(existingMovie.getActors());
			}

			return movieRepository.save(finalMovie);
		}
		return null;
	}

	/*
	 * 5. create method --> getAllMovies()
	 */
	public List<Movie> getAllMovies() {
		return movieRepository.findAll();
	}

	/*
	 * 6. create method --> delete single record --> deleteById(ID id)
	 */
	public String deleteMovie(Integer movieId) {
		Optional<Movie> byId = movieRepository.findById(movieId);
		if (!byId.isPresent()) {
			return null;
		}
		movieRepository.deleteById(movieId);
		return "Movie Record Deleted Successfully with ID : " + movieId;
	}

	/*
	 * 7. create method --> delete single record --> delete(T Entity)
	 */
	public String deleteMovieById(Integer movieId) {
		Optional<Movie> byId = movieRepository.findById(movieId);
		if (!byId.isPresent()) {
			return null;
		}
		Movie movie = byId.get();
		movieRepository.delete(movie);
		return "Movie Record Deleted Successfully with ID : " + movieId;
	}

	/*
	 * 8. find by title
	 */
	public List<Movie> findByTitle(String title) {
		return movieRepository.findByTitleContainingIgnoreCase(title);
	}

	/*
	 * 9. find by exact title
	 */
	public Optional<Movie> findByExactTitle(String title) {
		return movieRepository.findByTitleIgnoreCase(title);
	}

	/*
	 * 10. exists by title
	 */
	public boolean existsByTitle(String title) {
		return movieRepository.existsByTitleIgnoreCase(title);
	}

	/*
	 * 11. find by language
	 */
	public List<Movie> findByLanguage(String language) {
		return movieRepository.findByLanguageIgnoreCase(language);
	}

	/*
	 * 12. find by genre id
	 */
	public List<Movie> findByGenreId(Integer genreId) {
		return movieRepository.findByGenre_GenreId(genreId);
	}

	/*
	 * 13. find by director id
	 */
	public List<Movie> findByDirectorId(Integer directorId) {
		return movieRepository.findByDirector_DirectorId(directorId);
	}

	/*
	 * 14. find by minimum rating
	 */
	public List<Movie> findByRatingGreaterThan(Double rating) {
		return movieRepository.findMovieByRatingGreaterThan(rating);
	}

	/*
	 * 15. find by movie status
	 */
	public List<Movie> findByMovieStatus(MovieStatus status) {
		return movieRepository.findByMovieStatus(status);
	}

	/*
	 * 16. find by certificate
	 */
	public List<Movie> findByCertificate(Certificate certificate) {
		return movieRepository.findByCertificate(certificate);
	}

	/*
	 * 17. find family friendly movies
	 */
	public List<Movie> findFamilyFriendlyMovies() {
		return movieRepository.findFamilyFriendlyMovies();
	}

	/*
	 * 18. count by movie status
	 */
	public long countByMovieStatus(MovieStatus status) {
		return movieRepository.countByMovieStatus(status);
	}

	/*
	 * 19. Uses deleteAll() method from MovieRepository to delete all movies.
	 */
	public String deleteAll() {
		movieRepository.deleteAll();
		return "All movie records deleted successfully.";
	}

	/*
	 * 20. count movies
	 */
	public long countMovies() {
		return movieRepository.count();
	}
}
