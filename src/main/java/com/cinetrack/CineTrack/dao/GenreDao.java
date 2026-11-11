package com.cinetrack.CineTrack.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cinetrack.CineTrack.entity.Genre;
import com.cinetrack.CineTrack.repository.GenreRepository;

@Repository
public class GenreDao {

	@Autowired
	private GenreRepository genreRepository;

	/*
	 * 1. Saves genre using genreRepository.save() and returns the saved Genre
	 * (with generated ID) to the service.
	 */
	public Genre createGenre(Genre genre) {
		return genreRepository.save(genre);
	}

	/*
	 * 2. Uses saveAll() method from GenreRepository (JpaRepository) to batch
	 * insert multiple genres and returns the saved list to the service.
	 */
	public List<Genre> createAllGenres(List<Genre> genres) {
		return genreRepository.saveAll(genres);
	}

	/*
	 * 3. Uses findById() method from GenreRepository (JpaRepository) to fetch a
	 * genre record by ID and returns an Optional to the service.
	 */
	public Optional<Genre> fetchById(Integer genreId) {
		Optional<Genre> byId = genreRepository.findById(genreId);
		if (byId.isPresent())
			return byId;
		return Optional.empty();
	}

	/*
	 * 4. create method --> update a record --> save(T Entity)
	 */
	public Genre updateGenre(Integer genreId, Genre newGenre) {
		Optional<Genre> byId = genreRepository.findById(genreId);
		if (byId.isPresent()) {
			Genre existingGenre = byId.get();
			Genre finalGenre = new Genre();

			finalGenre.setGenreId(existingGenre.getGenreId());

			// Name check: if null, empty, or Swagger default "string", keep existing
			if (newGenre.getGenreName() != null && !newGenre.getGenreName().trim().isEmpty()
					&& !newGenre.getGenreName().equalsIgnoreCase("string")) {
				finalGenre.setGenreName(newGenre.getGenreName());
			} else {
				finalGenre.setGenreName(existingGenre.getGenreName());
			}

			// Description check: if null, empty, or Swagger default "string", keep existing
			if (newGenre.getGenreDescription() != null && !newGenre.getGenreDescription().trim().isEmpty()
					&& !newGenre.getGenreDescription().equalsIgnoreCase("string")) {
				finalGenre.setGenreDescription(newGenre.getGenreDescription());
			} else {
				finalGenre.setGenreDescription(existingGenre.getGenreDescription());
			}

			finalGenre.setMovies(existingGenre.getMovies());

			return genreRepository.save(finalGenre);
		}
		return null;
	}

	/*
	 * 5. create method --> getAllGenres()
	 */
	public List<Genre> getAllGenres() {
		return genreRepository.findAll();
	}

	/*
	 * 6. create method --> delete single record --> deleteById(ID id)
	 */
	public String deleteGenre(Integer genreId) {
		Optional<Genre> byId = genreRepository.findById(genreId);
		if (!byId.isPresent()) {
			return null;
		}
		genreRepository.deleteById(genreId);
		return "Genre Record Deleted Successfully with ID : " + genreId;
	}

	/*
	 * 7. create method --> delete single record --> delete(T Entity)
	 */
	public String deleteGenreById(Integer genreId) {
		Optional<Genre> byId = genreRepository.findById(genreId);
		if (!byId.isPresent()) {
			return null;
		}
		Genre genre = byId.get();
		genreRepository.delete(genre);
		return "Genre Record Deleted Successfully with ID : " + genreId;
	}

	/*
	 * 8. find by genre name
	 */
	public Optional<Genre> findByName(String name) {
		return genreRepository.findByGenreNameIgnoreCase(name);
	}

	/*
	 * 9. exists by genre name
	 */
	public boolean existsByName(String name) {
		return genreRepository.existsByGenreNameIgnoreCase(name);
	}

	/*
	 * 10. Uses deleteAll() method from GenreRepository to delete all genres.
	 */
	public String deleteAll() {
		genreRepository.deleteAll();
		return "All genre records deleted successfully.";
	}

	/*
	 * 11. count genres
	 */
	public long countGenres() {
		return genreRepository.count();
	}
}
