package com.cinetrack.CineTrack.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.cinetrack.CineTrack.dao.MovieDao;
import com.cinetrack.CineTrack.dto.RegisterActorRequest;
import com.cinetrack.CineTrack.dto.RegisterActorResponse;
import com.cinetrack.CineTrack.dto.RegisterDirectorRequest;
import com.cinetrack.CineTrack.dto.RegisterDirectorResponse;
import com.cinetrack.CineTrack.dto.RegisterGenreRequest;
import com.cinetrack.CineTrack.dto.RegisterGenreResponse;
import com.cinetrack.CineTrack.dto.RegisterMovieRequest;
import com.cinetrack.CineTrack.enums.Certificate;
import com.cinetrack.CineTrack.enums.Gender;
import com.cinetrack.CineTrack.enums.MovieStatus;
import com.cinetrack.CineTrack.service.ActorService;
import com.cinetrack.CineTrack.service.DirectorService;
import com.cinetrack.CineTrack.service.GenreService;
import com.cinetrack.CineTrack.service.MovieService;

@Component
public class DataInitializer implements CommandLineRunner {

	@Autowired
	private GenreService genreService;

	@Autowired
	private DirectorService directorService;

	@Autowired
	private ActorService actorService;

	@Autowired
	private MovieService movieService;

	@Autowired
	private MovieDao movieDao;

	@Override
	public void run(String... args) throws Exception {
		if (movieDao.countMovies() > 0) {
			System.out.println("CineTrack database already contains data. Skipping initial seeding.");
			return;
		}

		System.out.println("Initializing sample CineTrack data...");

		// 1. Seed Genres
		RegisterGenreResponse gSciFi = genreService.addGenre(new RegisterGenreRequest("Sci-Fi", "Science fiction movies exploring futuristic concepts"));
		RegisterGenreResponse gAction = genreService.addGenre(new RegisterGenreRequest("Action", "High octane action, thrilling sequences, and stunts"));
		RegisterGenreResponse gDrama = genreService.addGenre(new RegisterGenreRequest("Drama", "Narrative fiction intended to be more serious in tone"));

		// 2. Seed Directors
		RegisterDirectorResponse dNolan = directorService.addDirector(new RegisterDirectorRequest("Christopher Nolan", "British-American"));
		RegisterDirectorResponse dVilleneuve = directorService.addDirector(new RegisterDirectorRequest("Denis Villeneuve", "Canadian"));

		// 3. Seed Actors with Gender
		RegisterActorResponse aLeo = actorService.addActor(new RegisterActorRequest("Leonardo DiCaprio", "American", 49, Gender.MALE, dNolan.getDirectorId()));
		RegisterActorResponse aCillian = actorService.addActor(new RegisterActorRequest("Cillian Murphy", "Irish", 48, Gender.MALE, dNolan.getDirectorId()));
		RegisterActorResponse aTimothee = actorService.addActor(new RegisterActorRequest("Timothee Chalamet", "American-French", 28, Gender.MALE, dVilleneuve.getDirectorId()));
		RegisterActorResponse aZendaya = actorService.addActor(new RegisterActorRequest("Zendaya", "American", 28, Gender.FEMALE, dVilleneuve.getDirectorId()));

		// 4. Seed Movies with MovieStatus and Certificate
		List<Integer> inceptionActors = new ArrayList<>();
		inceptionActors.add(aLeo.getActorId());
		inceptionActors.add(aCillian.getActorId());

		movieService.addMovie(new RegisterMovieRequest(
				"Inception",
				"A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
				148.0,
				"English",
				8.8,
				MovieStatus.RELEASED,
				Certificate.UA,
				gSciFi.getGenreId(),
				dNolan.getDirectorId(),
				inceptionActors
		));

		List<Integer> oppenheimerActors = new ArrayList<>();
		oppenheimerActors.add(aCillian.getActorId());

		movieService.addMovie(new RegisterMovieRequest(
				"Oppenheimer",
				"The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb during World War II.",
				180.0,
				"English",
				8.9,
				MovieStatus.RELEASED,
				Certificate.A,
				gDrama.getGenreId(),
				dNolan.getDirectorId(),
				oppenheimerActors
		));

		List<Integer> duneActors = new ArrayList<>();
		duneActors.add(aTimothee.getActorId());
		duneActors.add(aZendaya.getActorId());

		movieService.addMovie(new RegisterMovieRequest(
				"Dune: Part Two",
				"Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.",
				166.0,
				"English",
				8.6,
				MovieStatus.NOW_SHOWING,
				Certificate.UA,
				gSciFi.getGenreId(),
				dVilleneuve.getDirectorId(),
				duneActors
		));

		System.out.println("CineTrack sample data initialized successfully!");
	}
}
