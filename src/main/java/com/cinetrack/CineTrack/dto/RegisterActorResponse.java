package com.cinetrack.CineTrack.dto;

import com.cinetrack.CineTrack.enums.Gender;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RegisterActorResponse {

	private String message;
	private Integer actorId;
	private String actorName;
	private String nationality;
	private Integer age;
	private Gender gender;
	private Integer directorId;
	private String directorName;

	public RegisterActorResponse() {
	}
}
