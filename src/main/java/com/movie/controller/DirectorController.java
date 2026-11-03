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

import com.movie.entity.Director;
import com.movie.service.DirectorService;

@Controller
public class DirectorController {

	private static final Logger log = LoggerFactory.getLogger(DirectorController.class);

	@Autowired
	private DirectorService directorService;

	/* create method --> return jsp file --> director details --> addDirector.jsp */
	@GetMapping("/displayDirector")
	public String displayDirector() {
		return "addDirector.jsp";
	}

	/* call method --> addDirector(Director director) --> redirect to list on success */
	@PostMapping("/saveDirector")
	public String saveDirector(Director director, RedirectAttributes redirectAttributes) {
		directorService.addDirector(director);
		log.info("Director '{}' saved via controller, redirecting to list", director.getDirectorName());
		redirectAttributes.addFlashAttribute("successMessage", "Director added successfully!");
		return "redirect:/viewDirectors";
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
		/* throws ResourceNotFoundException if not found -- caught by GlobalExceptionHandler */
		Director director = directorService.getDirectorById(id);
		model.addAttribute("director", director);
		return "editDirector.jsp";
	}

	/* call method --> updateDirector(Director director) */
	@PostMapping("/updateDirector")
	public String updateDirector(Director director, RedirectAttributes redirectAttributes) {
		directorService.updateDirector(director);
		redirectAttributes.addFlashAttribute("successMessage", "Director updated successfully!");
		return "redirect:/viewDirectors";
	}

	/* call method --> deleteDirector(int id) */
	@GetMapping("/deleteDirector")
	public String deleteDirector(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
		directorService.deleteDirector(id);
		redirectAttributes.addFlashAttribute("successMessage", "Director deleted successfully!");
		return "redirect:/viewDirectors";
	}

}
