package com.movie.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * Global exception handler for all controllers.
 * Catches unhandled exceptions thrown from any @Controller and
 * forwards to the error view with a user-friendly message.
 */
@ControllerAdvice
public class GlobalExceptionHandler {

	/* handle any RuntimeException (e.g. DB failures from DAO layer) */
	@ExceptionHandler(RuntimeException.class)
	public String handleRuntimeException(RuntimeException e, Model model) {
		model.addAttribute("errorMessage", e.getMessage());
		model.addAttribute("errorType", "Runtime Error");
		return "error.jsp";
	}

	/* handle illegal argument / bad request errors */
	@ExceptionHandler(IllegalArgumentException.class)
	public String handleIllegalArgument(IllegalArgumentException e, Model model) {
		model.addAttribute("errorMessage", e.getMessage());
		model.addAttribute("errorType", "Invalid Input");
		return "error.jsp";
	}

	/* catch-all for any other unexpected exception */
	@ExceptionHandler(Exception.class)
	public String handleGenericException(Exception e, Model model) {
		model.addAttribute("errorMessage", "An unexpected error occurred. Please try again.");
		model.addAttribute("errorType", "Unexpected Error");
		return "error.jsp";
	}

}
