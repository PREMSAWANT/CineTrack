package com.cinetrack.CineTrack.dto;

import java.util.List;

import com.cinetrack.CineTrack.enums.Certificate;
import com.cinetrack.CineTrack.enums.MovieStatus;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RegisterMovieResponse {

	private String message;
	private Integer movieId;
	private String title;
	private String description;
	private Double duration;
	private String language;
	private Double rating;
	private MovieStatus movieStatus;
	private Certificate certificate;
	private Integer genreId;
	private String genreName;
	private Integer directorId;
	private String directorName;
	private List<Integer> actorIds;
	private List<String> actorNames;

	public RegisterMovieResponse() {
	}
}
