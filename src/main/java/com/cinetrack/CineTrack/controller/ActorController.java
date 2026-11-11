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

import com.cinetrack.CineTrack.dto.RegisterActorRequest;
import com.cinetrack.CineTrack.dto.RegisterActorResponse;
import com.cinetrack.CineTrack.enums.Gender;
import com.cinetrack.CineTrack.exception.ActorNotFoundException;
import com.cinetrack.CineTrack.service.ActorService;

@RestController
@RequestMapping({"/api/actor", "/api/actors"})
public class ActorController {

	@Autowired
	private ActorService actorService;

	/* 1. Add single Actor using DTO */
	@PostMapping("/save")
	public ResponseEntity<RegisterActorResponse> addActor(@RequestBody RegisterActorRequest request) {
		RegisterActorResponse response = actorService.addActor(request);
		return ResponseEntity.status(HttpStatus.CREATED).body(response);
	}

	/* 2. Add multiple Actors in batch using DTO */
	@PostMapping("/saveAll")
	public ResponseEntity<List<RegisterActorResponse>> addAllActors(@RequestBody List<RegisterActorRequest> requests) {
		List<RegisterActorResponse> responses = actorService.addAllActors(requests);
		return ResponseEntity.status(HttpStatus.CREATED).body(responses);
	}

	/* 3. Fetch Actor by ID */
	@GetMapping("/fetchById/{id}")
	public ResponseEntity<RegisterActorResponse> fetchById(@PathVariable Integer id) {
		RegisterActorResponse response = actorService.fetchById(id);
		if (response != null) {
			return ResponseEntity.status(HttpStatus.OK).body(response);
		}
		throw new ActorNotFoundException("Actor Not Found with Actor ID : " + id);
	}

	/* 4. Update Actor using DTO */
	@PutMapping("/update/{id}")
	public ResponseEntity<RegisterActorResponse> updateActor(@PathVariable Integer id, @RequestBody RegisterActorRequest request) {
		RegisterActorResponse response = actorService.updateActor(id, request);
		if (response != null) {
			return ResponseEntity.status(HttpStatus.OK).body(response);
		}
		throw new ActorNotFoundException("Actor Not Found with Actor ID : " + id);
	}

	/* 5. Fetch all Actors */
	@GetMapping("/getAll")
	public ResponseEntity<List<RegisterActorResponse>> fetchAllActors() {
		List<RegisterActorResponse> responses = actorService.fetchAllActors();
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 6. Delete Actor by ID */
	@DeleteMapping("/deleteById/{actorId}")
	public ResponseEntity<String> saveDeletedActor(@PathVariable Integer actorId) {
		RegisterActorResponse existing = actorService.fetchById(actorId);
		if (existing == null) {
			throw new ActorNotFoundException("Actor Not Found with Actor ID : " + actorId);
		}
		String result = actorService.deleteActor(actorId);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}

	/* 7. Delete Actor by ID */
	@DeleteMapping("/delete/{actorId}")
	public ResponseEntity<String> saveDelete(@PathVariable Integer actorId) {
		RegisterActorResponse existing = actorService.fetchById(actorId);
		if (existing == null) {
			throw new ActorNotFoundException("Actor Not Found with Actor ID : " + actorId);
		}
		String result = actorService.deleteActorById(actorId);
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}

	/* 8. Get Actors greater than age */
	@GetMapping("/getActorByAge/{age}")
	public ResponseEntity<List<RegisterActorResponse>> getActorByAge(@PathVariable Integer age) {
		List<RegisterActorResponse> responses = actorService.getActorsGreaterThanAge(age);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 9. Get Actors by Director ID */
	@GetMapping("/getActorsByDirector/{directorId}")
	public ResponseEntity<List<RegisterActorResponse>> getActorsByDirector(@PathVariable Integer directorId) {
		List<RegisterActorResponse> responses = actorService.getActorsByDirectorId(directorId);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 10. Get Actors by Gender */
	@GetMapping("/byGender/{gender}")
	public ResponseEntity<List<RegisterActorResponse>> getActorsByGender(@PathVariable Gender gender) {
		List<RegisterActorResponse> responses = actorService.getActorsByGender(gender);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 11. Count Actors by Gender */
	@GetMapping("/countByGender/{gender}")
	public ResponseEntity<Long> countByGender(@PathVariable Gender gender) {
		long count = actorService.countByGender(gender);
		return ResponseEntity.status(HttpStatus.OK).body(count);
	}

	/* 12. Delete all Actors */
	@DeleteMapping("/deleteAll")
	public ResponseEntity<String> deleteAll() {
		String result = actorService.deleteAll();
		return ResponseEntity.status(HttpStatus.OK).body(result);
	}
}
