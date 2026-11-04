<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.movie.entity.Genre" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineTrack - All Genres</title>
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
            max-width: 1100px;
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

        .nav-actions {
            display: flex;
            gap: 0.75rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.5rem 1rem;
            border-radius: var(--radius-sm);
            text-decoration: none;
            font-size: 0.88rem;
            font-weight: 600;
            transition: var(--transition);
        }

        .btn-wine {
            background: linear-gradient(135deg, var(--wine-dark), var(--wine-primary));
            color: #FFFFFF;
        }

        .btn-wine:hover {
            background: linear-gradient(135deg, var(--wine-primary), var(--wine-vibrant));
            transform: translateY(-1px);
        }

        .btn-outline {
            background-color: var(--wine-soft);
            color: var(--wine-primary);
            border: 1px solid var(--wine-border);
        }

        .btn-outline:hover {
            background-color: var(--wine-tint);
        }

        .main-container {
            flex: 1;
            max-width: 1100px;
            width: 100%;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .page-title {
            font-family: var(--font-heading);
            font-size: 1.85rem;
            font-weight: 700;
            color: var(--wine-dark);
        }

        .page-subtitle {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .table-card {
            background-color: var(--bg-card);
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
            border-bottom: 2px solid var(--wine-border);
        }

        th {
            padding: 1rem 1.25rem;
            font-family: var(--font-heading);
            font-size: 0.9rem;
            font-weight: 700;
            color: var(--wine-dark);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid var(--wine-tint);
            font-size: 0.92rem;
            color: var(--text-main);
        }

        tbody tr:hover {
            background-color: #FAF4F5;
        }

        .badge-id {
            display: inline-block;
            background-color: var(--wine-soft);
            color: var(--wine-primary);
            font-weight: 700;
            padding: 2px 8px;
            border-radius: 6px;
            border: 1px solid var(--wine-border);
        }

        /* Action Buttons */
        .actions-cell {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .btn-action {
            display: inline-block;
            padding: 0.35rem 0.75rem;
            font-size: 0.8rem;
            font-weight: 600;
            border-radius: 6px;
            text-decoration: none;
            transition: var(--transition);
        }

        .btn-edit {
            background-color: var(--wine-soft);
            color: var(--wine-primary);
            border: 1px solid var(--wine-border);
        }

        .btn-edit:hover {
            background-color: var(--wine-primary);
            color: #FFFFFF;
        }

        .btn-delete {
            background-color: #FDF2F2;
            color: #991B1B;
            border: 1px solid #FCA5A5;
        }

        .btn-delete:hover {
            background-color: #DC2626;
            color: #FFFFFF;
            border-color: #DC2626;
        }

        .empty-state {
            text-align: center;
            padding: 3rem 1.5rem;
            color: var(--text-muted);
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
                <a href="index.jsp" class="btn btn-outline">&larr; Dashboard</a>
                <a href="displayGenre" class="btn btn-wine">+ Add Genre</a>
            </div>
        </div>
    </header>

    <main class="main-container">
        <div class="page-header">
            <div>
                <h1 class="page-title">Film Genres</h1>
                <p class="page-subtitle">All registered cinematic genres in the catalog</p>
            </div>
            <a href="displayGenre" class="btn btn-wine">+ Add New Genre</a>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th style="width: 80px;">ID</th>
                        <th style="width: 220px;">Genre Name</th>
                        <th>Description</th>
                        <th style="width: 160px; text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Genre> genres = (List<Genre>) request.getAttribute("genres");
                    if (genres != null && !genres.isEmpty()) {
                        for (Genre g : genres) {
                %>
                    <tr>
                        <td><span class="badge-id">#<%= g.getGenreId() %></span></td>
                        <td><strong><%= g.getGenreName() != null ? g.getGenreName() : "" %></strong></td>
                        <td><%= g.getGenreDescription() != null ? g.getGenreDescription() : "-" %></td>
                        <td style="text-align: center;">
                            <div class="actions-cell" style="justify-content: center;">
                                <a href="editGenre?id=<%= g.getGenreId() %>" class="btn-action btn-edit">Edit</a>
                                <a href="deleteGenre?id=<%= g.getGenreId() %>" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to delete this genre?')">Delete</a>
                            </div>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="4" class="empty-state">
                            No genres found in the database. <a href="displayGenre" style="color: var(--wine-primary); font-weight: 600;">Click here to add one</a>.
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
