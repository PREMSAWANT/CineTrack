package com.movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.movie.entity.Actor;
import com.movie.service.ActorService;

@Controller
public class ActorController {

	@Autowired
	private ActorService actorService;

	/* create method --> return jsp file --> actor details --> addActor.jsp */
	@GetMapping("/displayActor")
	public String displayActor() {
		return "addActor.jsp";
	}

	/* call method --> addActor(Actor actor) */
	@PostMapping("/saveActor")
	@ResponseBody
	public String saveActor(Actor actor) {
		actorService.addActor(actor);
		return "Actor Added Succesfully";
	}

	/* create method --> return jsp file --> all actor list --> displayActors.jsp */
	@GetMapping("/viewActors")
	public String viewActors(Model model) {
		List<Actor> actors = actorService.getAllActors();
		model.addAttribute("actors", actors);
		return "displayActors.jsp";
	}

	/* create method --> return jsp file --> edit actor details --> editActor.jsp */
	@GetMapping("/editActor")
	public String editActor(@RequestParam("id") int id, Model model) {
		Actor actor = actorService.getActorById(id);
		model.addAttribute("actor", actor);
		return "editActor.jsp";
	}

	/* call method --> updateActor(Actor actor) */
	@PostMapping("/updateActor")
	public String updateActor(Actor actor) {
		actorService.updateActor(actor);
		return "redirect:/viewActors";
	}

	/* call method --> deleteActor(int id) */
	@GetMapping("/deleteActor")
	public String deleteActor(@RequestParam("id") int id) {
		actorService.deleteActor(id);
		return "redirect:/viewActors";
	}

}
