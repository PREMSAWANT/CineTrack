package com.cinetrack.CineTrack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RegisterGenreRequest {

	private String genreName;
	private String genreDescription;

	public RegisterGenreRequest() {
	}
}
