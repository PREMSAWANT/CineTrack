package com.movie.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.movie.entity.Movie;
import com.movie.service.ActorService;
import com.movie.service.DirectorService;
import com.movie.service.GenreService;
import com.movie.service.MovieService;

@Controller
public class MovieController {

	private static final Logger log = LoggerFactory.getLogger(MovieController.class);

	@Autowired
	private MovieService movieService;

	@Autowired
	private GenreService genreService;

	@Autowired
	private DirectorService directorService;

	@Autowired
	private ActorService actorService;

	/* dashboard mapping --> returns index.jsp with live COUNT queries (no full list fetch) */
	@GetMapping({"/", "/index", "/dashboard"})
	public String dashboard(Model model) {
		model.addAttribute("movieCount", movieService.getMovieCount());
		model.addAttribute("genreCount", genreService.getGenreCount());
		model.addAttribute("directorCount", directorService.getDirectorCount());
		model.addAttribute("actorCount", actorService.getActorCount());
		return "index.jsp";
	}

	/* create method --> return jsp file with genres and directors populated --> addMovie.jsp */
	@GetMapping("/displayMovie")
	public String displayMovie(Model model) {
		model.addAttribute("genres", genreService.getAllGenres());
		model.addAttribute("directors", directorService.getAllDirectors());
		return "addMovie.jsp";
	}

	/* call method --> addMovie with relations --> redirect to list on success */
	@PostMapping("/saveMovie")
	public String saveMovie(Movie movie,
			@RequestParam(name = "genreId", required = false) Integer genreId,
			@RequestParam(name = "directorId", required = false) Integer directorId,
			RedirectAttributes redirectAttributes) {
		movieService.addMovieWithRelations(movie, genreId, directorId);
		log.info("Movie '{}' saved with relations, redirecting to list", movie.getTitle());
		redirectAttributes.addFlashAttribute("successMessage", "Movie added successfully!");
		return "redirect:/viewMovies";
	}

	/* create method --> return jsp file --> all movie list --> displayMovies.jsp */
	@GetMapping("/viewMovies")
	public String viewMovies(Model model) {
		List<Movie> movies = movieService.getAllMovies();
		model.addAttribute("movies", movies);
		model.addAttribute("genres", genreService.getAllGenres());
		return "displayMovies.jsp";
	}

	/* search movies by keyword in title, description, or language */
	@GetMapping("/searchMovies")
	public String searchMovies(@RequestParam(name = "query", required = false, defaultValue = "") String query,
			Model model) {
		List<Movie> movies = movieService.searchMovies(query);
		model.addAttribute("movies", movies);
		model.addAttribute("genres", genreService.getAllGenres());
		model.addAttribute("activeSearch", query);
		return "displayMovies.jsp";
	}

	/* filter movies by genre id */
	@GetMapping("/filterMovies")
	public String filterMovies(@RequestParam("genreId") int genreId, Model model) {
		List<Movie> movies = movieService.getMoviesByGenre(genreId);
		model.addAttribute("movies", movies);
		model.addAttribute("genres", genreService.getAllGenres());
		model.addAttribute("activeGenreId", genreId);
		return "displayMovies.jsp";
	}

	/* create method --> return jsp file --> edit movie details with genres & directors --> editMovie.jsp */
	@GetMapping("/editMovie")
	public String editMovie(@RequestParam("id") int id, Model model) {
		/* throws ResourceNotFoundException if not found -- caught by GlobalExceptionHandler */
		Movie movie = movieService.getMovieById(id);
		model.addAttribute("movie", movie);
		model.addAttribute("genres", genreService.getAllGenres());
		model.addAttribute("directors", directorService.getAllDirectors());
		return "editMovie.jsp";
	}

	/* call method --> updateMovie with relations */
	@PostMapping("/updateMovie")
	public String updateMovie(Movie movie,
			@RequestParam(name = "genreId", required = false) Integer genreId,
			@RequestParam(name = "directorId", required = false) Integer directorId,
			RedirectAttributes redirectAttributes) {
		movieService.updateMovieWithRelations(movie, genreId, directorId);
		redirectAttributes.addFlashAttribute("successMessage", "Movie updated successfully!");
		return "redirect:/viewMovies";
	}

	/* call method --> deleteMovie(int id) */
	@GetMapping("/deleteMovie")
	public String deleteMovie(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
		movieService.deleteMovie(id);
		redirectAttributes.addFlashAttribute("successMessage", "Movie deleted successfully!");
		return "redirect:/viewMovies";
	}

}
