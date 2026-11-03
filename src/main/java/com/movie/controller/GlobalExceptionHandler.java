package com.movie.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.movie.exception.DataPersistenceException;
import com.movie.exception.ResourceNotFoundException;

/**
 * Global exception handler for all controllers.
 * Catches exceptions thrown from any @Controller and forwards to the
 * styled error view with a contextual message.
 *
 * Priority order:
 *   ResourceNotFoundException  --> "Not Found"   (entity lookup by id failed)
 *   DataPersistenceException   --> "Database Error" (DAO-level JPA/Hibernate failure)
 *   RuntimeException           --> "Runtime Error"  (other unchecked errors)
 *   Exception                  --> "Unexpected Error" (catch-all fallback)
 */
@ControllerAdvice
public class GlobalExceptionHandler {

	private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

	/* handle ResourceNotFoundException -- entity not found by id */
	@ExceptionHandler(ResourceNotFoundException.class)
	public String handleResourceNotFound(ResourceNotFoundException e, Model model) {
		log.warn("Resource not found: {}", e.getMessage());
		model.addAttribute("errorType", "Not Found");
		model.addAttribute("errorMessage", e.getMessage());
		return "WEB-INF/views/error.jsp";
	}

	/* handle DataPersistenceException -- DAO/database operation failure */
	@ExceptionHandler(DataPersistenceException.class)
	public String handleDataPersistence(DataPersistenceException e, Model model) {
		log.error("Database operation failed: {}", e.getMessage(), e);
		model.addAttribute("errorType", "Database Error");
		model.addAttribute("errorMessage", "A database error occurred. Please try again or contact support.");
		return "WEB-INF/views/error.jsp";
	}

	/* handle any other RuntimeException */
	@ExceptionHandler(RuntimeException.class)
	public String handleRuntimeException(RuntimeException e, Model model) {
		log.error("Unhandled runtime exception: {}", e.getMessage(), e);
		model.addAttribute("errorType", "Runtime Error");
		model.addAttribute("errorMessage", e.getMessage());
		return "WEB-INF/views/error.jsp";
	}

	/* catch-all for any other unexpected exception */
	@ExceptionHandler(Exception.class)
	public String handleGenericException(Exception e, Model model) {
		log.error("Unexpected exception: {}", e.getMessage(), e);
		model.addAttribute("errorType", "Unexpected Error");
		model.addAttribute("errorMessage", "An unexpected error occurred. Please try again or contact support.");
		return "WEB-INF/views/error.jsp";
	}

}
