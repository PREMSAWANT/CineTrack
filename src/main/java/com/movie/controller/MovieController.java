package com.movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.movie.entity.Movie;
import com.movie.service.ActorService;
import com.movie.service.DirectorService;
import com.movie.service.GenreService;
import com.movie.service.MovieService;

@Controller
public class MovieController {

	@Autowired
	private MovieService movieService;

	@Autowired
	private GenreService genreService;

	@Autowired
	private DirectorService directorService;

	@Autowired
	private ActorService actorService;

	/* dashboard mapping --> returns index.jsp with true counts */
	@GetMapping({"/", "/index", "/dashboard"})
	public String dashboard(Model model) {
		model.addAttribute("movieCount", movieService.getAllMovies().size());
		model.addAttribute("genreCount", genreService.getAllGenres().size());
		model.addAttribute("directorCount", directorService.getAllDirectors().size());
		model.addAttribute("actorCount", actorService.getAllActors().size());
		return "index.jsp";
	}

	/* create method --> return jsp file --> movie details --> addMovie.jsp */
	@GetMapping("/displayMovie")
	public String displayMovie() {
		return "addMovie.jsp";
	}

	/* call method --> addMovie(Movie movie) */
	@PostMapping("/saveMovie")
	@ResponseBody
	public String saveMovie(Movie movie) {
		movieService.addMovie(movie);
		return "Movie Added Succesfully";
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
		Movie movie = movieService.getMovieById(id);
		model.addAttribute("movie", movie);
		return "editMovie.jsp";
	}

	/* call method --> updateMovie(Movie movie) */
	@PostMapping("/updateMovie")
	public String updateMovie(Movie movie) {
		movieService.updateMovie(movie);
		return "redirect:/viewMovies";
	}

	/* call method --> deleteMovie(int id) */
	@GetMapping("/deleteMovie")
	public String deleteMovie(@RequestParam("id") int id) {
		movieService.deleteMovie(id);
		return "redirect:/viewMovies";
	}

}
