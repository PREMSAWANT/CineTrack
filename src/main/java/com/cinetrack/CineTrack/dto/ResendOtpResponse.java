package com.cinetrack.CineTrack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ResendOtpResponse {

	private String message;

	public ResendOtpResponse() {
	}
}
