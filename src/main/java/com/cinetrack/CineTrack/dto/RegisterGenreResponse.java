package com.cinetrack.CineTrack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RegisterGenreResponse {

	private String message;
	private Integer genreId;
	private String genreName;
	private String genreDescription;

	public RegisterGenreResponse() {
	}
}
