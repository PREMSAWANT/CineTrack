package com.cinetrack.CineTrack.entity;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;

@Entity
@Table(name = "genres")
@Data
@AllArgsConstructor
public class Genre {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "genre_id")
	private Integer genreId;

	@Column(name = "genre_name")
	private String genreName;

	@Column(name = "genre_description")
	private String genreDescription;

	@OneToMany(mappedBy = "genre", cascade = CascadeType.ALL)
	private List<Movie> movies;

	public Genre() {
	}
}
