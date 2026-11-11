package com.cinetrack.CineTrack.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinetrack.CineTrack.dao.ActorDao;
import com.cinetrack.CineTrack.dao.DirectorDao;
import com.cinetrack.CineTrack.dto.RegisterActorRequest;
import com.cinetrack.CineTrack.dto.RegisterActorResponse;
import com.cinetrack.CineTrack.entity.Actor;
import com.cinetrack.CineTrack.entity.Director;
import com.cinetrack.CineTrack.enums.Gender;
import com.cinetrack.CineTrack.exception.ActorNotFoundException;
import com.cinetrack.CineTrack.exception.DirectorNotFoundException;
import com.cinetrack.CineTrack.exception.InvalidInputException;

@Service
public class ActorService {

	@Autowired
	private ActorDao actorDao;

	@Autowired
	private DirectorDao directorDao;

	/* 1. Add single Actor using DTO */
	public RegisterActorResponse addActor(RegisterActorRequest request) {
		if (request.getActorName() == null || request.getActorName().trim().isEmpty() || request.getActorName().equalsIgnoreCase("string")) {
			throw new InvalidInputException("Actor name cannot be empty or default string.");
		}
		if (request.getAge() != null && request.getAge() <= 0) {
			throw new InvalidInputException("Actor age must be greater than 0.");
		}

		Director director = null;
		if (request.getDirectorId() != null) {
			director = directorDao.fetchById(request.getDirectorId())
					.orElseThrow(() -> new DirectorNotFoundException("Director Not Found with Director ID : " + request.getDirectorId()));
		}

		Actor actor = convertToEntity(request, director);
		Actor savedActor = actorDao.createActor(actor);
		return convertToResponse(savedActor, "Actor created successfully");
	}

	/* 2. Add multiple Actors in batch using DTO */
	public List<RegisterActorResponse> addAllActors(List<RegisterActorRequest> requests) {
		List<RegisterActorResponse> responses = new ArrayList<>();
		for (RegisterActorRequest req : requests) {
			responses.add(addActor(req));
		}
		return responses;
	}

	/* 3. Fetch Actor by ID */
	public RegisterActorResponse fetchById(Integer id) {
		Optional<Actor> optional = actorDao.fetchById(id);
		if (optional.isPresent()) {
			return convertToResponse(optional.get(), "Actor found successfully");
		}
		return null;
	}

	/* 4. Update Actor using DTO */
	public RegisterActorResponse updateActor(Integer id, RegisterActorRequest request) {
		Optional<Actor> optional = actorDao.fetchById(id);
		if (!optional.isPresent()) {
			throw new ActorNotFoundException("Cannot update. Actor Not Found with Actor ID : " + id);
		}

		Director director = optional.get().getDirector();
		if (request.getDirectorId() != null) {
			director = directorDao.fetchById(request.getDirectorId())
					.orElseThrow(() -> new DirectorNotFoundException("Director Not Found with Director ID : " + request.getDirectorId()));
		}

		Actor newActor = convertToEntity(request, director);
		Actor updatedActor = actorDao.updateActor(id, newActor);
		if (updatedActor != null) {
			return convertToResponse(updatedActor, "Actor updated successfully");
		}
		return null;
	}

	/* 5. Fetch all Actors */
	public List<RegisterActorResponse> fetchAllActors() {
		List<Actor> actors = actorDao.getAllActors();
		List<RegisterActorResponse> responses = new ArrayList<>();
		for (Actor a : actors) {
			responses.add(convertToResponse(a, "Actor fetched successfully"));
		}
		return responses;
	}

	/* 6. Delete Actor by ID */
	public String deleteActor(Integer id) {
		return actorDao.deleteActor(id);
	}

	/* 7. Delete Actor by ID */
	public String deleteActorById(Integer id) {
		return actorDao.deleteActorById(id);
	}

	/* 8. Get Actors greater than age */
	public List<RegisterActorResponse> getActorsGreaterThanAge(Integer age) {
		if (age != null && age < 0) {
			throw new InvalidInputException("Age cannot be negative.");
		}
		List<Actor> actors = actorDao.getActorsByAge(age);
		List<RegisterActorResponse> responses = new ArrayList<>();
		for (Actor a : actors) {
			responses.add(convertToResponse(a, "Actor fetched successfully"));
		}
		return responses;
	}

	/* 9. Get Actors by Director ID */
	public List<RegisterActorResponse> getActorsByDirectorId(Integer directorId) {
		Optional<Director> directorOpt = directorDao.fetchById(directorId);
		if (!directorOpt.isPresent()) {
			throw new DirectorNotFoundException("Director Not Found with Director ID : " + directorId);
		}
		List<Actor> actors = actorDao.getActorsByDirector(directorId);
		List<RegisterActorResponse> responses = new ArrayList<>();
		for (Actor a : actors) {
			responses.add(convertToResponse(a, "Actor fetched successfully"));
		}
		return responses;
	}

	/* 10. Get Actors by Gender */
	public List<RegisterActorResponse> getActorsByGender(Gender gender) {
		List<Actor> actors = actorDao.getActorsByGender(gender);
		List<RegisterActorResponse> responses = new ArrayList<>();
		for (Actor a : actors) {
			responses.add(convertToResponse(a, "Actor fetched by gender successfully"));
		}
		return responses;
	}

	/* 11. Count Actors by Gender */
	public long countByGender(Gender gender) {
		return actorDao.countByGender(gender);
	}

	/* 12. Delete all Actors */
	public String deleteAll() {
		return actorDao.deleteAll();
	}

	/* Helper: Convert RegisterActorRequest to Actor entity */
	private Actor convertToEntity(RegisterActorRequest request, Director director) {
		Actor actor = new Actor();
		actor.setActorName(request.getActorName());
		actor.setNationality(request.getNationality());
		actor.setAge(request.getAge());
		actor.setGender(request.getGender() != null ? request.getGender() : Gender.OTHER);
		actor.setDirector(director);
		return actor;
	}

	/* Helper: Convert Actor entity to RegisterActorResponse */
	private RegisterActorResponse convertToResponse(Actor actor, String message) {
		Integer directorId = actor.getDirector() != null ? actor.getDirector().getDirectorId() : null;
		String directorName = actor.getDirector() != null ? actor.getDirector().getDirectorName() : null;

		return new RegisterActorResponse(
				message,
				actor.getActorId(),
				actor.getActorName(),
				actor.getNationality(),
				actor.getAge(),
				actor.getGender(),
				directorId,
				directorName
		);
	}
}
