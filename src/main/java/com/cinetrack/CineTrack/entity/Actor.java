package com.cinetrack.CineTrack.entity;

import java.util.List;

import com.cinetrack.CineTrack.enums.Gender;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;

@Entity
@Table(name = "actors")
@Data
@AllArgsConstructor
public class Actor {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "actor_id")
	private Integer actorId;

	@Column(name = "actor_name")
	private String actorName;

	@Column(name = "nationality")
	private String nationality;

	@Column(name = "age")
	private Integer age;

	@Enumerated(EnumType.STRING)
	@Column(name = "gender")
	private Gender gender;

	@ManyToOne
	@JoinColumn(name = "director_id")
	private Director director;

	@ManyToMany
	@JoinTable(
		name = "actor_movie",
		joinColumns = @JoinColumn(name = "actor_id"),
		inverseJoinColumns = @JoinColumn(name = "movie_id")
	)
	private List<Movie> movies;

	public Actor() {
	}
}
