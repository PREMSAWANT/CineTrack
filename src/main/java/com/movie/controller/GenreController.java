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

import com.movie.entity.Genre;
import com.movie.service.GenreService;

@Controller
public class GenreController {

	private static final Logger log = LoggerFactory.getLogger(GenreController.class);

	@Autowired
	private GenreService genreService;

	/* create method --> return jsp file --> genre details --> addGenre.jsp */
	@GetMapping({"/displayGenre", "/displayGenree"})
	public String displayGenre() {
		return "addGenre.jsp";
	}

	/* call method --> addGenre(Genre genre) --> redirect to list on success */
	@PostMapping("/saveGenre")
	public String saveGenre(Genre genre, RedirectAttributes redirectAttributes) {
		genreService.addGenre(genre);
		log.info("Genre '{}' saved via controller, redirecting to list", genre.getGenreName());
		redirectAttributes.addFlashAttribute("successMessage", "Genre added successfully!");
		return "redirect:/viewGenres";
	}

	/* create method --> return jsp file --> all genre list --> displayGenres.jsp */
	@GetMapping("/viewGenres")
	public String viewGenres(Model model) {
		List<Genre> genres = genreService.getAllGenres();
		model.addAttribute("genres", genres);
		return "displayGenres.jsp";
	}

	/* create method --> return jsp file --> edit genre details --> editGenre.jsp */
	@GetMapping("/editGenre")
	public String editGenre(@RequestParam("id") int id, Model model) {
		/* throws ResourceNotFoundException if not found -- caught by GlobalExceptionHandler */
		Genre genre = genreService.getGenreById(id);
		model.addAttribute("genre", genre);
		return "editGenre.jsp";
	}

	/* call method --> updateGenre(Genre genre) */
	@PostMapping("/updateGenre")
	public String updateGenre(Genre genre, RedirectAttributes redirectAttributes) {
		genreService.updateGenre(genre);
		redirectAttributes.addFlashAttribute("successMessage", "Genre updated successfully!");
		return "redirect:/viewGenres";
	}

	/* call method --> deleteGenre(int id) */
	@GetMapping("/deleteGenre")
	public String deleteGenre(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
		genreService.deleteGenre(id);
		redirectAttributes.addFlashAttribute("successMessage", "Genre deleted successfully!");
		return "redirect:/viewGenres";
	}

}
