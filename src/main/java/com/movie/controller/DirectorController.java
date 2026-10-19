package com.movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.movie.entity.Director;
import com.movie.service.DirectorService;

@Controller
public class DirectorController {

	@Autowired
	private DirectorService directorService;

	/* create method --> return jsp file --> director details --> addDirector.jsp */
	@GetMapping("/displayDirector")
	public String displayDirector() {
		return "addDirector.jsp";
	}

	/* call method --> addDirector(Director director) */
	@PostMapping("/saveDirector")
	@ResponseBody
	public String saveDirector(Director director) {
		directorService.addDirector(director);
		return "Director Added Succesfully";
	}

	/* create method --> return jsp file --> all director list --> displayDirectors.jsp */
	@GetMapping("/viewDirectors")
	public String viewDirectors(Model model) {
		List<Director> directors = directorService.getAllDirectors();
		model.addAttribute("directors", directors);
		return "displayDirectors.jsp";
	}

	/* create method --> return jsp file --> edit director details --> editDirector.jsp */
	@GetMapping("/editDirector")
	public String editDirector(@RequestParam("id") int id, Model model) {
		Director director = directorService.getDirectorById(id);
		model.addAttribute("director", director);
		return "editDirector.jsp";
	}

	/* call method --> updateDirector(Director director) */
	@PostMapping("/updateDirector")
	public String updateDirector(Director director) {
		directorService.updateDirector(director);
		return "redirect:/viewDirectors";
	}

	/* call method --> deleteDirector(int id) */
	@GetMapping("/deleteDirector")
	public String deleteDirector(@RequestParam("id") int id) {
		directorService.deleteDirector(id);
		return "redirect:/viewDirectors";
	}

}
