package com.cinetrack.CineTrack.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cinetrack.CineTrack.dto.DashboardStatsResponse;
import com.cinetrack.CineTrack.service.DashboardService;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardController {

	@Autowired
	private DashboardService dashboardService;

	/* 1. Fetch dashboard stats */
	@GetMapping("/stats")
	public ResponseEntity<DashboardStatsResponse> getStats() {
		DashboardStatsResponse stats = dashboardService.getDashboardStats();
		return ResponseEntity.status(HttpStatus.OK).body(stats);
	}
}
