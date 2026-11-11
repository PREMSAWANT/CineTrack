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

import com.cinetrack.CineTrack.dto.RegisterGenreRequest;
import com.cinetrack.CineTrack.dto.RegisterGenreResponse;
import com.cinetrack.CineTrack.exception.GenreNotFoundException;
import com.cinetrack.CineTrack.service.GenreService;

@RestController
@RequestMapping({"/api/genre", "/api/genres"})
public class GenreController {

	@Autowired
	private GenreService genreService;

	/* 1. Add single Genre using DTO */
	@PostMapping("/save")
	public ResponseEntity<RegisterGenreResponse> addGenre(@RequestBody RegisterGenreRequest request) {
		RegisterGenreResponse response = genreService.addGenre(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}

	/* 2. Add multiple Genres in batch using DTO */
	@PostMapping("/saveAll")
	public ResponseEntity<List<RegisterGenreResponse>> addAllGenres(@RequestBody List<RegisterGenreRequest> requests) {
		List<RegisterGenreResponse> responses = genreService.addAllGenres(requests);
		return ResponseEntity.status(HttpStatus.CREATED).body(responses);
	}

	/* 3. Fetch Genre by ID */
	@GetMapping("/fetchById/{id}")
	public ResponseEntity<RegisterGenreResponse> fetchById(@PathVariable Integer id) {
		RegisterGenreResponse response = genreService.fetchById(id);
		if (response != null) {
			return ResponseEntity.status(HttpStatus.OK).body(response);
		}
		throw new GenreNotFoundException("Genre Not Found with Genre ID : " + id);
	}

	/* 4. Update Genre using DTO */
	@PutMapping("/update/{id}")
	public ResponseEntity<RegisterGenreResponse> updateGenre(@PathVariable Integer id, @RequestBody RegisterGenreRequest request) {
		RegisterGenreResponse response = genreService.updateGenre(id, request);
		if (response != null) {
			return ResponseEntity.status(HttpStatus.OK).body(response);
		}
		throw new GenreNotFoundException("Genre Not Found with Genre ID : " + id);
	}

	/* 5. Fetch all Genres */
	@GetMapping("/getAll")
	public ResponseEntity<List<RegisterGenreResponse>> fetchAllGenres() {
		List<RegisterGenreResponse> responses = genreService.fetchAllGenres();
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 6. Delete Genre by ID */
	@DeleteMapping("/deleteById/{genreId}")
	public ResponseEntity<String> saveDeletedGenre(@PathVariable Integer genreId) {
		RegisterGenreResponse existing = genreService.fetchById(genreId);
		if (existing == null) {
			throw new GenreNotFoundException("Genre Not Found with Genre ID : " + genreId);
		}
		String result = genreService.deleteGenre(genreId);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}

	/* 7. Delete Genre by ID */
	@DeleteMapping("/delete/{genreId}")
	public ResponseEntity<String> saveDelete(@PathVariable Integer genreId) {
		RegisterGenreResponse existing = genreService.fetchById(genreId);
		if (existing == null) {
			throw new GenreNotFoundException("Genre Not Found with Genre ID : " + genreId);
		}
		String result = genreService.deleteGenreById(genreId);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}

	/* 8. Delete all Genres */
	@DeleteMapping("/deleteAll")
	public ResponseEntity<String> deleteAll() {
		String result = genreService.deleteAll();
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
}
