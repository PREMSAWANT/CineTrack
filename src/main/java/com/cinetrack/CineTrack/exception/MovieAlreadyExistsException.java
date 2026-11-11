package com.cinetrack.CineTrack.exception;

public class MovieAlreadyExistsException extends RuntimeException {

	public MovieAlreadyExistsException(String message) {
		super(message);
	}
}

