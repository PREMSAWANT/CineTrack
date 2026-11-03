package com.movie.exception;

/**
 * Thrown when a database operation (persist, merge, remove, query) fails.
 * Wraps the original JPA/Hibernate exception with a readable message.
 */
public class DataPersistenceException extends RuntimeException {

	public DataPersistenceException(String message, Throwable cause) {
		super(message, cause);
	}

}
