package com.cinetrack.CineTrack.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cinetrack.CineTrack.entity.User;
import com.cinetrack.CineTrack.enums.Role;
import com.cinetrack.CineTrack.repository.UserRepository;

@Repository
public class UserDao {

	@Autowired
	private UserRepository userRepository;

	/* 1. save user --> save(User user) --> from UserRepository */
	public User saveUser(User user) {
		return userRepository.save(user);
	}

	/* 2. find by email --> findByEmail(String email) --> from UserRepository */
	public Optional<User> findByEmail(String email) {
		return userRepository.findByEmail(email);
	}

	/* 3. exists by email --> existsByEmail(String email) --> from UserRepository */
	public boolean existsByEmail(String email) {
		return userRepository.existsByEmail(email);
	}

	/* 4. fetch user by id --> findById(Integer id) */
	public Optional<User> fetchById(Integer id) {
		return userRepository.findById(id);
	}

	/* 5. find by role --> findByRole(Role role) */
	public List<User> findByRole(Role role) {
		return userRepository.findByRole(role);
	}

	/* 6. count by role --> countByRole(Role role) */
	public long countByRole(Role role) {
		return userRepository.countByRole(role);
	}

	/* 7. fetch all users */
	public List<User> fetchAllUsers() {
		return userRepository.findAll();
	}
}
