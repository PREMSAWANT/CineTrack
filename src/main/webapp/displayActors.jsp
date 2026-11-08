<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.movie.entity.Actor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineTrack - All Actors</title>
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
                <a href="displayActor" class="btn btn-wine">+ Add Actor</a>
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
                <h1 class="page-title">Featured Actors &amp; Cast</h1>
                <p class="page-subtitle">List of star talent cataloged in CineTrack</p>
            </div>
            <a href="displayActor" class="btn btn-wine">+ Add New Actor</a>
        </div>

        <%
            String activeSearch = (String) request.getAttribute("activeSearch");
            String activeNat = (String) request.getAttribute("activeNationality");
        %>

        <!-- Filter & Search Toolbar -->
        <div class="filter-toolbar">
            <form action="searchActors" method="get" class="search-group">
                <input type="text" 
                       name="query" 
                       class="search-input" 
                       placeholder="Search by actor name or nationality..." 
                       value="<%= (activeSearch != null) ? activeSearch : "" %>">
                <button type="submit" class="btn btn-wine">Search</button>
            </form>

            <% if (activeSearch != null || activeNat != null) { %>
                <a href="viewActors" class="btn btn-outline" style="font-size: 0.8rem; padding: 0.55rem 0.85rem;">✕ Clear Filter</a>
            <% } %>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th style="width: 80px;">ID</th>
                        <th>Actor Name</th>
                        <th style="width: 180px;">Nationality</th>
                        <th style="width: 100px;">Age</th>
                        <th style="width: 180px;">Collaborating Director</th>
                        <th style="width: 150px; text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Actor> actors = (List<Actor>) request.getAttribute("actors");
                    if (actors != null && !actors.isEmpty()) {
                        for (Actor a : actors) {
                %>
                    <tr>
                        <td><span class="badge-id">#<%= a.getActorId() %></span></td>
                        <td><strong><%= a.getActorName() != null ? a.getActorName() : "" %></strong></td>
                        <td><%= a.getNationality() != null ? a.getNationality() : "-" %></td>
                        <td><%= a.getAge() > 0 ? a.getAge() + " yrs" : "-" %></td>
                        <td>
                            <% if (a.getDirector() != null && a.getDirector().getDirectorName() != null) { %>
                                <span style="font-weight: 500; color: var(--wine-primary);"><%= a.getDirector().getDirectorName() %></span>
                            <% } else { %>
                                <span style="color: var(--text-light); font-size: 0.85rem;">—</span>
                            <% } %>
                        </td>
                        <td style="text-align: center;">
                            <div class="actions-cell" style="justify-content: center;">
                                <a href="editActor?id=<%= a.getActorId() %>" class="btn-action btn-edit">Edit</a>
                                <a href="deleteActor?id=<%= a.getActorId() %>" class="btn-action btn-delete" onclick="return confirm('Are you sure you want to delete this actor?')">Delete</a>
                            </div>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6" class="empty-state">
                            No actors found matching criteria. <a href="displayActor" style="color: var(--wine-primary); font-weight: 600;">Click here to add one</a>.
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
