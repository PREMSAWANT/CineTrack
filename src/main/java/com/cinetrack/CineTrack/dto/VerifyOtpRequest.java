package com.cinetrack.CineTrack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class VerifyOtpRequest {

	private String email;
	private String otp;

	public VerifyOtpRequest() {
	}
}
