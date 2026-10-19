package com.movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.movie.entity.Genre;
import com.movie.service.GenreService;

@Controller
public class GenreController {

	@Autowired
	private GenreService genreService;

	/* create method --> return jsp file --> genre details --> addGenre.jsp */
	@GetMapping({"/displayGenre", "/displayGenree"})
	public String displayGenre() {
		return "addGenre.jsp";
	}

	/* call method --> addGenre(Genre genre) */
	@PostMapping("/saveGenre")
	@ResponseBody
	public String saveGenre(Genre genre) {
		Genre genre2 = genreService.addGenre(genre);
		return "Genre Added Succesfully";
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
		Genre genre = genreService.getGenreById(id);
		model.addAttribute("genre", genre);
		return "editGenre.jsp";
	}

	/* call method --> updateGenre(Genre genre) */
	@PostMapping("/updateGenre")
	public String updateGenre(Genre genre) {
		genreService.updateGenre(genre);
		return "redirect:/viewGenres";
	}

	/* call method --> deleteGenre(int id) */
	@GetMapping("/deleteGenre")
	public String deleteGenre(@RequestParam("id") int id) {
		genreService.deleteGenre(id);
		return "redirect:/viewGenres";
	}

}
