package com.cinetrack.CineTrack.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cinetrack.CineTrack.entity.Director;
import com.cinetrack.CineTrack.repository.DirectorRepository;

@Repository
public class DirectorDao {

	@Autowired
	private DirectorRepository directorRepository;

	/*
	 * 1. Saves director using directorRepository.save() and returns the saved
	 * Director (with generated ID) to the service.
	 */
	public Director createDirector(Director director) {
		return directorRepository.save(director);
	}

	/*
	 * 2. Uses saveAll() method from DirectorRepository (JpaRepository) to batch
	 * insert multiple directors and returns the saved list to the service.
	 */
	public List<Director> createAllDirectors(List<Director> directors) {
		return directorRepository.saveAll(directors);
	}

	/*
	 * 3. Uses findById() method from DirectorRepository (JpaRepository) to fetch a
	 * director record by ID and returns an Optional to the service.
	 */
	public Optional<Director> fetchById(Integer directorId) {
		Optional<Director> byId = directorRepository.findById(directorId);
		if (byId.isPresent())
			return byId;
		return Optional.empty();
	}

	/*
	 * 4. create method --> update a record --> save(T Entity)
	 */
	public Director updateDirector(Integer directorId, Director newDirector) {
		Optional<Director> byId = directorRepository.findById(directorId);
		if (byId.isPresent()) {
			Director existingDirector = byId.get();
			Director finalDirector = new Director();

			finalDirector.setDirectorId(existingDirector.getDirectorId());

			// Name check: if null, empty, or Swagger default "string", keep existing
			if (newDirector.getDirectorName() != null && !newDirector.getDirectorName().trim().isEmpty()
					&& !newDirector.getDirectorName().equalsIgnoreCase("string")) {
				finalDirector.setDirectorName(newDirector.getDirectorName());
			} else {
				finalDirector.setDirectorName(existingDirector.getDirectorName());
			}

			// Nationality check: if null, empty, or Swagger default "string", keep existing
			if (newDirector.getNationality() != null && !newDirector.getNationality().trim().isEmpty()
					&& !newDirector.getNationality().equalsIgnoreCase("string")) {
				finalDirector.setNationality(newDirector.getNationality());
			} else {
				finalDirector.setNationality(existingDirector.getNationality());
			}

			finalDirector.setMovies(existingDirector.getMovies());
			finalDirector.setActors(existingDirector.getActors());

			return directorRepository.save(finalDirector);
		}
		return null;
	}

	/*
	 * 5. create method --> getAllDirectors()
	 */
	public List<Director> getAllDirectors() {
		return directorRepository.findAll();
	}

	/*
	 * 6. create method --> delete single record --> deleteById(ID id)
	 */
	public String deleteDirector(Integer directorId) {
		Optional<Director> byId = directorRepository.findById(directorId);
		if (!byId.isPresent()) {
			return null;
		}
		directorRepository.deleteById(directorId);
		return "Director Record Deleted Successfully with ID : " + directorId;
	}

	/*
	 * 7. create method --> delete single record --> delete(T Entity)
	 */
	public String deleteDirectorById(Integer directorId) {
		Optional<Director> byId = directorRepository.findById(directorId);
		if (!byId.isPresent()) {
			return null;
		}
		Director director = byId.get();
		directorRepository.delete(director);
		return "Director Record Deleted Successfully with ID : " + directorId;
	}

	/*
	 * 8. find by director name
	 */
	public List<Director> findByName(String name) {
		return directorRepository.findByDirectorNameContainingIgnoreCase(name);
	}

	/*
	 * 9. find by nationality
	 */
	public List<Director> findByNationality(String nationality) {
		return directorRepository.findByNationalityIgnoreCase(nationality);
	}

	/*
	 * 10. check if exists by name
	 */
	public boolean existsByName(String name) {
		return directorRepository.existsByDirectorNameIgnoreCase(name);
	}

	/*
	 * 11. Uses deleteAll() method from DirectorRepository to delete all directors.
	 */
	public String deleteAll() {
		directorRepository.deleteAll();
		return "All director records deleted successfully.";
	}

	/*
	 * 12. count directors
	 */
	public long countDirectors() {
		return directorRepository.count();
	}
}
