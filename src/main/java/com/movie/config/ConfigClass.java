package com.movie.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.movie.controller.ActorController;
import com.movie.controller.DirectorController;
import com.movie.controller.GenreController;
import com.movie.controller.MovieController;

@Configuration
@ComponentScan(basePackages = "com.movie", basePackageClasses = {
	MovieController.class,
	ActorController.class,
	DirectorController.class,
	GenreController.class
})
public class ConfigClass {

}
