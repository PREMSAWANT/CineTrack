# CineTrack - Movie Management System

CineTrack is a cinema management web application built using Spring Boot, Spring Data JPA, and PostgreSQL with a REST API backend and responsive web portal.

## Technology Stack

- **Language:** Java 17
- **Framework:** Spring Boot 3.x (Spring Web, Spring Data JPA)
- **Persistence:** Hibernate / Jakarta Persistence
- **Database:** PostgreSQL
- **Security & Auth:** Email OTP Verification (JavaMailSender)
- **Frontend:** HTML5, CSS3, JavaScript
- **Build Tool:** Maven

## Key Features

- End-to-end management for Movies, Actors, Directors, and Genres
- Clean layered architecture (Controller -> Service -> DAO -> Repository -> Entity)
- Strict DTO request and response isolation
- User authentication with 6-digit email OTP lifecycle
- Interactive cinema management dashboard

## Running the Application

1. Configure your PostgreSQL credentials in `src/main/resources/application.properties`.
2. Run with Maven:
   ```bash
   mvn spring-boot:run
   ```
3. Open `http://localhost:8082` in your browser.
