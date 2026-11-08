<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.movie.entity.Movie, com.movie.entity.Genre" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineTrack - All Movies</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --wine-darkest: #2E050B;
            --wine-dark: #4A0E17;
            --wine-primary: #722F37;
            --wine-vibrant: #8F263E;
            --wine-soft: #F9F1F3;
            --wine-tint: #F3E4E7;
            --wine-border: #E8CCD2;
            --bg-canvas: #FAF6F7;
            --bg-card: #FFFFFF;
            --text-main: #24090E;
            --text-muted: #6B4950;
            --text-light: #9B7B82;
            --font-heading: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
            --radius-sm: 8px;
            --radius-md: 14px;
            --radius-lg: 20px;
            --shadow-card: 0 10px 30px rgba(74, 14, 23, 0.08);
            --transition: all 0.25s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-body);
            background-color: var(--bg-canvas);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: #FFFFFF;
            border-bottom: 1px solid var(--wine-border);
            padding: 1rem 1.5rem;
            box-shadow: 0 2px 10px rgba(74, 14, 23, 0.04);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
        }

        .brand-icon {
            width: 38px;
            height: 38px;
            background: linear-gradient(135deg, var(--wine-primary), var(--wine-vibrant));
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
        }

        .brand-text {
            font-family: var(--font-heading);
            font-weight: 700;
            font-size: 1.35rem;
            color: var(--wine-dark);
            letter-spacing: -0.5px;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .btn {
            padding: 0.6rem 1.25rem;
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
        }

        .btn-outline {
            background-color: transparent;
            color: var(--wine-dark);
            border: 1px solid var(--wine-border);
        }

        .btn-outline:hover {
            background-color: var(--wine-tint);
            border-color: var(--wine-primary);
        }

        .btn-wine {
            background: linear-gradient(135deg, var(--wine-primary), var(--wine-vibrant));
            color: white;
            box-shadow: 0 4px 12px rgba(114, 47, 55, 0.2);
        }

        .btn-wine:hover {
            opacity: 0.95;
            box-shadow: 0 6px 16px rgba(114, 47, 55, 0.3);
            transform: translateY(-1px);
        }

        .main-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1.5rem;
            width: 100%;
            flex: 1;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            font-family: var(--font-heading);
            font-size: 1.85rem;
            font-weight: 700;
            color: var(--wine-dark);
        }

        .page-subtitle {
            font-size: 0.95rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }

        .filter-toolbar {
            background-color: #FFFFFF;
            border: 1px solid var(--wine-border);
            border-radius: var(--radius-md);
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
            box-shadow: 0 4px 15px rgba(74, 14, 23, 0.03);
        }

        .search-group {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex: 1;
            min-width: 260px;
        }

        .search-input {
            flex: 1;
            padding: 0.55rem 0.9rem;
            border: 1px solid var(--wine-border);
            border-radius: var(--radius-sm);
            font-family: var(--font-body);
            font-size: 0.9rem;
            color: var(--text-main);
            outline: none;
            transition: var(--transition);
        }

        .search-input:focus {
            border-color: var(--wine-primary);
            box-shadow: 0 0 0 3px rgba(114, 47, 55, 0.12);
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .genre-select {
            padding: 0.55rem 0.9rem;
            border: 1px solid var(--wine-border);
            border-radius: var(--radius-sm);
            font-family: var(--font-body);
            font-size: 0.9rem;
            color: var(--text-main);
            background: #FFFFFF;
            outline: none;
            cursor: pointer;
        }

        .table-card {
            background-color: #FFFFFF;
            border: 1px solid var(--wine-border);
            border-radius: var(--radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-card);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        thead {
            background-color: var(--wine-soft);
            border-bottom: 1px solid var(--wine-border);
        }

        th {
            padding: 0.9rem 1.25rem;
            font-size: 0.825rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--wine-dark);
        }

        td {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid #F3EAEB;
            font-size: 0.9rem;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover td {
            background-color: #FAF4F5;
        }

        .badge-id {
            background-color: var(--wine-tint);
            color: var(--wine-dark);
            font-size: 0.75rem;
            font-weight: 700;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
        }

        .badge-rating {
            background-color: #FFF8E1;
            color: #B78103;
            border: 1px solid #FFE082;
            font-weight: 700;
            padding: 0.2rem 0.5rem;
            border-radius: 4px;
            font-size: 0.8rem;
        }

        .badge-genre {
            background-color: var(--wine-tint);
            color: var(--wine-vibrant);
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.25rem 0.65rem;
            border-radius: 6px;
            display: inline-block;
        }

        .actions-cell {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-action {
            padding: 0.35rem 0.65rem;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
        }

        .btn-edit {
            background-color: var(--wine-tint);
            color: var(--wine-dark);
        }

        .btn-edit:hover {
            background-color: var(--wine-primary);
            color: white;
        }

        .btn-delete {
            background-color: #FEECEC;
            color: #C62828;
        }

        .btn-delete:hover {
            background-color: #C62828;
            color: white;
        }

        .empty-state {
            padding: 3rem;
            text-align: center;
            color: var(--text-muted);
        }

        .alert-success {
            background: #E8F5E9;
            color: #2E7D32;
            border: 1px solid #A5D6A7;
            padding: 0.85rem 1.25rem;
            border-radius: var(--radius-sm);
            margin-bottom: 1.5rem;
            font-weight: 500;
        }

        .footer {
            padding: 1.5rem;
            text-align: center;
            font-size: 0.85rem;
            color: var(--text-light);
            border-top: 1px solid var(--wine-border);
            background-color: #FFFFFF;
            margin-top: auto;
        }
    </style>
</head>
<body>

    <header class="navbar">
        <div class="nav-container">
            <a href="index.jsp" class="brand">
                <div class="brand-icon">🎬</div>
                <span class="brand-text">CineTrack</span>
            </a>
            <div class="nav-actions">
                <a href="index.jsp" class="btn btn-outline">&larr; Dashboard</a>
                <a href="displayMovie" class="btn btn-wine">+ Add Movie</a>
            </div>
        </div>
    </header>

    <main class="main-container">

        <% String successMsg = (String) request.getAttribute("successMessage");
           if (successMsg != null && !successMsg.isEmpty()) { %>
            <div class="alert-success">
                ✓ <%= successMsg %>
            </div>
        <% } %>

        <div class="page-header">
            <div>
                <h1 class="page-title">Feature Films</h1>
                <p class="page-subtitle">All cataloged movies in the CineTrack universe</p>
            </div>
            <a href="displayMovie" class="btn btn-wine">+ Add New Movie</a>
        </div>

        <%
            String activeSearch = (String) request.getAttribute("activeSearch");
            Integer activeGenreId = (Integer) request.getAttribute("activeGenreId");
            List<Genre> allGenres = (List<Genre>) request.getAttribute("genres");
        %>

        <!-- Filter & Search Toolbar -->
        <div class="filter-toolbar">
            <form action="searchMovies" method="get" class="search-group">
                <input type="text" 
                       name="query" 
                       class="search-input" 
                       placeholder="Search by title, synopsis, or language..." 
                       value="<%= (activeSearch != null) ? activeSearch : "" %>">
                <button type="submit" class="btn btn-wine">Search</button>
            </form>

            <div class="filter-group">
                <select class="genre-select" onchange="if(this.value){window.location.href='filterMovies?genreId='+this.value;}else{window.location.href='viewMovies';}">
                    <option value="">All Genres</option>
                    <%
                        if (allGenres != null) {
                            for (Genre g : allGenres) {
                    %>
                        <option value="<%= g.getGenreId() %>" <%= (activeGenreId != null && activeGenreId == g.getGenreId()) ? "selected" : "" %>>
                            <%= g.getGenreName() %>
                        </option>
                    <%
                            }
                        }
                    %>
                </select>

                <% if (activeSearch != null || activeGenreId != null) { %>
                    <a href="viewMovies" class="btn btn-outline" style="font-size: 0.8rem; padding: 0.55rem 0.85rem;">✕ Clear Filter</a>
                <% } %>
            </div>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th style="width: 70px;">ID</th>
                        <th>Movie Title</th>
                        <th style="width: 140px;">Genre</th>
                        <th style="width: 160px;">Director</th>
                        <th style="width: 120px;">Language</th>
                        <th style="width: 100px;">Duration</th>
                        <th style="width: 90px;">Rating</th>
                        <th style="width: 150px; text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                    if (movies != null && !movies.isEmpty()) {
                        for (Movie m : movies) {
                %>
                    <tr>
                        <td><span class="badge-id">#<%= m.getMovieId() %></span></td>
                        <td>
                            <strong><%= m.getTitle() != null ? m.getTitle() : "" %></strong>
                            <% if (m.getDescription() != null && !m.getDescription().isEmpty()) { %>
                                <div style="font-size: 0.8rem; color: var(--text-muted); margin-top: 2px;"><%= m.getDescription() %></div>
                            <% } %>
                        </td>
                        <td>
                            <% if (m.getGenre() != null && m.getGenre().getGenreName() != null) { %>
                                <span class="badge-genre"><%= m.getGenre().getGenreName() %></span>
                            <% } else { %>
                                <span style="color: var(--text-light); font-size: 0.85rem;">—</span>
                            <% } %>
                        </td>
                        <td>
                            <% if (m.getDirector() != null && m.getDirector().getDirectorName() != null) { %>
                                <span style="font-weight: 500;"><%= m.getDirector().getDirectorName() %></span>
                            <% } else { %>
                                <span style="color: var(--text-light); font-size: 0.85rem;">—</span>
                            <% } %>
                        </td>
                        <td><%= m.getLanguage() != null ? m.getLanguage() : "-" %></td>
                        <td><%= m.getDuration() > 0 ? m.getDuration() + " min" : "-" %></td>
                        <td>
                            <% if (m.getRating() > 0) { %>
                                <span class="badge-rating"><%= m.getRating() %>/10</span>
                            <% } else { %>
                                -
                            <% } %>
                        </td>
                        <td style="text-align: center;">
                            <div class="actions-cell" style="justify-content: center;">
                                <a href="editMovie?id=<%= m.getMovieId() %>" class="btn-action btn-edit">Edit</a>
                                <a href="deleteMovie?id=<%= m.getMovieId() %>" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to delete this movie?')">Delete</a>
                            </div>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="8" class="empty-state">
                            No movies found matching the criteria. <a href="displayMovie" style="color: var(--wine-primary); font-weight: 600;">Click here to add one</a>.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2026 CineTrack &bull; Movie Management System</p>
    </footer>

</body>
</html>
