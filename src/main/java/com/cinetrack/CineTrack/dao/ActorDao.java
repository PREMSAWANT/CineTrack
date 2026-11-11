package com.cinetrack.CineTrack.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cinetrack.CineTrack.entity.Actor;
import com.cinetrack.CineTrack.enums.Gender;
import com.cinetrack.CineTrack.repository.ActorRepository;

@Repository
public class ActorDao {

	@Autowired
	private ActorRepository actorRepository;

	/*
	 * 1. Saves actor using actorRepository.save() and returns the saved Actor
	 * (with generated ID) to the service.
	 */
	public Actor createActor(Actor actor) {
		return actorRepository.save(actor);
	}

	/*
	 * 2. Uses saveAll() method from ActorRepository (JpaRepository) to batch insert
	 * multiple actors and returns the saved list (with generated IDs) to the
	 * service.
	 */
	public List<Actor> createAllActors(List<Actor> actors) {
		return actorRepository.saveAll(actors);
	}

	/*
	 * 3. Uses findById() method from ActorRepository (JpaRepository) to fetch an
	 * actor record by ID and returns an Optional containing the Actor to the service.
	 */
	public Optional<Actor> fetchById(Integer actorId) {
		Optional<Actor> byId = actorRepository.findById(actorId);
		if (byId.isPresent())
			return byId;
		return Optional.empty();
	}

	/*
	 * 4. create method --> update a record --> save(T Entity)
	 */
	public Actor updateActor(Integer actorId, Actor newActor) {
		Optional<Actor> byId = actorRepository.findById(actorId);
		if (byId.isPresent()) {
			Actor existingActor = byId.get();
			Actor finalActor = new Actor();

			finalActor.setActorId(existingActor.getActorId());

			// Name check: if null, empty, or Swagger default "string", keep existing
			if (newActor.getActorName() != null && !newActor.getActorName().trim().isEmpty() && !newActor.getActorName().equalsIgnoreCase("string")) {
				finalActor.setActorName(newActor.getActorName());
			} else {
				finalActor.setActorName(existingActor.getActorName());
			}

			// Nationality check: if null, empty, or Swagger default "string", keep existing
			if (newActor.getNationality() != null && !newActor.getNationality().trim().isEmpty() && !newActor.getNationality().equalsIgnoreCase("string")) {
				finalActor.setNationality(newActor.getNationality());
			} else {
				finalActor.setNationality(existingActor.getNationality());
			}

			// Age check: if null or <= 0, keep existing
			if (newActor.getAge() != null && newActor.getAge() > 0) {
				finalActor.setAge(newActor.getAge());
			} else {
				finalActor.setAge(existingActor.getAge());
			}

			// Gender check
			if (newActor.getGender() != null) {
				finalActor.setGender(newActor.getGender());
			} else {
				finalActor.setGender(existingActor.getGender());
			}

			// Director check
			if (newActor.getDirector() != null) {
				finalActor.setDirector(newActor.getDirector());
			} else {
				finalActor.setDirector(existingActor.getDirector());
			}

			finalActor.setMovies(existingActor.getMovies());

			return actorRepository.save(finalActor);
		}
		return null;
	}

	/*
	 * 5. create method --> getAllActors()
	 */
	public List<Actor> getAllActors() {
		return actorRepository.findAll();
	}

	/*
	 * 6. create method --> delete single record --> deleteById(ID id)
	 */
	public String deleteActor(Integer actorId) {
		Optional<Actor> byId = actorRepository.findById(actorId);
		if (!byId.isPresent()) {
			return null;
		}
		actorRepository.deleteById(actorId);
		return "Actor Record Deleted Successfully with ID : " + actorId;
	}

	/*
	 * 7. create method --> delete single record --> delete(T Entity)
	 */
	public String deleteActorById(Integer actorId) {
		Optional<Actor> byId = actorRepository.findById(actorId);
		if (!byId.isPresent()) {
			return null;
		}
		Actor actor = byId.get();
		actorRepository.delete(actor);
		return "Actor Record Deleted Successfully with ID : " + actorId;
	}

	/*
	 * 8. call method --> findActorGreaterThanAge(int age)
	 */
	public List<Actor> getActorsByAge(Integer age) {
		return actorRepository.findActorGreaterThanAge(age);
	}

	/*
	 * 9. call method --> findByDirector_DirectorId(Integer directorId)
	 */
	public List<Actor> getActorsByDirector(Integer directorId) {
		return actorRepository.findByDirector_DirectorId(directorId);
	}

	/*
	 * 10. call method --> findByGender(Gender gender)
	 */
	public List<Actor> getActorsByGender(Gender gender) {
		return actorRepository.findByGender(gender);
	}

	/*
	 * 11. count actors by gender
	 */
	public long countByGender(Gender gender) {
		return actorRepository.countByGender(gender);
	}

	/*
	 * 12. Uses deleteAll() method from ActorRepository to delete all actors.
	 */
	public String deleteAll() {
		actorRepository.deleteAll();
		return "All actor records deleted successfully.";
	}

	/*
	 * 13. findAllById(Iterable<Integer> ids)
	 */
	public List<Actor> findAllById(Iterable<Integer> ids) {
		return actorRepository.findAllById(ids);
	}

	/*
	 * 14. count actors
	 */
	public long countActors() {
		return actorRepository.count();
	}
}
