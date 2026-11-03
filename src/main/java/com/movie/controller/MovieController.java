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

	/* create method --> return jsp file --> movie details --> addMovie.jsp */
	@GetMapping("/displayMovie")
	public String displayMovie() {
		return "addMovie.jsp";
	}

	/* call method --> addMovie(Movie movie) --> redirect to list on success */
	@PostMapping("/saveMovie")
	public String saveMovie(Movie movie, RedirectAttributes redirectAttributes) {
		movieService.addMovie(movie);
		log.info("Movie '{}' saved via controller, redirecting to list", movie.getTitle());
		redirectAttributes.addFlashAttribute("successMessage", "Movie added successfully!");
		return "redirect:/viewMovies";
	}

	/* create method --> return jsp file --> all movie list --> displayMovies.jsp */
	@GetMapping("/viewMovies")
	public String viewMovies(Model model) {
		List<Movie> movies = movieService.getAllMovies();
		model.addAttribute("movies", movies);
		return "displayMovies.jsp";
	}

	/* create method --> return jsp file --> edit movie details --> editMovie.jsp */
	@GetMapping("/editMovie")
	public String editMovie(@RequestParam("id") int id, Model model) {
		/* throws ResourceNotFoundException if not found -- caught by GlobalExceptionHandler */
		Movie movie = movieService.getMovieById(id);
		model.addAttribute("movie", movie);
		return "editMovie.jsp";
	}

	/* call method --> updateMovie(Movie movie) */
	@PostMapping("/updateMovie")
	public String updateMovie(Movie movie, RedirectAttributes redirectAttributes) {
		movieService.updateMovie(movie);
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
