package com.cinetrack.CineTrack.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cinetrack.CineTrack.dto.RegisterMovieRequest;
import com.cinetrack.CineTrack.dto.RegisterMovieResponse;
import com.cinetrack.CineTrack.enums.Certificate;
import com.cinetrack.CineTrack.enums.MovieStatus;
import com.cinetrack.CineTrack.exception.MovieNotFoundException;
import com.cinetrack.CineTrack.service.MovieService;

@RestController
@RequestMapping({"/api/movie", "/api/movies"})
public class MovieController {

	@Autowired
	private MovieService movieService;

	/* 1. Add single Movie using DTO */
	@PostMapping("/save")
	public ResponseEntity<RegisterMovieResponse> addMovie(@RequestBody RegisterMovieRequest request) {
		RegisterMovieResponse response = movieService.addMovie(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}

	/* 2. Add multiple Movies in batch using DTO */
	@PostMapping("/saveAll")
	public ResponseEntity<List<RegisterMovieResponse>> addAllMovies(@RequestBody List<RegisterMovieRequest> requests) {
		List<RegisterMovieResponse> responses = movieService.addAllMovies(requests);
		return ResponseEntity.status(HttpStatus.CREATED).body(responses);
	}

	/* 3. Fetch Movie by ID */
	@GetMapping("/fetchById/{id}")
	public ResponseEntity<RegisterMovieResponse> fetchById(@PathVariable Integer id) {
		RegisterMovieResponse response = movieService.fetchById(id);
		if (response != null) {
			return ResponseEntity.status(HttpStatus.OK).body(response);
		}
		throw new MovieNotFoundException("Movie Not Found with Movie ID : " + id);
	}

	/* 4. Update Movie using DTO */
	@PutMapping("/update/{id}")
	public ResponseEntity<RegisterMovieResponse> updateMovie(@PathVariable Integer id, @RequestBody RegisterMovieRequest request) {
		RegisterMovieResponse response = movieService.updateMovie(id, request);
		if (response != null) {
			return ResponseEntity.status(HttpStatus.OK).body(response);
		}
		throw new MovieNotFoundException("Movie Not Found with Movie ID : " + id);
	}

	/* 5. Fetch all Movies */
	@GetMapping("/getAll")
	public ResponseEntity<List<RegisterMovieResponse>> fetchAllMovies() {
		List<RegisterMovieResponse> responses = movieService.fetchAllMovies();
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 6. Delete Movie by ID */
	@DeleteMapping("/deleteById/{movieId}")
	public ResponseEntity<String> saveDeletedMovie(@PathVariable Integer movieId) {
		RegisterMovieResponse existing = movieService.fetchById(movieId);
		if (existing == null) {
			throw new MovieNotFoundException("Movie Not Found with Movie ID : " + movieId);
		}
		String result = movieService.deleteMovie(movieId);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}

	/* 7. Delete Movie by ID */
	@DeleteMapping("/delete/{movieId}")
	public ResponseEntity<String> saveDelete(@PathVariable Integer movieId) {
		RegisterMovieResponse existing = movieService.fetchById(movieId);
		if (existing == null) {
			throw new MovieNotFoundException("Movie Not Found with Movie ID : " + movieId);
		}
		String result = movieService.deleteMovieById(movieId);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}

	/* 8. Search Movies by Title */
	@GetMapping("/search/{title}")
	public ResponseEntity<List<RegisterMovieResponse>> searchByTitle(@PathVariable String title) {
		List<RegisterMovieResponse> responses = movieService.searchByTitle(title);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 9. Fetch Movies by Genre ID */
	@GetMapping("/byGenre/{genreId}")
	public ResponseEntity<List<RegisterMovieResponse>> fetchByGenre(@PathVariable Integer genreId) {
		List<RegisterMovieResponse> responses = movieService.fetchByGenre(genreId);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 10. Fetch Movies by Director ID */
	@GetMapping("/byDirector/{directorId}")
	public ResponseEntity<List<RegisterMovieResponse>> fetchByDirector(@PathVariable Integer directorId) {
		List<RegisterMovieResponse> responses = movieService.fetchByDirector(directorId);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 11. Fetch Movies by Language */
	@GetMapping("/byLanguage/{language}")
	public ResponseEntity<List<RegisterMovieResponse>> fetchByLanguage(@PathVariable String language) {
		List<RegisterMovieResponse> responses = movieService.fetchByLanguage(language);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 12. Fetch Movies by Minimum Rating */
	@GetMapping("/byRating/{rating}")
	public ResponseEntity<List<RegisterMovieResponse>> fetchByRating(@PathVariable Double rating) {
		List<RegisterMovieResponse> responses = movieService.fetchByMinRating(rating);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 13. Fetch Movies by Status (Enum) */
	@GetMapping("/byStatus/{status}")
	public ResponseEntity<List<RegisterMovieResponse>> fetchByStatus(@PathVariable MovieStatus status) {
		List<RegisterMovieResponse> responses = movieService.fetchByStatus(status);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 14. Fetch Movies by Certificate (Enum) */
	@GetMapping("/byCertificate/{certificate}")
	public ResponseEntity<List<RegisterMovieResponse>> fetchByCertificate(@PathVariable Certificate certificate) {
		List<RegisterMovieResponse> responses = movieService.fetchByCertificate(certificate);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 15. Fetch Family Friendly Movies (U, UA, PG_13) */
	@GetMapping("/familyFriendly")
	public ResponseEntity<List<RegisterMovieResponse>> fetchFamilyFriendly() {
		List<RegisterMovieResponse> responses = movieService.fetchFamilyFriendlyMovies();
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 16. Change Movie Status */
	@PutMapping("/changeStatus/{movieId}/{status}")
	public ResponseEntity<RegisterMovieResponse> changeStatus(@PathVariable Integer movieId, @PathVariable MovieStatus status) {
		RegisterMovieResponse response = movieService.changeMovieStatus(movieId, status);
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}

	/* 17. Delete all Movies */
	@DeleteMapping("/deleteAll")
	public ResponseEntity<String> deleteAll() {
		String result = movieService.deleteAll();
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
}
