package com.cinetrack.CineTrack.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cinetrack.CineTrack.entity.Genre;

@Repository
public interface GenreRepository extends JpaRepository<Genre, Integer> {

	/* fetch genre by genre name */
	Optional<Genre> findByGenreNameIgnoreCase(String genreName);

	/* exists by genre name */
	boolean existsByGenreNameIgnoreCase(String genreName);

}
