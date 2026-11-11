package com.cinetrack.CineTrack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RegisterDirectorRequest {

	private String directorName;
	private String nationality;

	public RegisterDirectorRequest() {
	}
}
