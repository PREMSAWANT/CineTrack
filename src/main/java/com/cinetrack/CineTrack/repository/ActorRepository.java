package com.cinetrack.CineTrack.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cinetrack.CineTrack.entity.Actor;
import com.cinetrack.CineTrack.enums.Gender;

@Repository
public interface ActorRepository extends JpaRepository<Actor, Integer> {

	/* fetch actors by actor name */
	List<Actor> findByActorNameContainingIgnoreCase(String actorName);

	/* fetch actors by director id */
	List<Actor> findByDirector_DirectorId(Integer directorId);

	/* fetch all actors age > age */
	@Query("SELECT a FROM Actor a WHERE a.age > :age")
	List<Actor> findActorGreaterThanAge(@Param("age") int age);

	/* check if actor exists by name */
	boolean existsByActorNameIgnoreCase(String actorName);

	/* fetch actors by gender */
	List<Actor> findByGender(Gender gender);

	/* count actors by gender */
	long countByGender(Gender gender);

}
