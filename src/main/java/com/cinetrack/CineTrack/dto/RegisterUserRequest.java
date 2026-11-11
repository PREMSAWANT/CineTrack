package com.cinetrack.CineTrack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RegisterUserRequest {

	private String name;
	private String email;
	private String password;
	private String address;

	public RegisterUserRequest() {
	}
}
