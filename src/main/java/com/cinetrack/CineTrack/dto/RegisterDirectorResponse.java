package com.cinetrack.CineTrack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RegisterDirectorResponse {

	private String message;
	private Integer directorId;
	private String directorName;
	private String nationality;

	public RegisterDirectorResponse() {
	}
}
