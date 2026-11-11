package com.cinetrack.CineTrack.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cinetrack.CineTrack.entity.Director;

@Repository
public interface DirectorRepository extends JpaRepository<Director, Integer> {

	/* fetch director by name */
	List<Director> findByDirectorNameContainingIgnoreCase(String directorName);

	/* fetch director by nationality */
	List<Director> findByNationalityIgnoreCase(String nationality);

	/* check if director exists by name */
	boolean existsByDirectorNameIgnoreCase(String directorName);

}
