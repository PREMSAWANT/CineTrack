<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.persistence.EntityManagerFactory, jakarta.persistence.EntityManager, jakarta.persistence.Persistence, java.util.List, com.movie.entity.Movie, com.movie.entity.Director" %>
<%
    Integer movieCount = (Integer) request.getAttribute("movieCount");
    Integer genreCount = (Integer) request.getAttribute("genreCount");
    Integer directorCount = (Integer) request.getAttribute("directorCount");
    Integer actorCount = (Integer) request.getAttribute("actorCount");
    List<Movie> liveMovies = null;

    // Fetch live record counts and movies directly from database
    if (movieCount == null || genreCount == null || directorCount == null || actorCount == null) {
        EntityManagerFactory emf = null;
        EntityManager em = null;
        try {
            emf = Persistence.createEntityManagerFactory("cinetrack");
            em = emf.createEntityManager();

            if (genreCount == null) {
                Number count = (Number) em.createQuery("select count(g) from Genre g").getSingleResult();
                genreCount = count != null ? count.intValue() : 0;
            }
            if (movieCount == null) {
                Number count = (Number) em.createQuery("select count(m) from Movie m").getSingleResult();
                movieCount = count != null ? count.intValue() : 0;
            }
            if (directorCount == null) {
                Number count = (Number) em.createQuery("select count(d) from Director d").getSingleResult();
                directorCount = count != null ? count.intValue() : 0;
            }
            if (actorCount == null) {
                Number count = (Number) em.createQuery("select count(a) from Actor a").getSingleResult();
                actorCount = count != null ? count.intValue() : 0;
            }
            try {
                liveMovies = em.createQuery("select m from Movie m order by m.movieId asc", Movie.class).getResultList();
            } catch (Exception ex) {
                // Ignore if query fails
            }
        } catch (Exception e) {
            // Keep default values if database is unreachable
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
            if (emf != null && emf.isOpen()) {
                emf.close();
            }
        }
    }

    if (genreCount == null) genreCount = 0;
    if (movieCount == null) movieCount = 0;
    if (directorCount == null) directorCount = 0;
    if (actorCount == null) actorCount = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineTrack &bull; Cinema Archival Studio &amp; Command Console</title>
    
    <!-- Modern Editorial Cinema Fonts: Outfit, Plus Jakarta Sans, JetBrains Mono -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600;700&family=Outfit:wght@300;400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            /* Bespoke Cinema Dark Space */
            --space-black: #060103;
            --space-charcoal: #0D0306;
            --space-slate: #15050A;
            --space-card: rgba(22, 6, 11, 0.78);
            --space-card-elevated: rgba(32, 9, 17, 0.92);
            
            /* Anamorphic Crimson & Neon Ruby */
            --crimson-core: #93132B;
            --crimson-vivid: #D61543;
            --crimson-neon: #FF2A5F;
            --crimson-glow: rgba(255, 42, 95, 0.4);
            --crimson-subtle: rgba(214, 21, 67, 0.12);
            
            /* Physical Media & Optics */
            --film-amber: #F59E0B;
            --film-gold: #FCD34D;
            --film-glow: rgba(245, 158, 11, 0.35);
            --optics-cyan: #38BDF8;
            
            /* Text Systems */
            --text-luminous: #FFFFFF;
            --text-heading: #FFF2F4;
            --text-secondary: #D4B6BE;
            --text-muted: #7D5D66;
            --text-faint: #4E353B;
            
            /* Layering & Borders */
            --border-light: rgba(255, 255, 255, 0.08);
            --border-crimson: rgba(255, 42, 95, 0.22);
            --border-crimson-bright: rgba(255, 42, 95, 0.6);
            --glass-sheet: blur(24px) saturate(160%);
            
            /* Fonts */
            --font-title: 'Outfit', sans-serif;
            --font-sans: 'Plus Jakarta Sans', sans-serif;
            --font-mono: 'JetBrains Mono', monospace;
            
            --radius-xs: 6px;
            --radius-sm: 10px;
            --radius-md: 16px;
            --radius-lg: 24px;
            --radius-xl: 32px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-sans);
            background-color: var(--space-black);
            color: var(--text-secondary);
            min-height: 100vh;
            overflow-x: hidden;
            display: flex;
            flex-direction: column;
            line-height: 1.6;
            position: relative;
        }

        /* LAYER 0: Cinema Atmosphere, Noise Texture & Moving Projector Light Cone */
        .ambient-projector-beam {
            position: fixed;
            top: -200px;
            right: 15%;
            width: 800px;
            height: 1000px;
            background: radial-gradient(ellipse at top, rgba(255, 42, 95, 0.16) 0%, rgba(147, 19, 43, 0.08) 40%, transparent 75%);
            filter: blur(80px);
            pointer-events: none;
            z-index: 0;
            transform: rotate(-18deg);
            animation: projectorSweep 14s ease-in-out infinite alternate;
        }

        .ambient-lens-flare {
            position: fixed;
            bottom: 5%;
            left: -100px;
            width: 650px;
            height: 650px;
            background: radial-gradient(circle, rgba(214, 21, 67, 0.1) 0%, rgba(245, 158, 11, 0.04) 45%, transparent 70%);
            filter: blur(90px);
            pointer-events: none;
            z-index: 0;
            animation: lensBreathe 18s ease-in-out infinite alternate;
        }

        @keyframes projectorSweep {
            0% { transform: rotate(-18deg) translate(0, 0) scale(1); opacity: 0.8; }
            50% { transform: rotate(-12deg) translate(40px, 30px) scale(1.1); opacity: 1; }
            100% { transform: rotate(-22deg) translate(-30px, 10px) scale(0.95); opacity: 0.75; }
        }

        @keyframes lensBreathe {
            0% { transform: scale(1); opacity: 0.6; }
            100% { transform: scale(1.25) translate(40px, -30px); opacity: 0.95; }
        }

        /* Subtle Cinema Grain Grid Lines */
        .cinematic-grid-bg {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background-image: 
                linear-gradient(rgba(255, 42, 95, 0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255, 42, 95, 0.03) 1px, transparent 1px);
            background-size: 60px 60px;
            pointer-events: none;
            z-index: 0;
        }

        /* ================= LAYER 1: BESPOKE STUDIO APEX BAR ================= */
        .apex-bar {
            position: sticky;
            top: 0;
            z-index: 100;
            background: rgba(6, 1, 3, 0.85);
            backdrop-filter: var(--glass-sheet);
            -webkit-backdrop-filter: var(--glass-sheet);
            border-bottom: 1px solid var(--border-crimson);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.7);
        }

        .apex-container {
            max-width: 1380px;
            margin: 0 auto;
            padding: 0.85rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .studio-brand {
            display: flex;
            align-items: center;
            gap: 1rem;
            text-decoration: none;
        }

        .camera-badge {
            width: 46px;
            height: 46px;
            border-radius: var(--radius-sm);
            background: linear-gradient(135deg, #FF1E56 0%, #7E0A21 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            color: #FFFFFF;
            box-shadow: 0 0 25px rgba(255, 30, 86, 0.5), inset 0 1px 1px rgba(255, 255, 255, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
        }

        .camera-badge::after {
            content: '';
            position: absolute;
            top: 4px; right: 4px;
            width: 6px; height: 6px;
            border-radius: 50%;
            background: #22C55E;
            box-shadow: 0 0 8px #22C55E;
            animation: recordBlink 1.5s infinite;
        }

        @keyframes recordBlink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        .brand-meta {
            display: flex;
            flex-direction: column;
        }

        .brand-name {
            font-family: var(--font-title);
            font-size: 1.55rem;
            font-weight: 800;
            letter-spacing: -0.6px;
            color: var(--text-heading);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .brand-name span {
            background: linear-gradient(135deg, #FFFFFF 0%, #FF8FA3 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .brand-tag {
            font-family: var(--font-mono);
            font-size: 0.68rem;
            letter-spacing: 1.5px;
            color: var(--crimson-neon);
            text-transform: uppercase;
            font-weight: 700;
        }

        /* Live Database Heartbeat Pill */
        .telemetry-pill {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            background: rgba(18, 4, 8, 0.9);
            border: 1px solid var(--border-crimson);
            padding: 0.4rem 1rem;
            border-radius: var(--radius-sm);
            font-family: var(--font-mono);
            font-size: 0.75rem;
            color: #FBCFE8;
            box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.05);
        }

        .telemetry-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #10B981;
            box-shadow: 0 0 12px #10B981;
            animation: telemetryPulse 2s infinite;
        }

        @keyframes telemetryPulse {
            0% { transform: scale(0.9); box-shadow: 0 0 4px #10B981; }
            50% { transform: scale(1.2); box-shadow: 0 0 14px #10B981; }
            100% { transform: scale(0.9); box-shadow: 0 0 4px #10B981; }
        }

        .nav-links-cluster {
            display: flex;
            align-items: center;
            gap: 2rem;
            list-style: none;
        }

        .nav-link-item {
            font-size: 0.92rem;
            font-weight: 600;
            color: var(--text-muted);
            text-decoration: none;
            transition: all 0.25s ease;
            position: relative;
            padding: 0.35rem 0;
            letter-spacing: 0.3px;
        }

        .nav-link-item:hover, .nav-link-item.active {
            color: var(--text-luminous);
        }

        .nav-link-item.active::after {
            content: '';
            position: absolute;
            bottom: -6px;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, var(--crimson-vivid), var(--crimson-neon));
            box-shadow: 0 0 12px var(--crimson-neon);
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 0.85rem;
        }

        /* Buttons with Physical & Tactile Layering */
        .btn-cinema {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            padding: 0.65rem 1.4rem;
            font-family: var(--font-sans);
            font-size: 0.88rem;
            font-weight: 700;
            border-radius: var(--radius-sm);
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s cubic-bezier(0.2, 0.8, 0.2, 1);
            border: 1px solid transparent;
            white-space: nowrap;
        }

        .btn-crimson-solid {
            background: linear-gradient(135deg, #FF1E56 0%, #A60D2D 100%);
            color: #FFFFFF;
            box-shadow: 0 4px 20px rgba(255, 30, 86, 0.45), inset 0 1px 1px rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.15);
        }

        .btn-crimson-solid:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(255, 30, 86, 0.7);
            color: #FFFFFF;
        }

        .btn-ghost-acrylic {
            background: rgba(255, 255, 255, 0.04);
            color: var(--text-heading);
            border-color: var(--border-crimson);
            backdrop-filter: blur(10px);
        }

        .btn-ghost-acrylic:hover {
            background: rgba(255, 42, 95, 0.15);
            border-color: var(--crimson-neon);
            color: #FFFFFF;
            transform: translateY(-2px);
        }

        /* ================= LAYER 2: 35MM CONTINUOUS SPROCKET FILM STRIP RIBBON ================= */
        .filmstrip-ribbon {
            position: relative;
            z-index: 10;
            background: #000000;
            border-top: 1px solid rgba(255, 42, 95, 0.25);
            border-bottom: 1px solid rgba(255, 42, 95, 0.25);
            padding: 0.75rem 0;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.9);
        }

        /* Authentic Sprocket Perforations along top & bottom */
        .filmstrip-sprockets-top, .filmstrip-sprockets-bottom {
            height: 8px;
            width: 100%;
            background-image: repeating-linear-gradient(90deg, #1A0408 0px, #1A0408 14px, #000000 14px, #000000 24px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }
        .filmstrip-sprockets-bottom {
            border-bottom: none;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
        }

        .filmstrip-track {
            display: flex;
            width: max-content;
            animation: filmGlide 34s linear infinite;
            padding: 0.5rem 0;
        }

        .filmstrip-track:hover {
            animation-play-state: paused;
        }

        @keyframes filmGlide {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        .film-frame-chip {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.4rem 1.75rem;
            border-right: 1px solid rgba(255, 42, 95, 0.2);
            font-family: var(--font-mono);
            font-size: 0.8rem;
            color: #FCE7F3;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        .frame-number {
            color: var(--crimson-neon);
            font-weight: 700;
        }

        .frame-rating {
            color: var(--film-gold);
            font-weight: 700;
        }

        /* ================= LAYER 3: 3D ANAMORPHIC CINEMA HERO STAGE ================= */
        .workspace-canvas {
            max-width: 1380px;
            width: 100%;
            margin: 0 auto;
            padding: 2.5rem 2rem 5rem;
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            gap: 4rem;
        }

        /* Overlapping Layered Hero Stage */
        .anamorphic-stage {
            position: relative;
            background: linear-gradient(135deg, rgba(20, 5, 10, 0.95) 0%, rgba(35, 7, 16, 0.85) 50%, rgba(12, 3, 6, 0.95) 100%);
            border: 1px solid var(--border-crimson);
            border-radius: var(--radius-xl);
            overflow: visible; /* Allows poster to break out */
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.8), inset 0 1px 0 rgba(255, 255, 255, 0.12);
            display: grid;
            grid-template-columns: 1.25fr 0.85fr;
            padding: 3.5rem;
            gap: 3.5rem;
            align-items: center;
        }

        /* Anamorphic Lens Flare Line across hero */
        .anamorphic-stage::before {
            content: '';
            position: absolute;
            top: 0; left: 10%; right: 10%;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--crimson-neon), var(--film-gold), transparent);
            box-shadow: 0 0 15px var(--crimson-neon);
        }

        .stage-intel {
            position: relative;
            z-index: 3;
        }

        .stage-technical-tag {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255, 42, 95, 0.12);
            border: 1px solid var(--border-crimson);
            padding: 0.35rem 0.9rem;
            border-radius: var(--radius-xs);
            font-family: var(--font-mono);
            font-size: 0.72rem;
            font-weight: 700;
            color: #FDA4AF;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 1.25rem;
        }

        .stage-headline {
            font-family: var(--font-title);
            font-size: 3.25rem;
            font-weight: 900;
            line-height: 1.1;
            letter-spacing: -1.2px;
            color: var(--text-luminous);
            margin-bottom: 1.25rem;
        }

        .stage-headline em {
            font-style: normal;
            background: linear-gradient(135deg, #FF3366 0%, #FF85A1 60%, #FFFFFF 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stage-director-quote {
            position: relative;
            padding-left: 1.25rem;
            border-left: 3px solid var(--crimson-neon);
            color: var(--text-secondary);
            font-size: 1.05rem;
            line-height: 1.7;
            max-width: 580px;
            margin-bottom: 2rem;
        }

        .stage-director-quote cite {
            display: block;
            margin-top: 0.5rem;
            font-family: var(--font-mono);
            font-size: 0.78rem;
            color: var(--crimson-neon);
            font-style: normal;
            font-weight: 700;
            text-transform: uppercase;
        }

        .stage-actions-row {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        /* 3D Overlapping Foreground Poster Card */
        .stage-poster-plane {
            position: relative;
            z-index: 5;
            display: flex;
            justify-content: center;
        }

        .depth-poster-monolith {
            position: relative;
            width: 100%;
            max-width: 420px;
            background: var(--space-card-elevated);
            border: 1px solid var(--border-crimson-bright);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            box-shadow: 
                0 30px 70px rgba(0, 0, 0, 0.9), 
                0 0 50px rgba(255, 42, 95, 0.25),
                inset 0 1px 1px rgba(255, 255, 255, 0.2);
            display: flex;
            gap: 1.5rem;
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            animation: monolithFloat 6s ease-in-out infinite alternate;
        }

        .depth-poster-monolith:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 
                0 40px 90px rgba(0, 0, 0, 0.95), 
                0 0 60px rgba(255, 42, 95, 0.45);
            border-color: var(--crimson-neon);
        }

        @keyframes monolithFloat {
            0% { transform: translateY(0); }
            100% { transform: translateY(-10px); }
        }

        .monolith-art {
            width: 160px;
            height: 240px;
            border-radius: var(--radius-md);
            object-fit: cover;
            flex-shrink: 0;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.15);
        }

        .monolith-body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .monolith-flag {
            font-family: var(--font-mono);
            font-size: 0.68rem;
            font-weight: 700;
            color: var(--film-gold);
            background: rgba(245, 158, 11, 0.15);
            border: 1px solid rgba(245, 158, 11, 0.35);
            padding: 3px 8px;
            border-radius: var(--radius-xs);
            width: fit-content;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .monolith-title {
            font-family: var(--font-title);
            font-size: 1.55rem;
            font-weight: 800;
            color: #FFFFFF;
            line-height: 1.2;
            margin: 0.4rem 0 0.25rem;
        }

        .monolith-score {
            display: flex;
            align-items: center;
            gap: 0.35rem;
            font-family: var(--font-mono);
            font-size: 1rem;
            font-weight: 700;
            color: var(--film-gold);
        }

        .monolith-specs {
            font-size: 0.82rem;
            color: var(--text-muted);
            line-height: 1.5;
            margin-top: 0.5rem;
        }

        .monolith-specs strong {
            color: var(--text-secondary);
        }

        /* ================= LAYER 4: 35MM CONTINUOUS POSTER REEL (PHYSICAL CASSETTE) ================= */
        .cassette-section {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .console-header-block {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            border-bottom: 1px solid var(--border-light);
            padding-bottom: 1rem;
        }

        .console-label {
            font-family: var(--font-mono);
            font-size: 0.72rem;
            font-weight: 700;
            color: var(--crimson-neon);
            letter-spacing: 1.5px;
            text-transform: uppercase;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .console-title {
            font-family: var(--font-title);
            font-size: 2.1rem;
            font-weight: 800;
            color: var(--text-heading);
            letter-spacing: -0.6px;
        }

        .console-subtitle {
            font-size: 0.88rem;
            color: var(--text-muted);
        }

        /* The Continuous Moving Reel Stage */
        .continuous-reel-viewport {
            width: 100%;
            overflow: hidden;
            position: relative;
            padding: 1.5rem 0;
            mask-image: linear-gradient(to right, transparent 0%, black 4%, black 96%, transparent 100%);
            -webkit-mask-image: linear-gradient(to right, transparent 0%, black 4%, black 96%, transparent 100%);
        }

        .continuous-reel-track {
            display: flex;
            gap: 1.75rem;
            width: max-content;
            animation: reelGlide 38s linear infinite;
        }

        .continuous-reel-track:hover {
            animation-play-state: paused;
        }

        @keyframes reelGlide {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        /* The Unique Layered Movie Card */
        .film-cassette-card {
            position: relative;
            width: 215px;
            flex-shrink: 0;
            background: var(--space-card);
            border: 1px solid var(--border-crimson);
            border-radius: var(--radius-md);
            overflow: hidden;
            transition: all 0.35s cubic-bezier(0.2, 0.8, 0.2, 1);
            display: flex;
            flex-direction: column;
            cursor: pointer;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.6);
        }

        .film-cassette-card:hover {
            transform: translateY(-12px) scale(1.04);
            border-color: var(--crimson-neon);
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.9), 0 0 40px var(--crimson-glow);
            background: var(--space-card-elevated);
        }

        .cassette-media {
            position: relative;
            width: 100%;
            aspect-ratio: 2 / 3;
            overflow: hidden;
            background: #140307;
        }

        .cassette-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            transition: transform 0.6s cubic-bezier(0.2, 0.8, 0.2, 1);
        }

        .film-cassette-card:hover .cassette-img {
            transform: scale(1.08);
        }

        .cassette-badge-score {
            position: absolute;
            top: 10px; right: 10px;
            background: rgba(6, 1, 3, 0.9);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(245, 158, 11, 0.5);
            color: var(--film-gold);
            font-family: var(--font-mono);
            font-size: 0.78rem;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: var(--radius-xs);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.7);
        }

        .cassette-badge-genre {
            position: absolute;
            bottom: 10px; left: 10px;
            background: rgba(214, 21, 67, 0.9);
            backdrop-filter: blur(8px);
            color: #FFFFFF;
            font-family: var(--font-mono);
            font-size: 0.68rem;
            font-weight: 700;
            text-transform: uppercase;
            padding: 3px 8px;
            border-radius: var(--radius-xs);
            letter-spacing: 0.5px;
        }

        .cassette-info {
            padding: 1.1rem 1rem;
            display: flex;
            flex-direction: column;
            gap: 0.35rem;
            flex: 1;
            justify-content: space-between;
        }

        .cassette-title {
            font-family: var(--font-title);
            font-size: 1.15rem;
            font-weight: 700;
            color: #FFFFFF;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .cassette-sub {
            font-size: 0.8rem;
            color: var(--text-muted);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cassette-director {
            color: var(--crimson-neon);
            font-weight: 600;
            font-size: 0.78rem;
        }

        .cassette-actions {
            margin-top: 0.65rem;
            display: flex;
            gap: 0.5rem;
        }

        .btn-cassette-edit {
            flex: 1;
            text-align: center;
            font-size: 0.78rem;
            padding: 0.4rem 0.6rem;
            border-radius: var(--radius-xs);
            background: rgba(255, 42, 95, 0.12);
            color: #FDA4AF;
            border: 1px solid rgba(255, 42, 95, 0.3);
            text-decoration: none;
            font-weight: 700;
            transition: all 0.2s ease;
        }

        .btn-cassette-edit:hover {
            background: var(--crimson-neon);
            color: #FFFFFF;
        }

        /* ================= LAYER 5: BESPOKE STUDIO ARCHIVAL CONSOLE ================= */
        .archival-console-section {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        /* Layered Console Grid (Not generic boxes!) */
        .console-deck-grid {
            display: grid;
            grid-template-columns: 1.25fr 1fr 1fr;
            gap: 2rem;
        }

        .console-panel {
            background: var(--space-card);
            border: 1px solid var(--border-crimson);
            border-radius: var(--radius-lg);
            padding: 2.25rem;
            box-shadow: 0 15px 45px rgba(0, 0, 0, 0.7);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
        }

        .console-panel:hover {
            border-color: var(--crimson-neon);
            transform: translateY(-5px);
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.8), 0 0 35px var(--crimson-glow);
            background: var(--space-card-elevated);
        }

        /* Tactile Corner Rivet / Notch */
        .console-panel::before {
            content: '';
            position: absolute;
            top: 0; right: 0;
            width: 0; height: 0;
            border-style: solid;
            border-width: 0 24px 24px 0;
            border-color: transparent var(--crimson-neon) transparent transparent;
        }

        .panel-header-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            font-family: var(--font-mono);
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--crimson-neon);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.85rem;
        }

        .panel-heading {
            font-family: var(--font-title);
            font-size: 1.65rem;
            font-weight: 800;
            color: #FFFFFF;
            letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
        }

        .panel-description {
            color: var(--text-secondary);
            font-size: 0.92rem;
            line-height: 1.6;
            margin-bottom: 1.75rem;
        }

        /* Large Tactile Census Metric */
        .census-metric-box {
            display: flex;
            align-items: baseline;
            gap: 0.85rem;
            margin-bottom: 1.75rem;
            padding: 1.25rem;
            background: rgba(10, 2, 5, 0.75);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
        }

        .metric-big-num {
            font-family: var(--font-title);
            font-size: 3.5rem;
            font-weight: 900;
            color: #FFFFFF;
            line-height: 1;
            letter-spacing: -1.5px;
        }

        .metric-label-block {
            display: flex;
            flex-direction: column;
        }

        .metric-label-title {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--text-heading);
        }

        .metric-label-sub {
            font-family: var(--font-mono);
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        .panel-actions-dock {
            display: flex;
            gap: 0.85rem;
        }

        /* Taxonomy Pills Box in Genre Panel */
        .genre-pill-cloud {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1.75rem;
        }

        .genre-tag-pill {
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.35rem 0.85rem;
            border-radius: var(--radius-xs);
            background: rgba(255, 42, 95, 0.08);
            border: 1px solid var(--border-crimson);
            color: #FDA4AF;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .genre-tag-pill:hover {
            background: var(--crimson-neon);
            color: #FFFFFF;
            transform: translateY(-2px);
        }

        /* ================= LAYER 6: FLOATING STUDIO QUICK ACTION CONSOLE ================= */
        .floating-command-dock {
            position: fixed;
            bottom: 2rem;
            left: 50%;
            transform: translateX(-50%);
            z-index: 99;
            background: rgba(14, 3, 7, 0.9);
            backdrop-filter: var(--glass-sheet);
            -webkit-backdrop-filter: var(--glass-sheet);
            border: 1px solid var(--border-crimson-bright);
            padding: 0.6rem 1.25rem;
            border-radius: var(--radius-xl);
            display: flex;
            align-items: center;
            gap: 0.85rem;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.9), 0 0 35px var(--crimson-glow);
        }

        .dock-status-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-family: var(--font-mono);
            font-size: 0.75rem;
            font-weight: 700;
            color: #F43F5E;
            padding-right: 0.75rem;
            border-right: 1px solid var(--border-crimson);
        }

        .dock-link-btn {
            font-size: 0.82rem;
            font-weight: 700;
            padding: 0.45rem 1rem;
            border-radius: var(--radius-md);
            text-decoration: none;
            color: var(--text-heading);
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid var(--border-light);
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .dock-link-btn:hover {
            background: var(--crimson-vivid);
            color: #FFFFFF;
            border-color: var(--crimson-neon);
            transform: translateY(-2px);
        }

        /* ================= FOOTER: ARCHIVAL TELEMETRY ================= */
        .archival-footer {
            background: #040002;
            border-top: 1px solid var(--border-crimson);
            padding: 3rem 2rem;
            position: relative;
            z-index: 10;
        }

        .footer-inner {
            max-width: 1380px;
            margin: 0 auto;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            gap: 2rem;
        }

        .footer-lead {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-family: var(--font-title);
            font-size: 1.35rem;
            font-weight: 800;
            color: #FFFFFF;
        }

        .specs-cluster {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
            font-family: var(--font-mono);
            font-size: 0.72rem;
        }

        .spec-item {
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: var(--text-muted);
            padding: 4px 10px;
            border-radius: var(--radius-xs);
        }

        .footer-sub-text {
            width: 100%;
            text-align: center;
            font-size: 0.8rem;
            color: var(--text-faint);
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.04);
        }

        @media (max-width: 1080px) {
            .anamorphic-stage {
                grid-template-columns: 1fr;
                padding: 2.5rem;
            }
            .console-deck-grid {
                grid-template-columns: 1fr;
            }
            .nav-links-cluster {
                display: none;
            }
        }
    </style>
</head>
<body>

    <!-- LAYER 0: Cinema Lighting Effects -->
    <div class="ambient-projector-beam"></div>
    <div class="ambient-lens-flare"></div>
    <div class="cinematic-grid-bg"></div>

    <!-- LAYER 1: Apex Studio Navigation -->
    <header class="apex-bar">
        <div class="apex-container">
            <a href="index.jsp" class="studio-brand">
                <div class="camera-badge">📽️</div>
                <div class="brand-meta">
                    <div class="brand-name"><span>CineTrack</span> Archival</div>
                    <div class="brand-tag">35MM STUDIO CONSOLE // DCI 4K</div>
                </div>
            </a>

            <!-- Real-time Database Telemetry -->
            <div class="telemetry-pill">
                <div class="telemetry-dot"></div>
                <span>POSTGRESQL 18 &bull; JPA LIVE SYNC</span>
            </div>

            <!-- Navigation Links -->
            <nav>
                <ul class="nav-links-cluster">
                    <li><a href="index.jsp" class="nav-link-item active">Studio Deck</a></li>
                    <li><a href="viewMovies" class="nav-link-item">Film Vault</a></li>
                    <li><a href="viewDirectors" class="nav-link-item">Filmmakers</a></li>
                    <li><a href="viewActors" class="nav-link-item">Star Talent</a></li>
                    <li><a href="viewGenres" class="nav-link-item">Taxonomy</a></li>
                </ul>
            </nav>

            <div class="header-actions">
                <a href="displayMovie" class="btn-cinema btn-crimson-solid">
                    <span>+ Catalog Film</span>
                </a>
            </div>
        </div>
    </header>

    <!-- LAYER 2: 35mm Continuous Sprocket Film Strip Ribbon (Continuous Movement) -->
    <div class="filmstrip-ribbon">
        <div class="filmstrip-sprockets-top"></div>
        <div class="filmstrip-track">
            <div class="film-frame-chip"><span class="frame-number">FRAME 001</span> RRR &bull; S.S. Rajamouli <span class="frame-rating">★ 8.8</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 002</span> Avengers: Endgame &bull; Russo Brothers <span class="frame-rating">★ 8.4</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 003</span> Dangal &bull; Nitesh Tiwari <span class="frame-rating">★ 8.3</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 004</span> Baahubali 2: The Conclusion &bull; S.S. Rajamouli <span class="frame-rating">★ 8.2</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 005</span> 3 Idiots &bull; Rajkumar Hirani <span class="frame-rating">★ 8.4</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 006</span> Avengers: Infinity War &bull; 149 min <span class="frame-rating">★ 8.4</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 007</span> The Avengers &bull; Joss Whedon <span class="frame-rating">★ 8.0</span></div>
            <div class="film-frame-chip"><span class="frame-number">TELEMETRY</span> <%= movieCount %> Titles &bull; <%= directorCount %> Directors &bull; <%= actorCount %> Cast Members Active</div>
            
            <!-- Seamless Duplicate for Infinite Loop -->
            <div class="film-frame-chip"><span class="frame-number">FRAME 001</span> RRR &bull; S.S. Rajamouli <span class="frame-rating">★ 8.8</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 002</span> Avengers: Endgame &bull; Russo Brothers <span class="frame-rating">★ 8.4</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 003</span> Dangal &bull; Nitesh Tiwari <span class="frame-rating">★ 8.3</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 004</span> Baahubali 2: The Conclusion &bull; S.S. Rajamouli <span class="frame-rating">★ 8.2</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 005</span> 3 Idiots &bull; Rajkumar Hirani <span class="frame-rating">★ 8.4</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 006</span> Avengers: Infinity War &bull; 149 min <span class="frame-rating">★ 8.4</span></div>
            <div class="film-frame-chip"><span class="frame-number">FRAME 007</span> The Avengers &bull; Joss Whedon <span class="frame-rating">★ 8.0</span></div>
            <div class="film-frame-chip"><span class="frame-number">TELEMETRY</span> <%= movieCount %> Titles &bull; <%= directorCount %> Directors &bull; <%= actorCount %> Cast Members Active</div>
        </div>
        <div class="filmstrip-sprockets-bottom"></div>
    </div>

    <!-- MAIN WORKSPACE -->
    <main class="workspace-canvas">

        <!-- LAYER 3: 3D Anamorphic Hero Stage with Overlapping Poster Monolith -->
        <section class="anamorphic-stage">
            <div class="stage-intel">
                <div class="stage-technical-tag">
                    <span>⚡ ARCHIVE FOCUS</span> &bull; <span>ASPECT RATIO 2.39:1</span> &bull; <span><%= movieCount %> FILMS CATALOGED</span>
                </div>
                <h1 class="stage-headline">
                    Where Cinema<br>
                    Meets <em>Precision Curation.</em>
                </h1>
                <div class="stage-director-quote">
                    &ldquo;Cinema is not just about moving pictures; it is the deliberate preservation of world-building, director vision, and dramatic performances.&rdquo;
                    <cite>&mdash; S.S. Rajamouli &bull; Director of RRR &amp; Baahubali</cite>
                </div>
                <div class="stage-actions-row">
                    <a href="viewMovies" class="btn-cinema btn-crimson-solid">
                        <span>🎬 Access Film Vault (<%= movieCount %>)</span>
                    </a>
                    <a href="displayDirector" class="btn-cinema btn-ghost-acrylic">
                        <span>🎥 Register Visionary</span>
                    </a>
                    <a href="displayActor" class="btn-cinema btn-ghost-acrylic">
                        <span>🎭 Attach Talent</span>
                    </a>
                </div>
            </div>

            <!-- Overlapping Layered 3D Monolith -->
            <div class="stage-poster-plane">
                <div class="depth-poster-monolith">
                    <img src="https://upload.wikimedia.org/wikipedia/en/d/d7/RRR_Poster.jpg" 
                         alt="RRR" 
                         class="monolith-art"
                         onerror="this.onerror=null; this.src='https://m.media-amazon.com/images/M/MV5BODUwNDNjMTctODUxNy00ZTA2LWIyYTEtMDc5Y2E5NjgzZmFiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg';">
                    <div class="monolith-body">
                        <div>
                            <span class="monolith-flag">🏆 MASTER VAULT #01</span>
                            <h2 class="monolith-title">RRR</h2>
                            <div class="monolith-score">
                                <span>★ 8.8</span>
                                <span style="font-size: 0.75rem; color: var(--text-muted); font-weight: 500;">/ 10 IMDb</span>
                            </div>
                            <div class="monolith-specs">
                                <p><strong>Director:</strong> S.S. Rajamouli</p>
                                <p><strong>Runtime:</strong> 187 min &bull; 2022</p>
                                <p><strong>Language:</strong> Telugu / Multi</p>
                                <p><strong>Cast:</strong> N.T.R. Jr., Ram Charan</p>
                            </div>
                        </div>
                        <div style="margin-top: 1rem;">
                            <a href="editMovie?id=1" class="btn-cinema btn-crimson-solid" style="padding: 0.45rem 1rem; font-size: 0.8rem; width: 100%; justify-content: center;">
                                Inspect Record &rarr;
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- LAYER 4: Continuous Physical Media Cassette Reel (Posters Gliding Horizontally) -->
        <section class="cassette-section">
            <div class="console-header-block">
                <div>
                    <div class="console-label">
                        <span>🎞️</span> Vault Exhibition
                    </div>
                    <h2 class="console-title">Continuous 35mm Film Reel</h2>
                </div>
                <div class="console-subtitle">
                    Hover over any cassette to pause motion and inspect director records
                </div>
            </div>

            <div class="continuous-reel-viewport">
                <div class="continuous-reel-track">
                    
                    <!-- Cassette 1: RRR -->
                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://upload.wikimedia.org/wikipedia/en/d/d7/RRR_Poster.jpg" 
                                 alt="RRR" 
                                 class="cassette-img"
                                 onerror="this.onerror=null; this.src='https://m.media-amazon.com/images/M/MV5BODUwNDNjMTctODUxNy00ZTA2LWIyYTEtMDc5Y2E5NjgzZmFiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg';">
                            <span class="cassette-badge-score">★ 8.8</span>
                            <span class="cassette-badge-genre">Action</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">RRR</div>
                            <div class="cassette-sub">
                                <span>2022 &bull; 187m</span>
                                <span class="cassette-director">S.S. Rajamouli</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=1" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                    <!-- Cassette 2: Avengers Endgame -->
                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg" 
                                 alt="Avengers: Endgame" 
                                 class="cassette-img">
                            <span class="cassette-badge-score">★ 8.4</span>
                            <span class="cassette-badge-genre">Sci-Fi</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">Avengers: Endgame</div>
                            <div class="cassette-sub">
                                <span>2019 &bull; 181m</span>
                                <span class="cassette-director">Russo Bros</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=7" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                    <!-- Cassette 3: Dangal -->
                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://m.media-amazon.com/images/M/MV5BMTQ4MzQzMzM2Nl5BMl5BanBnXkFtZTgwMTQ1NzU3MDI@._V1_FMjpg_UX1000_.jpg" 
                                 alt="Dangal" 
                                 class="cassette-img">
                            <span class="cassette-badge-score">★ 8.3</span>
                            <span class="cassette-badge-genre">Biography</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">Dangal</div>
                            <div class="cassette-sub">
                                <span>2016 &bull; 161m</span>
                                <span class="cassette-director">Nitesh Tiwari</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=2" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                    <!-- Cassette 4: Baahubali 2 -->
                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://image.tmdb.org/t/p/w500/95ZDi8xnG7lApf88TL35GvGyq9k.jpg" 
                                 alt="Baahubali 2" 
                                 class="cassette-img">
                            <span class="cassette-badge-score">★ 8.2</span>
                            <span class="cassette-badge-genre">Epic</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">Baahubali 2</div>
                            <div class="cassette-sub">
                                <span>2017 &bull; 167m</span>
                                <span class="cassette-director">S.S. Rajamouli</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=4" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                    <!-- Cassette 5: 3 Idiots -->
                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://image.tmdb.org/t/p/w500/66A9MqXOyVFCssoloscw79z8Tew.jpg" 
                                 alt="3 Idiots" 
                                 class="cassette-img">
                            <span class="cassette-badge-score">★ 8.4</span>
                            <span class="cassette-badge-genre">Drama</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">3 Idiots</div>
                            <div class="cassette-sub">
                                <span>2009 &bull; 170m</span>
                                <span class="cassette-director">R. Hirani</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=3" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                    <!-- Cassette 6: Avengers Infinity War -->
                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg" 
                                 alt="Avengers: Infinity War" 
                                 class="cassette-img">
                            <span class="cassette-badge-score">★ 8.4</span>
                            <span class="cassette-badge-genre">Action</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">Infinity War</div>
                            <div class="cassette-sub">
                                <span>2018 &bull; 149m</span>
                                <span class="cassette-director">Russo Bros</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=6" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                    <!-- Cassette 7: Oppenheimer -->
                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg" 
                                 alt="Oppenheimer" 
                                 class="cassette-img">
                            <span class="cassette-badge-score">★ 8.9</span>
                            <span class="cassette-badge-genre">History</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">Oppenheimer</div>
                            <div class="cassette-sub">
                                <span>2023 &bull; 180m</span>
                                <span class="cassette-director">C. Nolan</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="displayMovie" class="btn-cassette-edit">+ Add to DB</a>
                            </div>
                        </div>
                    </div>

                    <!-- DUPLICATE SET FOR TRUE SEAMLESS 100% INFINITE MARQUEE -->
                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://upload.wikimedia.org/wikipedia/en/d/d7/RRR_Poster.jpg" 
                                 alt="RRR" 
                                 class="cassette-img"
                                 onerror="this.onerror=null; this.src='https://m.media-amazon.com/images/M/MV5BODUwNDNjMTctODUxNy00ZTA2LWIyYTEtMDc5Y2E5NjgzZmFiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg';">
                            <span class="cassette-badge-score">★ 8.8</span>
                            <span class="cassette-badge-genre">Action</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">RRR</div>
                            <div class="cassette-sub">
                                <span>2022 &bull; 187m</span>
                                <span class="cassette-director">S.S. Rajamouli</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=1" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg" 
                                 alt="Avengers: Endgame" 
                                 class="cassette-img">
                            <span class="cassette-badge-score">★ 8.4</span>
                            <span class="cassette-badge-genre">Sci-Fi</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">Avengers: Endgame</div>
                            <div class="cassette-sub">
                                <span>2019 &bull; 181m</span>
                                <span class="cassette-director">Russo Bros</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=7" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://m.media-amazon.com/images/M/MV5BMTQ4MzQzMzM2Nl5BMl5BanBnXkFtZTgwMTQ1NzU3MDI@._V1_FMjpg_UX1000_.jpg" 
                                 alt="Dangal" 
                                 class="cassette-img">
                            <span class="cassette-badge-score">★ 8.3</span>
                            <span class="cassette-badge-genre">Biography</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">Dangal</div>
                            <div class="cassette-sub">
                                <span>2016 &bull; 161m</span>
                                <span class="cassette-director">Nitesh Tiwari</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=2" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                    <div class="film-cassette-card">
                        <div class="cassette-media">
                            <img src="https://image.tmdb.org/t/p/w500/95ZDi8xnG7lApf88TL35GvGyq9k.jpg" 
                                 alt="Baahubali 2" 
                                 class="cassette-img">
                            <span class="cassette-badge-score">★ 8.2</span>
                            <span class="cassette-badge-genre">Epic</span>
                        </div>
                        <div class="cassette-info">
                            <div class="cassette-title">Baahubali 2</div>
                            <div class="cassette-sub">
                                <span>2017 &bull; 167m</span>
                                <span class="cassette-director">S.S. Rajamouli</span>
                            </div>
                            <div class="cassette-actions">
                                <a href="editMovie?id=4" class="btn-cassette-edit">Edit Entry</a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <!-- LAYER 5: Bespoke Archival Studio Console (Distinctive 3-Zone Control Deck) -->
        <section class="archival-console-section">
            <div class="console-header-block">
                <div>
                    <div class="console-label">
                        <span>🎛️</span> Studio Command
                    </div>
                    <h2 class="console-title">Archival Operation Deck</h2>
                </div>
                <div class="console-subtitle">
                    Live synchronized database telemetry across all 4 production vectors
                </div>
            </div>

            <div class="console-deck-grid">
                
                <!-- Zone A: The Production Vault (Movies) -->
                <div class="console-panel">
                    <div>
                        <div class="panel-header-badge">
                            <span>🎬</span> <span>DOMAIN 01 // PRODUCTION</span>
                        </div>
                        <h3 class="panel-heading">Master Film Vault</h3>
                        <p class="panel-description">
                            Archive feature releases with full runtime telemetry, critic ratings, languages, and associate them with directors and casts.
                        </p>
                        
                        <div class="census-metric-box">
                            <div class="metric-big-num"><%= movieCount %></div>
                            <div class="metric-label-block">
                                <span class="metric-label-title">Cataloged Titles</span>
                                <span class="metric-label-sub">Active in PostgreSQL</span>
                            </div>
                        </div>
                    </div>

                    <div class="panel-actions-dock">
                        <a href="displayMovie" class="btn-cinema btn-crimson-solid" style="flex: 1; justify-content: center;">+ New Film</a>
                        <a href="viewMovies" class="btn-cinema btn-ghost-acrylic" style="flex: 1; justify-content: center;">Inspect Vault</a>
                    </div>
                </div>

                <!-- Zone B: The Filmmaker Atelier (Directors) -->
                <div class="console-panel">
                    <div>
                        <div class="panel-header-badge">
                            <span>🎥</span> <span>DOMAIN 02 // VISIONARIES</span>
                        </div>
                        <h3 class="panel-heading">Director Atelier</h3>
                        <p class="panel-description">
                            Dossiers for master storytellers. Track nationality, filmography credits, and directorial project affiliations.
                        </p>

                        <div class="census-metric-box">
                            <div class="metric-big-num"><%= directorCount %></div>
                            <div class="metric-label-block">
                                <span class="metric-label-title">Visionary Directors</span>
                                <span class="metric-label-sub">Registered Filmmakers</span>
                            </div>
                        </div>
                    </div>

                    <div class="panel-actions-dock">
                        <a href="displayDirector" class="btn-cinema btn-crimson-solid" style="flex: 1; justify-content: center;">+ Add Director</a>
                        <a href="viewDirectors" class="btn-cinema btn-ghost-acrylic" style="flex: 1; justify-content: center;">Dossiers</a>
                    </div>
                </div>

                <!-- Zone C: The Cast & Taxonomy Matrix (Actors & Genres) -->
                <div class="console-panel">
                    <div>
                        <div class="panel-header-badge">
                            <span>🎭</span> <span>DOMAIN 03 &amp; 04 // TALENT &amp; GENRE</span>
                        </div>
                        <h3 class="panel-heading">Talent &amp; Taxonomy</h3>
                        <p class="panel-description">
                            Maintain star talent call sheets and cinema genre classifications to power your search algorithms.
                        </p>

                        <div class="genre-pill-cloud">
                            <span class="genre-tag-pill">⚡ Action (<%= genreCount %>)</span>
                            <span class="genre-tag-pill">🚀 Sci-Fi</span>
                            <span class="genre-tag-pill">🤼 Biography</span>
                            <span class="genre-tag-pill">👑 Epic Drama</span>
                            <span class="genre-tag-pill">🎭 <%= actorCount %> Actors Active</span>
                        </div>
                    </div>

                    <div class="panel-actions-dock">
                        <a href="displayActor" class="btn-cinema btn-crimson-solid" style="flex: 1; justify-content: center;">+ Add Talent</a>
                        <a href="viewGenres" class="btn-cinema btn-ghost-acrylic" style="flex: 1; justify-content: center;">Taxonomy</a>
                    </div>
                </div>

            </div>
        </section>

    </main>

    <!-- LAYER 6: Floating Studio Command Dock (Pinned at Bottom) -->
    <div class="floating-command-dock">
        <div class="dock-status-label">
            <span style="color: #22C55E;">●</span> CINETRACK 2.4
        </div>
        <a href="displayMovie" class="dock-link-btn">+ Film</a>
        <a href="displayDirector" class="dock-link-btn">+ Director</a>
        <a href="displayActor" class="dock-link-btn">+ Talent</a>
        <a href="displayGenre" class="dock-link-btn">+ Genre</a>
        <a href="index.jsp" class="dock-link-btn" style="background: rgba(255, 42, 95, 0.2); border-color: var(--crimson-neon); color: #FDA4AF;">⟳ Refresh</a>
    </div>

    <!-- Archival Footer -->
    <footer class="archival-footer">
        <div class="footer-inner">
            <div class="footer-lead">
                <span>📽️</span>
                <span>CineTrack Cinema Archival Studio</span>
            </div>

            <div class="specs-cluster">
                <span class="spec-item">ENGINE: SPRING MVC 6</span>
                <span class="spec-item">ORM: HIBERNATE JPA</span>
                <span class="spec-item">DATABASE: POSTGRESQL 18</span>
                <span class="spec-item">SERVER: APACHE TOMCAT 10.1</span>
                <span class="spec-item">ASPECT RATIO: 2.39:1 DCI</span>
            </div>
        </div>

        <div class="footer-sub-text">
            &copy; 2026 CineTrack Cinema Studio. Bespoke archival management engine with real-time JPA synchronization.
        </div>
    </footer>

</body>
</html>
