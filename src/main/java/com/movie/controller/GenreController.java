package com.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	@SuppressWarnings("unused")
	@PostMapping("/saveGenre")
	@ResponseBody
	public String saveGenre(Genre genre) {
		Genre genre2 = genreService.addGenre(genre);
		return "Genre Added Succesfully";
	}

}

