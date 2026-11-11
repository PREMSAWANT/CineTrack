package com.cinetrack.CineTrack.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinetrack.CineTrack.dao.UserDao;
import com.cinetrack.CineTrack.dto.RegisterUserRequest;
import com.cinetrack.CineTrack.dto.RegisterUserResponse;
import com.cinetrack.CineTrack.dto.ResendOtpRequest;
import com.cinetrack.CineTrack.dto.ResendOtpResponse;
import com.cinetrack.CineTrack.dto.VerifyOtpRequest;
import com.cinetrack.CineTrack.dto.VerifyOtpResponse;
import com.cinetrack.CineTrack.emailConfig.EmailService;
import com.cinetrack.CineTrack.entity.User;
import com.cinetrack.CineTrack.enums.Role;
import com.cinetrack.CineTrack.exception.InvalidInputException;
import com.cinetrack.CineTrack.exception.InvalidOtpException;
import com.cinetrack.CineTrack.exception.OtpExpiredException;
import com.cinetrack.CineTrack.exception.UserAlreadyExistsException;
import com.cinetrack.CineTrack.exception.UserNotFoundException;

@Service
public class AuthService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private EmailService emailService;

	/* 1. Register User */
	public RegisterUserResponse registerUser(RegisterUserRequest registerUserRequest) {

		if (registerUserRequest.getEmail() == null || registerUserRequest.getEmail().trim().isEmpty() || registerUserRequest.getEmail().equalsIgnoreCase("string")) {
			throw new InvalidInputException("Email cannot be empty or default string.");
		}

		/* 1. Check if user already exists in DB */
		if (userDao.existsByEmail(registerUserRequest.getEmail())) {
			throw new UserAlreadyExistsException("User already exists with email: " + registerUserRequest.getEmail());
		}

		/* 2. Generate a 6-digit OTP */
		String otp = emailService.generateOtp();

		/* 3. Create user entity and populate details */
		User user = new User();
		user.setName(registerUserRequest.getName());
		user.setEmail(registerUserRequest.getEmail());
		user.setPassword(registerUserRequest.getPassword());
		user.setAddress(registerUserRequest.getAddress());

		/* 4. Set OTP */
		user.setOtp(otp);

		/* 5. Set default role */
		user.setRole(Role.USER);

		/* 6. Set OTP expiration time (5 minutes from now) */
		user.setOtpExpirationTime(LocalDateTime.now().plusMinutes(5));

		/* 7. Set email verification status to false */
		user.setEmailVerified(false);

		/* 8. Save user to DB */
		userDao.saveUser(user);

		/* 9. Send verification email with OTP */
		emailService.sendEmail(user.getEmail(), otp);

		/* 10. Return response */
		return new RegisterUserResponse("User registered successfully. An OTP has been sent to your email.",
				user.getEmail(), false);
	}

	/* 2. Verify Email */
	public VerifyOtpResponse verifyEmail(VerifyOtpRequest verifyOtpRequest) {
		User user = userDao.findByEmail(verifyOtpRequest.getEmail())
				.orElseThrow(() -> new UserNotFoundException("User Not Found with Email : " + verifyOtpRequest.getEmail()));

		if (user.getOtpExpirationTime() == null || user.getOtpExpirationTime().isBefore(LocalDateTime.now())) {
			throw new OtpExpiredException("OTP has expired. Please request a new OTP.");
		}

		if (user.getOtp() == null || !user.getOtp().equals(verifyOtpRequest.getOtp().trim())) {
			throw new InvalidOtpException("Invalid OTP entered. Please try again.");
		}

		user.setEmailVerified(true);
		user.setOtp(null);
		userDao.saveUser(user);

		return new VerifyOtpResponse("Email verified successfully! You can now log in.", user.getEmail(), true);
	}

	/* 3. Resend OTP */
	public ResendOtpResponse resendOtp(ResendOtpRequest resendOtpRequest) {
		User user = userDao.findByEmail(resendOtpRequest.getEmail())
				.orElseThrow(() -> new UserNotFoundException("User Not Found with Email : " + resendOtpRequest.getEmail()));

		String newOtp = emailService.generateOtp();
		user.setOtp(newOtp);
		user.setOtpExpirationTime(LocalDateTime.now().plusMinutes(5));
		userDao.saveUser(user);

		emailService.sendEmail(user.getEmail(), newOtp);

		return new ResendOtpResponse("A new OTP has been sent to: " + user.getEmail());
	}

	/* 4. Fetch Users by Role */
	public List<RegisterUserResponse> fetchByRole(Role role) {
		List<User> users = userDao.findByRole(role);
		List<RegisterUserResponse> responses = new ArrayList<>();
		for (User u : users) {
			responses.add(new RegisterUserResponse("User fetched successfully with role: " + role, u.getEmail(), u.isEmailVerified()));
		}
		return responses;
	}

	/* 5. Change User Role */
	public RegisterUserResponse changeUserRole(Integer userId, Role role) {
		Optional<User> optional = userDao.fetchById(userId);
		if (!optional.isPresent()) {
			throw new UserNotFoundException("User Not Found with User ID : " + userId);
		}
		User user = optional.get();
		user.setRole(role);
		userDao.saveUser(user);
		return new RegisterUserResponse("User role updated successfully to: " + role, user.getEmail(), user.isEmailVerified());
	}
}
