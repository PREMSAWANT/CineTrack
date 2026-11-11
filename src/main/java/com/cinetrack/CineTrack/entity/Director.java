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
@Table(name = "directors")
@Data
@AllArgsConstructor
public class Director {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "director_id")
	private Integer directorId;

	@Column(name = "director_name")
	private String directorName;

	@Column(name = "nationality")
	private String nationality;

	@OneToMany(mappedBy = "director", cascade = CascadeType.ALL)
	private List<Movie> movies;

	@OneToMany(mappedBy = "director", cascade = CascadeType.ALL)
	private List<Actor> actors;

	public Director() {
	}
}
