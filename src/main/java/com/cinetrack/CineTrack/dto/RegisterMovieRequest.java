package com.cinetrack.CineTrack.dto;

import java.util.List;

import com.cinetrack.CineTrack.enums.Certificate;
import com.cinetrack.CineTrack.enums.MovieStatus;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RegisterMovieRequest {

	private String title;
	private String description;
	private Double duration;
	private String language;
	private Double rating;
	private MovieStatus movieStatus;
	private Certificate certificate;
	private Integer genreId;
	private Integer directorId;
	private List<Integer> actorIds;

	public RegisterMovieRequest() {
	}
}
