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

import com.movie.entity.Actor;
import com.movie.service.ActorService;
import com.movie.service.DirectorService;

@Controller
public class ActorController {

	private static final Logger log = LoggerFactory.getLogger(ActorController.class);

	@Autowired
	private ActorService actorService;

	@Autowired
	private DirectorService directorService;

	/* create method --> return jsp file with directors populated --> addActor.jsp */
	@GetMapping("/displayActor")
	public String displayActor(Model model) {
		model.addAttribute("directors", directorService.getAllDirectors());
		return "addActor.jsp";
	}

	/* call method --> addActor with director relation --> redirect to list on success */
	@PostMapping("/saveActor")
	public String saveActor(Actor actor,
			@RequestParam(name = "directorId", required = false) Integer directorId,
			RedirectAttributes redirectAttributes) {
		actorService.addActorWithDirector(actor, directorId);
		log.info("Actor '{}' saved via controller, redirecting to list", actor.getActorName());
		redirectAttributes.addFlashAttribute("successMessage", "Actor added successfully!");
		return "redirect:/viewActors";
	}

	/* create method --> return jsp file --> all actor list --> displayActors.jsp */
	@GetMapping("/viewActors")
	public String viewActors(Model model) {
		List<Actor> actors = actorService.getAllActors();
		model.addAttribute("actors", actors);
		return "displayActors.jsp";
	}

	/* search actors by keyword in name or nationality */
	@GetMapping("/searchActors")
	public String searchActors(@RequestParam(name = "query", required = false, defaultValue = "") String query,
			Model model) {
		List<Actor> actors = actorService.searchActors(query);
		model.addAttribute("actors", actors);
		model.addAttribute("activeSearch", query);
		return "displayActors.jsp";
	}

	/* filter actors by nationality */
	@GetMapping("/filterActors")
	public String filterActors(@RequestParam("nationality") String nationality, Model model) {
		List<Actor> actors = actorService.getActorsByNationality(nationality);
		model.addAttribute("actors", actors);
		model.addAttribute("activeNationality", nationality);
		return "displayActors.jsp";
	}

	/* create method --> return jsp file --> edit actor details with directors --> editActor.jsp */
	@GetMapping("/editActor")
	public String editActor(@RequestParam("id") int id, Model model) {
		/* throws ResourceNotFoundException if not found -- caught by GlobalExceptionHandler */
		Actor actor = actorService.getActorById(id);
		model.addAttribute("actor", actor);
		model.addAttribute("directors", directorService.getAllDirectors());
		return "editActor.jsp";
	}

	/* call method --> updateActor with director relation */
	@PostMapping("/updateActor")
	public String updateActor(Actor actor,
			@RequestParam(name = "directorId", required = false) Integer directorId,
			RedirectAttributes redirectAttributes) {
		actorService.updateActorWithDirector(actor, directorId);
		redirectAttributes.addFlashAttribute("successMessage", "Actor updated successfully!");
		return "redirect:/viewActors";
	}

	/* call method --> deleteActor(int id) */
	@GetMapping("/deleteActor")
	public String deleteActor(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
		actorService.deleteActor(id);
		redirectAttributes.addFlashAttribute("successMessage", "Actor deleted successfully!");
		return "redirect:/viewActors";
	}

}
