<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.movie.entity.Genre" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineTrack - Edit Genre</title>
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
            line-height: 1.5;
        }

        .navbar {
            background-color: #FFFFFF;
            border-bottom: 1px solid var(--wine-border);
            padding: 1rem 1.5rem;
            box-shadow: 0 2px 10px rgba(74, 14, 23, 0.04);
        }

        .nav-container {
            max-width: 1000px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            text-decoration: none;
            color: var(--wine-dark);
        }

        .brand-icon {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--wine-dark), var(--wine-primary));
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
            color: #FFFFFF;
        }

        .brand-text {
            font-family: var(--font-heading);
            font-size: 1.25rem;
            font-weight: 700;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            color: var(--wine-primary);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            padding: 0.45rem 0.9rem;
            border-radius: var(--radius-sm);
            background-color: var(--wine-soft);
            border: 1px solid var(--wine-border);
            transition: var(--transition);
        }

        .back-link:hover {
            background-color: var(--wine-tint);
        }

        .main-container {
            flex: 1;
            max-width: 680px;
            width: 100%;
            margin: 2.5rem auto;
            padding: 0 1.5rem;
        }

        .card {
            background-color: var(--bg-card);
            border: 1px solid var(--wine-border);
            border-radius: var(--radius-lg);
            padding: 2.5rem;
            box-shadow: var(--shadow-card);
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--wine-dark), var(--wine-primary), var(--wine-vibrant));
        }

        .card-header {
            margin-bottom: 2rem;
            text-align: center;
        }

        .card-badge {
            display: inline-block;
            background-color: var(--wine-soft);
            color: var(--wine-primary);
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.6px;
            text-transform: uppercase;
            padding: 4px 12px;
            border-radius: 20px;
            border: 1px solid var(--wine-border);
            margin-bottom: 0.75rem;
        }

        .card-title {
            font-family: var(--font-heading);
            font-size: 1.85rem;
            font-weight: 700;
            color: var(--wine-dark);
            letter-spacing: -0.5px;
            margin-bottom: 0.4rem;
        }

        .card-subtitle {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            font-family: var(--font-body);
            font-size: 0.95rem;
            color: var(--text-main);
            background-color: #FFFFFF;
            border: 1.5px solid var(--wine-border);
            border-radius: var(--radius-sm);
            transition: var(--transition);
            outline: none;
        }

        .form-control:focus {
            border-color: var(--wine-primary);
            box-shadow: 0 0 0 3.5px rgba(114, 47, 55, 0.12);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
            margin-top: 2rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            font-family: var(--font-body);
            font-size: 0.95rem;
            font-weight: 600;
            border-radius: var(--radius-sm);
            text-decoration: none;
            cursor: pointer;
            transition: var(--transition);
            border: none;
        }

        .btn-submit {
            flex: 1;
            background: linear-gradient(135deg, var(--wine-dark), var(--wine-primary));
            color: #FFFFFF;
            box-shadow: 0 4px 14px rgba(114, 47, 55, 0.25);
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, var(--wine-primary), var(--wine-vibrant));
            transform: translateY(-1px);
        }

        .btn-cancel {
            background-color: transparent;
            color: var(--text-muted);
            border: 1px solid var(--wine-border);
        }

        .btn-cancel:hover {
            background-color: var(--wine-soft);
            color: var(--wine-dark);
        }

        .footer {
            text-align: center;
            padding: 1.5rem;
            color: var(--text-light);
            font-size: 0.82rem;
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
                <a href="viewGenres" class="back-link">&larr; Back to Genres</a>
            </div>
        </div>
    </header>

    <main class="main-container">
        <%
            Genre genre = (Genre) request.getAttribute("genre");
            if (genre != null) {
        %>
        <div class="card">
            <div class="card-header">
                <span class="card-badge">Modify Entry</span>
                <h1 class="card-title">Edit Genre</h1>
                <p class="card-subtitle">Update genre details in the database</p>
            </div>

            <form action="updateGenre" method="post">
                <!-- Hidden ID -->
                <input type="hidden" name="genreId" value="<%= genre.getGenreId() %>">

                <div class="form-group">
                    <label for="genreName" class="form-label">Genre Name</label>
                    <input type="text" 
                           id="genreName" 
                           name="genreName" 
                           class="form-control" 
                           value="<%= genre.getGenreName() != null ? genre.getGenreName() : "" %>" 
                           required>
                </div>

                <div class="form-group">
                    <label for="genreDescription" class="form-label">Genre Description</label>
                    <textarea id="genreDescription" 
                              name="genreDescription" 
                              class="form-control" 
                              rows="4"><%= genre.getGenreDescription() != null ? genre.getGenreDescription() : "" %></textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-submit">Save Changes</button>
                    <a href="viewGenres" class="btn btn-cancel">Cancel</a>
                </div>
            </form>
        </div>
        <% } else { %>
        <div class="card">
            <p style="text-align: center; color: var(--text-muted);">Genre not found. <a href="viewGenres" style="color: var(--wine-primary);">Return to list</a>.</p>
        </div>
        <% } %>
    </main>

    <footer class="footer">
        <p>&copy; 2026 CineTrack &bull; Movie Management System</p>
    </footer>

</body>
</html>
