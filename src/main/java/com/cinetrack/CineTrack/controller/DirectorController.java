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

import com.cinetrack.CineTrack.dto.RegisterDirectorRequest;
import com.cinetrack.CineTrack.dto.RegisterDirectorResponse;
import com.cinetrack.CineTrack.exception.DirectorNotFoundException;
import com.cinetrack.CineTrack.service.DirectorService;

@RestController
@RequestMapping({"/api/director", "/api/directors"})
public class DirectorController {

	@Autowired
	private DirectorService directorService;

	/* 1. Add single Director using DTO */
	@PostMapping("/save")
	public ResponseEntity<RegisterDirectorResponse> addDirector(@RequestBody RegisterDirectorRequest request) {
		RegisterDirectorResponse response = directorService.addDirector(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}

	/* 2. Add multiple Directors in batch using DTO */
	@PostMapping("/saveAll")
	public ResponseEntity<List<RegisterDirectorResponse>> addAllDirectors(@RequestBody List<RegisterDirectorRequest> requests) {
		List<RegisterDirectorResponse> responses = directorService.addAllDirectors(requests);
		return ResponseEntity.status(HttpStatus.CREATED).body(responses);
	}

	/* 3. Fetch Director by ID */
	@GetMapping("/fetchById/{id}")
	public ResponseEntity<RegisterDirectorResponse> fetchById(@PathVariable Integer id) {
		RegisterDirectorResponse response = directorService.fetchById(id);
		if (response != null) {
			return ResponseEntity.status(HttpStatus.OK).body(response);
		}
		throw new DirectorNotFoundException("Director Not Found with Director ID : " + id);
	}

	/* 4. Update Director using DTO */
	@PutMapping("/update/{id}")
	public ResponseEntity<RegisterDirectorResponse> updateDirector(@PathVariable Integer id, @RequestBody RegisterDirectorRequest request) {
		RegisterDirectorResponse response = directorService.updateDirector(id, request);
		if (response != null) {
			return ResponseEntity.status(HttpStatus.OK).body(response);
		}
		throw new DirectorNotFoundException("Director Not Found with Director ID : " + id);
	}

	/* 5. Fetch all Directors */
	@GetMapping("/getAll")
	public ResponseEntity<List<RegisterDirectorResponse>> fetchAllDirectors() {
		List<RegisterDirectorResponse> responses = directorService.fetchAllDirectors();
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 6. Delete Director by ID */
	@DeleteMapping("/deleteById/{directorId}")
	public ResponseEntity<String> saveDeletedDirector(@PathVariable Integer directorId) {
		RegisterDirectorResponse existing = directorService.fetchById(directorId);
		if (existing == null) {
			throw new DirectorNotFoundException("Director Not Found with Director ID : " + directorId);
		}
		String result = directorService.deleteDirector(directorId);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}

	/* 7. Delete Director by ID */
	@DeleteMapping("/delete/{directorId}")
	public ResponseEntity<String> saveDelete(@PathVariable Integer directorId) {
		RegisterDirectorResponse existing = directorService.fetchById(directorId);
		if (existing == null) {
			throw new DirectorNotFoundException("Director Not Found with Director ID : " + directorId);
		}
		String result = directorService.deleteDirectorById(directorId);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}

	/* 8. Find Directors by Name */
	@GetMapping("/findByName/{name}")
	public ResponseEntity<List<RegisterDirectorResponse>> findByName(@PathVariable String name) {
		List<RegisterDirectorResponse> responses = directorService.findByName(name);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 9. Delete all Directors */
	@DeleteMapping("/deleteAll")
	public ResponseEntity<String> deleteAll() {
		String result = directorService.deleteAll();
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
}
