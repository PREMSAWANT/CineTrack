package com.cinetrack.CineTrack.dto;

import lombok.Data;

@Data
public class ResponseStructure<T> {

	private String messageString;
	private int statusCode;
	private T data;
}
