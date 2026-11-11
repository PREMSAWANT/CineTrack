package com.cinetrack.CineTrack.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.cinetrack.CineTrack.dto.RegisterUserRequest;
import com.cinetrack.CineTrack.dto.RegisterUserResponse;
import com.cinetrack.CineTrack.dto.ResendOtpRequest;
import com.cinetrack.CineTrack.dto.ResendOtpResponse;
import com.cinetrack.CineTrack.dto.VerifyOtpRequest;
import com.cinetrack.CineTrack.dto.VerifyOtpResponse;
import com.cinetrack.CineTrack.enums.Role;
import com.cinetrack.CineTrack.service.AuthService;

@RestController
public class AuthController {

	@Autowired
	private AuthService authService;

	/* 1. call method --> registerUser(RegisterUserRequest request) */
	@PostMapping("/api/auth/register")
	public ResponseEntity<RegisterUserResponse> saveUser(@RequestBody RegisterUserRequest registerUserRequest) {
		RegisterUserResponse registerUser = authService.registerUser(registerUserRequest);
		return ResponseEntity.status(HttpStatus.CREATED).body(registerUser);
	}

	/* 2. call method --> verifyEmail(VerifyOtpRequest verifyOtpRequest) */
	@PostMapping("/api/auth/verifyEmail")
	public ResponseEntity<VerifyOtpResponse> verify(@RequestBody VerifyOtpRequest verifyOtpRequest) {
		VerifyOtpResponse verifyEmail = authService.verifyEmail(verifyOtpRequest);
		return ResponseEntity.status(HttpStatus.ACCEPTED).body(verifyEmail);
	}

	/* 3. call method --> resendOtp(ResendOtpRequest resendOtpRequest) */
	@PostMapping("/api/auth/resendOtp")
	public ResponseEntity<ResendOtpResponse> resendOtp(@RequestBody ResendOtpRequest resendOtpRequest) {
		ResendOtpResponse resendOtp = authService.resendOtp(resendOtpRequest);
		return ResponseEntity.status(HttpStatus.OK).body(resendOtp);
	}

	/* 4. call method --> fetchByRole(Role role) */
	@GetMapping("/api/auth/byRole/{role}")
	public ResponseEntity<List<RegisterUserResponse>> fetchByRole(@PathVariable Role role) {
		List<RegisterUserResponse> responses = authService.fetchByRole(role);
		return ResponseEntity.status(HttpStatus.OK).body(responses);
	}

	/* 5. call method --> changeUserRole(Integer userId, Role role) */
	@PutMapping("/api/auth/changeRole/{userId}/{role}")
	public ResponseEntity<RegisterUserResponse> changeUserRole(@PathVariable Integer userId, @PathVariable Role role) {
		RegisterUserResponse response = authService.changeUserRole(userId, role);
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}
}
