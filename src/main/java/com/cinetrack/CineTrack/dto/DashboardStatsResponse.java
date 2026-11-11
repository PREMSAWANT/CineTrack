package com.cinetrack.CineTrack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class DashboardStatsResponse {

	private long totalMovies;
	private long totalDirectors;
	private long totalActors;
	private long totalGenres;
	private long upcomingMovies;
	private long nowShowingMovies;
	private double averageRating;

	public DashboardStatsResponse() {
	}
}
