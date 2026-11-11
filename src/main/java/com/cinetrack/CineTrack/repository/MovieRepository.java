package com.cinetrack.CineTrack.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cinetrack.CineTrack.entity.Movie;
import com.cinetrack.CineTrack.enums.Certificate;
import com.cinetrack.CineTrack.enums.MovieStatus;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Integer> {

	/* fetch movie by title */
	List<Movie> findByTitleContainingIgnoreCase(String title);

	/* find single movie by exact title */
	Optional<Movie> findByTitleIgnoreCase(String title);

	/* exists by title */
	boolean existsByTitleIgnoreCase(String title);

	/* fetch movie by language */
	List<Movie> findByLanguageIgnoreCase(String language);

	/* fetch movie by rating greater than or equal */
	@Query("SELECT m FROM Movie m WHERE m.rating >= :rating")
	List<Movie> findMovieByRatingGreaterThan(@Param("rating") Double rating);

	/* fetch movie by genre id */
	List<Movie> findByGenre_GenreId(Integer genreId);

	/* fetch movie by director id */
	List<Movie> findByDirector_DirectorId(Integer directorId);

	/* fetch movie by status */
	List<Movie> findByMovieStatus(MovieStatus movieStatus);

	/* fetch movie by certificate */
	List<Movie> findByCertificate(Certificate certificate);

	/* fetch family friendly movies (U, UA, PG_13) */
	@Query("SELECT m FROM Movie m WHERE m.certificate = com.cinetrack.CineTrack.enums.Certificate.U OR m.certificate = com.cinetrack.CineTrack.enums.Certificate.UA OR m.certificate = com.cinetrack.CineTrack.enums.Certificate.PG_13")
	List<Movie> findFamilyFriendlyMovies();

	/* count by movie status */
	long countByMovieStatus(MovieStatus movieStatus);

}
