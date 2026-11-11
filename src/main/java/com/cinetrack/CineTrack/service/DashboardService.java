package com.cinetrack.CineTrack.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinetrack.CineTrack.dao.ActorDao;
import com.cinetrack.CineTrack.dao.DirectorDao;
import com.cinetrack.CineTrack.dao.GenreDao;
import com.cinetrack.CineTrack.dao.MovieDao;
import com.cinetrack.CineTrack.dto.DashboardStatsResponse;
import com.cinetrack.CineTrack.entity.Movie;
import com.cinetrack.CineTrack.enums.MovieStatus;

@Service
public class DashboardService {

	@Autowired
	private MovieDao movieDao;

	@Autowired
	private DirectorDao directorDao;

	@Autowired
	private ActorDao actorDao;

	@Autowired
	private GenreDao genreDao;

	/* 1. Fetch dashboard statistics */
	public DashboardStatsResponse getDashboardStats() {
		long movieCount = movieDao.countMovies();
		long directorCount = directorDao.countDirectors();
		long actorCount = actorDao.countActors();
		long genreCount = genreDao.countGenres();
		long upcomingCount = movieDao.countByMovieStatus(MovieStatus.UPCOMING);
		long nowShowingCount = movieDao.countByMovieStatus(MovieStatus.NOW_SHOWING);

		double avgRating = 0.0;
		List<Movie> allMovies = movieDao.getAllMovies();
		if (!allMovies.isEmpty()) {
			double sum = 0.0;
			int count = 0;
			for (Movie m : allMovies) {
				if (m.getRating() != null) {
					sum += m.getRating();
					count++;
				}
			}
			avgRating = count > 0 ? Math.round((sum / count) * 10.0) / 10.0 : 0.0;
		}

		return new DashboardStatsResponse(
				movieCount,
				directorCount,
				actorCount,
				genreCount,
				upcomingCount,
				nowShowingCount,
				avgRating
		);
	}
}
