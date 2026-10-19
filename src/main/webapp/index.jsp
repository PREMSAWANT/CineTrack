<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineTrack - Cinema Dashboard</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            /* Wine & Bordeaux Palette */
            --wine-darkest: #2E050B;
            --wine-dark: #4A0E17;
            --wine-primary: #722F37;
            --wine-vibrant: #8F263E;
            --wine-light: #A8324F;
            --wine-soft: #F9F1F3;
            --wine-tint: #F3E4E7;
            --wine-border: #E8CCD2;
            
            /* Accents */
            --champagne-gold: #D4AF37;
            --rose-accent: #E5A4B1;
            
            /* Neutrals */
            --bg-canvas: #FAF6F7;
            --bg-card: #FFFFFF;
            --text-main: #24090E;
            --text-muted: #6B4950;
            --text-light: #9B7B82;
            
            /* Typography & Layout */
            --font-heading: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
            --radius-sm: 8px;
            --radius-md: 14px;
            --radius-lg: 20px;
            --shadow-soft: 0 4px 20px rgba(74, 14, 23, 0.06);
            --shadow-hover: 0 10px 28px rgba(74, 14, 23, 0.12);
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

        /* Top Navigation */
        .navbar {
            background-color: #FFFFFF;
            border-bottom: 1px solid var(--wine-border);
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 10px rgba(74, 14, 23, 0.04);
        }

        .nav-container {
            max-width: 1160px;
            margin: 0 auto;
            padding: 1rem 1.5rem;
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
            width: 38px;
            height: 38px;
            background: linear-gradient(135deg, var(--wine-dark), var(--wine-primary));
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            color: #FFFFFF;
            box-shadow: 0 4px 10px rgba(114, 47, 55, 0.3);
        }

        .brand-text {
            font-family: var(--font-heading);
            font-size: 1.35rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .brand-badge {
            font-size: 0.65rem;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 0.8px;
            background-color: var(--wine-soft);
            color: var(--wine-primary);
            padding: 2px 8px;
            border-radius: 20px;
            border: 1px solid var(--wine-border);
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 1.75rem;
            list-style: none;
        }

        .nav-link {
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text-muted);
            transition: var(--transition);
        }

        .nav-link:hover, .nav-link.active {
            color: var(--wine-primary);
            font-weight: 600;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.55rem 1.25rem;
            font-family: var(--font-body);
            font-size: 0.9rem;
            font-weight: 600;
            border-radius: var(--radius-sm);
            text-decoration: none;
            cursor: pointer;
            transition: var(--transition);
            border: none;
        }

        .btn-wine {
            background: linear-gradient(135deg, var(--wine-dark), var(--wine-primary));
            color: #FFFFFF;
            box-shadow: 0 4px 12px rgba(114, 47, 55, 0.25);
        }

        .btn-wine:hover {
            background: linear-gradient(135deg, var(--wine-primary), var(--wine-vibrant));
            box-shadow: 0 6px 16px rgba(114, 47, 55, 0.35);
            transform: translateY(-1px);
        }

        .btn-outline {
            background-color: transparent;
            color: var(--wine-primary);
            border: 1px solid var(--wine-border);
        }

        .btn-outline:hover {
            background-color: var(--wine-soft);
            border-color: var(--wine-primary);
        }

        /* Main Content Container */
        .main-content {
            flex: 1;
            max-width: 1160px;
            width: 100%;
            margin: 2rem auto;
            padding: 0 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        /* Hero Banner */
        .hero-banner {
            background: linear-gradient(135deg, var(--wine-darkest) 0%, var(--wine-dark) 55%, var(--wine-primary) 100%);
            color: #FFFFFF;
            padding: 2.5rem;
            border-radius: var(--radius-lg);
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(74, 14, 23, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .hero-banner::after {
            content: '🎬';
            position: absolute;
            right: 2rem;
            bottom: -1.5rem;
            font-size: 10rem;
            opacity: 0.05;
            pointer-events: none;
        }

        .hero-text h1 {
            font-family: var(--font-heading);
            font-size: 2.1rem;
            font-weight: 700;
            line-height: 1.2;
            margin-bottom: 0.6rem;
            letter-spacing: -0.5px;
        }

        .hero-text p {
            color: var(--rose-accent);
            font-size: 1.05rem;
            max-width: 600px;
            margin-bottom: 1.5rem;
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn-hero-primary {
            background-color: #FFFFFF;
            color: var(--wine-dark);
            padding: 0.65rem 1.4rem;
            font-weight: 600;
            border-radius: var(--radius-sm);
            text-decoration: none;
            transition: var(--transition);
        }

        .btn-hero-primary:hover {
            background-color: var(--wine-soft);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
        }

        .btn-hero-secondary {
            background-color: rgba(255, 255, 255, 0.12);
            color: #FFFFFF;
            border: 1px solid rgba(255, 255, 255, 0.25);
            padding: 0.65rem 1.4rem;
            font-weight: 600;
            border-radius: var(--radius-sm);
            text-decoration: none;
            transition: var(--transition);
        }

        .btn-hero-secondary:hover {
            background-color: rgba(255, 255, 255, 0.22);
            border-color: rgba(255, 255, 255, 0.4);
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.25rem;
        }

        .stat-card {
            background-color: var(--bg-card);
            border: 1px solid var(--wine-border);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            box-shadow: var(--shadow-soft);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
            border-color: var(--wine-primary);
        }

        .stat-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .stat-title {
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-muted);
        }

        .stat-icon {
            width: 36px;
            height: 36px;
            border-radius: var(--radius-sm);
            background-color: var(--wine-soft);
            color: var(--wine-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
        }

        .stat-value {
            font-family: var(--font-heading);
            font-size: 2rem;
            font-weight: 700;
            color: var(--wine-dark);
            letter-spacing: -0.5px;
        }

        .stat-footer {
            font-size: 0.82rem;
            color: var(--text-light);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 0.5rem;
            border-top: 1px solid var(--wine-tint);
        }

        .stat-footer a {
            color: var(--wine-primary);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .stat-footer a:hover {
            color: var(--wine-vibrant);
            text-decoration: underline;
        }

        /* Modules & Quick Actions Section */
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .section-title {
            font-family: var(--font-heading);
            font-size: 1.35rem;
            font-weight: 700;
            color: var(--wine-dark);
        }

        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 1.25rem;
        }

        .module-card {
            background-color: var(--bg-card);
            border: 1px solid var(--wine-border);
            border-radius: var(--radius-md);
            padding: 1.75rem;
            box-shadow: var(--shadow-soft);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .module-card:hover {
            border-color: var(--wine-primary);
            box-shadow: var(--shadow-hover);
        }

        .module-top {
            margin-bottom: 1.25rem;
        }

        .module-badge {
            display: inline-block;
            background-color: var(--wine-soft);
            color: var(--wine-primary);
            font-size: 0.75rem;
            font-weight: 700;
            padding: 3px 10px;
            border-radius: 20px;
            margin-bottom: 0.75rem;
            border: 1px solid var(--wine-border);
        }

        .module-card h3 {
            font-family: var(--font-heading);
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--wine-dark);
            margin-bottom: 0.4rem;
        }

        .module-card p {
            color: var(--text-muted);
            font-size: 0.92rem;
            line-height: 1.5;
        }

        /* Genre Tags showcase */
        .genres-panel {
            background-color: var(--bg-card);
            border: 1px solid var(--wine-border);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            box-shadow: var(--shadow-soft);
        }

        .genre-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.6rem;
            margin-top: 1rem;
        }

        .genre-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            background-color: var(--wine-soft);
            color: var(--wine-dark);
            font-size: 0.85rem;
            font-weight: 600;
            padding: 0.45rem 1rem;
            border-radius: 30px;
            border: 1px solid var(--wine-border);
            transition: var(--transition);
            text-decoration: none;
        }

        .genre-pill:hover {
            background-color: var(--wine-primary);
            color: #FFFFFF;
            border-color: var(--wine-primary);
            transform: translateY(-2px);
        }

        /* Footer */
        .footer {
            background-color: #FFFFFF;
            border-top: 1px solid var(--wine-border);
            padding: 1.5rem;
            margin-top: auto;
            text-align: center;
            color: var(--text-light);
            font-size: 0.85rem;
        }

        .footer span {
            color: var(--wine-primary);
            font-weight: 600;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <header class="navbar">
        <div class="nav-container">
            <a href="index.jsp" class="brand">
                <div class="brand-icon">🎬</div>
                <div>
                    <span class="brand-text">CineTrack</span>
                    <span class="brand-badge">Cinema Studio</span>
                </div>
            </a>

            <nav>
                <ul class="nav-links">
                    <li><a href="index.jsp" class="nav-link active">Dashboard</a></li>
                    <li><a href="displayGenre" class="nav-link">Genres</a></li>
                    <li><a href="#movies" class="nav-link">Movies</a></li>
                    <li><a href="#directors" class="nav-link">Directors</a></li>
                    <li><a href="#actors" class="nav-link">Actors</a></li>
                </ul>
            </nav>

            <div class="nav-actions">
                <a href="displayGenre" class="btn btn-wine">
                    <span>+ Add Genre</span>
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">

        <!-- Hero Banner -->
        <section class="hero-banner">
            <div class="hero-text">
                <h1>Cinema Hub &amp; Dashboard</h1>
                <p>Welcome to CineTrack. Effortlessly manage your movie database, curate film genres, track directors, and connect star cast.</p>
                <div class="hero-buttons">
                    <a href="displayGenre" class="btn-hero-primary">Go to Add Genre</a>
                    <a href="addGenre.jsp" class="btn-hero-secondary">Direct JSP Page</a>
                </div>
            </div>
        </section>

        <!-- Stats Overview Cards -->
        <section class="stats-grid">
            <!-- Genre Stat -->
            <div class="stat-card">
                <div class="stat-header">
                    <span class="stat-title">Active Genres</span>
                    <div class="stat-icon">🏷️</div>
                </div>
                <div class="stat-value">14</div>
                <div class="stat-footer">
                    <span>Configured in DB</span>
                    <a href="displayGenre">Add Genre &rarr;</a>
                </div>
            </div>

            <!-- Movies Stat -->
            <div class="stat-card">
                <div class="stat-header">
                    <span class="stat-title">Total Movies</span>
                    <div class="stat-icon">🎬</div>
                </div>
                <div class="stat-value">128</div>
                <div class="stat-footer">
                    <span>Cataloged titles</span>
                    <a href="#movies">View List &rarr;</a>
                </div>
            </div>

            <!-- Directors Stat -->
            <div class="stat-card">
                <div class="stat-header">
                    <span class="stat-title">Directors</span>
                    <div class="stat-icon">🎥</div>
                </div>
                <div class="stat-value">46</div>
                <div class="stat-footer">
                    <span>Filmmakers</span>
                    <a href="#directors">Explore &rarr;</a>
                </div>
            </div>

            <!-- Actors Stat -->
            <div class="stat-card">
                <div class="stat-header">
                    <span class="stat-title">Cast & Actors</span>
                    <div class="stat-icon">🎭</div>
                </div>
                <div class="stat-value">312</div>
                <div class="stat-footer">
                    <span>Featured talents</span>
                    <a href="#actors">Cast Directory &rarr;</a>
                </div>
            </div>
        </section>

        <!-- Modules Grid -->
        <section>
            <div class="section-header">
                <h2 class="section-title">Quick Actions</h2>
            </div>
            <div class="modules-grid">
                <!-- Genre Module Card -->
                <div class="module-card">
                    <div class="module-top">
                        <span class="module-badge">Active Entity</span>
                        <h3>Genre Management</h3>
                        <p>Define new film categories and tag movie releases with their corresponding genres.</p>
                    </div>
                    <a href="displayGenre" class="btn btn-wine" style="width: 100%; justify-content: center;">
                        Open Add Genre Form
                    </a>
                </div>

                <!-- Movie Module Card -->
                <div class="module-card">
                    <div class="module-top">
                        <span class="module-badge">Catalog</span>
                        <h3>Film Production</h3>
                        <p>Register new releases, associate them with directors, and assign genres and cast lists.</p>
                    </div>
                    <a href="#movies" class="btn btn-outline" style="width: 100%; justify-content: center;">
                        Manage Movies
                    </a>
                </div>

                <!-- Cast & Crew Card -->
                <div class="module-card">
                    <div class="module-top">
                        <span class="module-badge">Cast & Crew</span>
                        <h3>Directors & Actors</h3>
                        <p>Maintain filmmaker profiles and cast member associations across the cinematic library.</p>
                    </div>
                    <a href="#cast" class="btn btn-outline" style="width: 100%; justify-content: center;">
                        Manage Cast
                    </a>
                </div>
            </div>
        </section>

        <!-- Curated Genres Showcase -->
        <section class="genres-panel">
            <h3 style="font-family: var(--font-heading); color: var(--wine-dark); font-size: 1.15rem; font-weight: 700;">
                Popular Film Genres
            </h3>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 0.25rem;">
                Browse standard film genres or create custom categories for your collection.
            </p>
            <div class="genre-tags">
                <a href="displayGenre" class="genre-pill">⚡ Action</a>
                <a href="displayGenre" class="genre-pill">🎭 Drama</a>
                <a href="displayGenre" class="genre-pill">🔍 Mystery</a>
                <a href="displayGenre" class="genre-pill">🚀 Sci-Fi</a>
                <a href="displayGenre" class="genre-pill">❤️ Romance</a>
                <a href="displayGenre" class="genre-pill">🔪 Thriller</a>
                <a href="displayGenre" class="genre-pill">😂 Comedy</a>
                <a href="displayGenre" class="genre-pill">📜 Historical</a>
                <a href="displayGenre" class="genre-pill">+ Add New Genre</a>
            </div>
        </section>

    </main>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 <span>CineTrack</span>. Built with Spring MVC &amp; Hibernate JPA &bull; Cinema Edition</p>
    </footer>

</body>
</html>
