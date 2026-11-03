package com.movie.exception;

/**
 * Thrown when a requested entity cannot be found in the database.
 * Maps to a 404-style user-facing error.
 */
public class ResourceNotFoundException extends RuntimeException {

	private final String resourceName;
	private final int resourceId;

	public ResourceNotFoundException(String resourceName, int resourceId) {
		super(resourceName + " not found with id: " + resourceId);
		this.resourceName = resourceName;
		this.resourceId = resourceId;
	}

	public String getResourceName() {
		return resourceName;
	}

	public int getResourceId() {
		return resourceId;
	}

}
