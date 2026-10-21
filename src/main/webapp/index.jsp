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
    <title>CineTrack &bull; Cinema Universe &amp; Curated Studio Deck</title>
    
    <!-- Modern Editorial & Cinema Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;700&family=Outfit:wght@300;400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&family=Space+Grotesk:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            /* Prestigious Cinema Wine & Velvet Noir Palette */
            --wine-void: #060103;
            --wine-charcoal: #0B0205;
            --wine-abyss: #120409;
            --wine-surface: rgba(22, 5, 11, 0.78);
            --wine-surface-elevated: rgba(32, 8, 17, 0.92);
            
            /* Wine & Velvet Crimson Spectrum */
            --wine-deep: #640D1F;
            --wine-core: #8A0E28;
            --wine-vivid: #B81438;
            --wine-ruby: #E51748;
            --wine-neon: #FF2459;
            --wine-glow: rgba(229, 23, 72, 0.42);
            --wine-subtle: rgba(184, 20, 56, 0.12);

            /* Cinema Warm Champagne & Amber Gold */
            --cinema-gold: #F59E0B;
            --cinema-amber: #FBBF24;
            --cinema-champagne: #FDE68A;
            --cinema-gold-glow: rgba(245, 158, 11, 0.35);

            /* Typography */
            --text-pure: #FFFFFF;
            --text-heading: #FFF1F4;
            --text-secondary: #D4B6BE;
            --text-muted: #8E6A74;
            --text-faint: #563B43;

            /* Precision Borders */
            --border-glass: rgba(255, 255, 255, 0.08);
            --border-wine: rgba(229, 23, 72, 0.32);
            --border-wine-bright: rgba(255, 36, 89, 0.65);
            --border-gold: rgba(245, 158, 11, 0.35);

            /* Font Systems */
            --font-display: 'Outfit', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
            --font-tech: 'Space Grotesk', sans-serif;
            --font-mono: 'JetBrains Mono', monospace;

            --glass-blur: blur(26px) saturate(190%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-body);
            background-color: var(--wine-void);
            color: var(--text-secondary);
            min-height: 100vh;
            overflow-x: hidden;
            display: flex;
            flex-direction: column;
            line-height: 1.6;
            position: relative;
        }

        /* ================= LAYER 0: CINEMA VELVET & WINE ATMOSPHERE ================= */
        .ambient-cinema-mesh {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background-image: 
                linear-gradient(rgba(229, 23, 72, 0.035) 1px, transparent 1px),
                linear-gradient(90deg, rgba(229, 23, 72, 0.035) 1px, transparent 1px);
            background-size: 55px 55px;
            pointer-events: none;
            z-index: 0;
        }

        .ambient-projector-wine {
            position: fixed;
            top: -150px;
            right: 12%;
            width: 820px;
            height: 950px;
            background: radial-gradient(ellipse at top, rgba(229, 23, 72, 0.22) 0%, rgba(100, 13, 31, 0.1) 45%, transparent 75%);
            filter: blur(85px);
            pointer-events: none;
            z-index: 0;
            transform: rotate(-18deg);
            animation: projectorBreathe 15s ease-in-out infinite alternate;
        }

        .ambient-flare-gold {
            position: fixed;
            bottom: 5%;
            left: -80px;
            width: 650px;
            height: 650px;
            background: radial-gradient(circle, rgba(245, 158, 11, 0.12) 0%, rgba(138, 14, 40, 0.05) 50%, transparent 70%);
            filter: blur(95px);
            pointer-events: none;
            z-index: 0;
            animation: flareDrift 18s ease-in-out infinite alternate;
        }

        @keyframes projectorBreathe {
            0% { transform: rotate(-18deg) translate(0, 0) scale(1); opacity: 0.85; }
            50% { transform: rotate(-13deg) translate(35px, 20px) scale(1.1); opacity: 1; }
            100% { transform: rotate(-22deg) translate(-25px, 15px) scale(0.95); opacity: 0.75; }
        }

        @keyframes flareDrift {
            0% { transform: scale(1); opacity: 0.7; }
            100% { transform: scale(1.2) translate(30px, -20px); opacity: 1; }
        }

        /* ================= LAYER 1: BESPOKE WINE GLASS APEX NAVBAR ================= */
        .apex-navbar {
            position: sticky;
            top: 0;
            z-index: 100;
            background: rgba(6, 1, 3, 0.86);
            backdrop-filter: var(--glass-blur);
            -webkit-backdrop-filter: var(--glass-blur);
            border-bottom: 1px solid var(--border-wine);
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.75);
        }

        .apex-inner {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0.85rem 2.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .brand-cluster {
            display: flex;
            align-items: center;
            gap: 1.1rem;
            text-decoration: none;
        }

        .brand-wine-badge {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            background: linear-gradient(135deg, #FF2459 0%, #8A0E28 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.45rem;
            color: #FFFFFF;
            box-shadow: 0 0 25px rgba(229, 23, 72, 0.5), inset 0 1px 2px rgba(255, 255, 255, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.25);
            position: relative;
        }

        .brand-wine-badge::after {
            content: '';
            position: absolute;
            top: 5px; right: 5px;
            width: 7px; height: 7px;
            border-radius: 50%;
            background: #22C55E;
            box-shadow: 0 0 8px #22C55E;
            animation: recordPulse 1.6s infinite;
        }

        @keyframes recordPulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.35; }
        }

        .brand-text-block {
            display: flex;
            flex-direction: column;
        }

        .brand-title {
            font-family: var(--font-display);
            font-size: 1.45rem;
            font-weight: 800;
            color: var(--text-pure);
            letter-spacing: -0.5px;
        }

        .brand-title span {
            background: linear-gradient(135deg, #FF2459 0%, #F59E0B 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .brand-sub-tag {
            font-family: var(--font-tech);
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 1.6px;
            color: var(--cinema-amber);
            font-weight: 600;
        }

        /* Clean Active Studio Status (Zero DB Jargon) */
        .live-status-pill {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            padding: 0.4rem 0.95rem;
            border-radius: 100px;
            background: rgba(229, 23, 72, 0.08);
            border: 1px solid var(--border-wine);
            font-family: var(--font-mono);
            font-size: 0.74rem;
            color: var(--text-heading);
            letter-spacing: 0.5px;
            box-shadow: 0 0 15px rgba(229, 23, 72, 0.15);
        }

        .live-status-dot {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: var(--wine-ruby);
            box-shadow: 0 0 10px var(--wine-ruby);
            animation: pulseRuby 1.8s infinite;
        }

        @keyframes pulseRuby {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.4; transform: scale(0.85); }
        }

        /* Nav Deck */
        .nav-links-deck {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            list-style: none;
        }

        .nav-link {
            text-decoration: none;
            color: var(--text-secondary);
            font-family: var(--font-tech);
            font-size: 0.88rem;
            font-weight: 500;
            padding: 0.45rem 0.95rem;
            border-radius: 8px;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .nav-link:hover {
            color: var(--text-pure);
            background: rgba(255, 255, 255, 0.06);
            box-shadow: 0 0 12px rgba(229, 23, 72, 0.15);
        }

        .nav-link.active {
            color: #FFFFFF;
            background: rgba(229, 23, 72, 0.16);
            border: 1px solid var(--border-wine);
            box-shadow: 0 0 15px rgba(229, 23, 72, 0.25);
        }

        /* Action Button */
        .btn-wine-primary {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.55rem 1.25rem;
            border-radius: 10px;
            font-family: var(--font-tech);
            font-size: 0.85rem;
            font-weight: 700;
            text-decoration: none;
            background: linear-gradient(135deg, #FF2459 0%, #A81232 100%);
            color: #FFFFFF;
            border: 1px solid rgba(255, 255, 255, 0.25);
            box-shadow: 0 0 20px rgba(229, 23, 72, 0.45);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .btn-wine-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 30px rgba(229, 23, 72, 0.7);
        }

        /* ================= LAYER 2: WINE VELVET MARQUEE ================= */
        .cinema-marquee-ribbon {
            background: rgba(18, 4, 9, 0.82);
            border-top: 1px solid rgba(229, 23, 72, 0.18);
            border-bottom: 1px solid rgba(229, 23, 72, 0.18);
            overflow: hidden;
            position: relative;
            z-index: 10;
            backdrop-filter: blur(12px);
        }

        .cinema-marquee-track {
            display: flex;
            gap: 2rem;
            width: max-content;
            padding: 0.55rem 0;
            animation: marqueeSlide 40s linear infinite;
        }

        .marquee-chip {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            padding: 0.25rem 0.85rem;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.035);
            border: 1px solid rgba(255, 255, 255, 0.06);
            font-family: var(--font-mono);
            font-size: 0.75rem;
            color: #E2E8F0;
            white-space: nowrap;
        }

        .marquee-chip-tag {
            color: var(--wine-ruby);
            font-weight: 700;
        }

        .marquee-chip-gold {
            color: var(--cinema-gold);
            font-weight: 700;
        }

        @keyframes marqueeSlide {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        /* ================= LAYER 3: 3D HERO STAGE WITH ROTATING CROSS-STACK ================= */
        .hero-stage-section {
            max-width: 1400px;
            margin: 2.5rem auto 3rem auto;
            padding: 0 2rem;
            position: relative;
            z-index: 10;
        }

        .hero-stage-grid {
            display: grid;
            grid-template-columns: 1.05fr 1fr;
            gap: 3.5rem;
            align-items: center;
            min-height: 590px;
        }

        .hero-intel-block {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
            position: relative;
            z-index: 2;
        }

        .hero-spotlight-tag {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            width: fit-content;
            padding: 0.4rem 1rem;
            border-radius: 100px;
            background: linear-gradient(90deg, rgba(229, 23, 72, 0.16), rgba(245, 158, 11, 0.1));
            border: 1px solid var(--border-wine);
            font-family: var(--font-tech);
            font-size: 0.78rem;
            font-weight: 600;
            color: var(--text-heading);
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        .hero-spotlight-tag span.highlight {
            color: var(--cinema-gold);
            font-weight: 700;
        }

        .hero-headline {
            font-family: var(--font-display);
            font-size: 3.4rem;
            font-weight: 800;
            color: var(--text-pure);
            line-height: 1.1;
            letter-spacing: -1.5px;
        }

        .hero-headline em {
            font-style: normal;
            background: linear-gradient(135deg, #FF2459 0%, #F59E0B 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 35px rgba(229, 23, 72, 0.35);
        }

        .hero-director-quote {
            font-family: var(--font-body);
            font-size: 1.05rem;
            color: var(--text-secondary);
            line-height: 1.6;
            padding: 1.1rem 1.4rem;
            border-radius: 14px;
            background: rgba(22, 5, 11, 0.7);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-left: 4px solid var(--wine-ruby);
            backdrop-filter: blur(14px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
            transition: all 0.35s ease;
        }

        .hero-director-quote cite {
            display: block;
            margin-top: 0.5rem;
            font-style: normal;
            font-family: var(--font-tech);
            font-size: 0.85rem;
            color: var(--cinema-gold);
            font-weight: 600;
        }

        /* Interactive Film Tabs */
        .interactive-switcher-pills {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-top: 0.3rem;
        }

        .pill-switch-btn {
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.09);
            color: var(--text-secondary);
            padding: 0.4rem 0.85rem;
            border-radius: 8px;
            font-family: var(--font-tech);
            font-size: 0.78rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.25s ease;
        }

        .pill-switch-btn:hover {
            color: #FFFFFF;
            background: rgba(229, 23, 72, 0.15);
            border-color: var(--border-wine);
            transform: translateY(-1px);
        }

        .pill-switch-btn.active {
            color: #FFFFFF;
            background: linear-gradient(135deg, rgba(229, 23, 72, 0.35), rgba(138, 14, 40, 0.5));
            border-color: var(--wine-ruby);
            box-shadow: 0 0 18px rgba(229, 23, 72, 0.4);
        }

        .hero-cta-group {
            display: flex;
            gap: 1rem;
            margin-top: 0.8rem;
        }

        .btn-hero-solid {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.6rem;
            padding: 0.85rem 1.6rem;
            border-radius: 12px;
            background: linear-gradient(135deg, #FF2459 0%, #A81232 100%);
            color: #FFFFFF;
            font-family: var(--font-tech);
            font-size: 0.95rem;
            font-weight: 700;
            text-decoration: none;
            box-shadow: 0 0 25px rgba(229, 23, 72, 0.45);
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
            cursor: pointer;
        }

        .btn-hero-solid:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 35px rgba(229, 23, 72, 0.7);
        }

        .btn-hero-acrylic {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.6rem;
            padding: 0.85rem 1.4rem;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.05);
            color: #FFFFFF;
            font-family: var(--font-tech);
            font-size: 0.95rem;
            font-weight: 600;
            text-decoration: none;
            border: 1px solid var(--border-wine);
            backdrop-filter: blur(12px);
            transition: all 0.3s ease;
        }

        .btn-hero-acrylic:hover {
            background: rgba(229, 23, 72, 0.15);
            border-color: var(--wine-ruby);
            box-shadow: 0 0 20px rgba(229, 23, 72, 0.3);
            transform: translateY(-2px);
        }

        /* ================= 3D ROTATING CROSS-STACKED ARENA ================= */
        .cross-stacked-arena {
            position: relative;
            width: 100%;
            height: 530px;
            perspective: 1400px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* 3D Stack Stage */
        .poster-stack-3d {
            position: relative;
            width: 320px;
            height: 470px;
            transform-style: preserve-3d;
        }

        /* Individual Stack Cards (Crystal Clear, Zero Blur) */
        .stack-card {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 20px;
            overflow: hidden;
            background: #18050C;
            border: 1px solid rgba(255, 255, 255, 0.14);
            box-shadow: 0 20px 45px rgba(0, 0, 0, 0.75);
            cursor: pointer;
            transition: transform 0.7s cubic-bezier(0.25, 1, 0.45, 1),
                        opacity 0.7s cubic-bezier(0.25, 1, 0.45, 1),
                        box-shadow 0.7s cubic-bezier(0.25, 1, 0.45, 1),
                        border-color 0.7s cubic-bezier(0.25, 1, 0.45, 1);
            transform-style: preserve-3d;
            user-select: none;
            /* Crisp image display, NO CSS BLUR */
            image-rendering: auto;
            -webkit-backface-visibility: hidden;
            backface-visibility: hidden;
        }

        .stack-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            image-rendering: -webkit-optimize-contrast;
            transition: transform 0.5s ease;
        }

        .stack-card:hover img {
            transform: scale(1.03);
        }

        .stack-card-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(10, 2, 5, 0.96) 0%, rgba(10, 2, 5, 0.35) 50%, transparent 100%);
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 1.5rem;
            color: #FFFFFF;
        }

        .stack-card-tag {
            font-family: var(--font-tech);
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: var(--cinema-gold);
            margin-bottom: 0.25rem;
        }

        .stack-card-title {
            font-family: var(--font-display);
            font-size: 1.55rem;
            font-weight: 800;
            line-height: 1.1;
            margin-bottom: 0.4rem;
            color: var(--text-heading);
        }

        .stack-card-score {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            font-family: var(--font-tech);
            font-size: 0.88rem;
            font-weight: 700;
            color: var(--cinema-amber);
        }

        /* DYNAMIC 3D ROTATION POSITIONS */
        /* Center Active Card (Elevated Front) */
        .stack-card.pos-center {
            z-index: 10;
            transform: translateX(0px) translateY(0px) translateZ(80px) rotateY(0deg) scale(1);
            border: 2px solid var(--wine-ruby);
            box-shadow: 0 25px 65px rgba(229, 23, 72, 0.4), 0 0 35px rgba(245, 158, 11, 0.25);
            opacity: 1;
            pointer-events: auto;
        }

        /* Left Cross Card (Tilted Inwards) */
        .stack-card.pos-left {
            z-index: 6;
            transform: translateX(-140px) translateY(15px) translateZ(-30px) rotateY(22deg) rotateZ(-3deg) scale(0.91);
            border-color: var(--border-wine);
            box-shadow: 0 20px 45px rgba(0, 0, 0, 0.65);
            opacity: 0.92;
            pointer-events: auto;
        }

        .stack-card.pos-left:hover {
            transform: translateX(-120px) translateY(5px) translateZ(10px) rotateY(12deg) scale(0.95);
            opacity: 1;
            box-shadow: 0 20px 50px rgba(229, 23, 72, 0.45);
        }

        /* Right Cross Card (Tilted Inwards) */
        .stack-card.pos-right {
            z-index: 6;
            transform: translateX(140px) translateY(15px) translateZ(-30px) rotateY(-22deg) rotateZ(3deg) scale(0.91);
            border-color: var(--border-wine);
            box-shadow: 0 20px 45px rgba(0, 0, 0, 0.65);
            opacity: 0.92;
            pointer-events: auto;
        }

        .stack-card.pos-right:hover {
            transform: translateX(120px) translateY(5px) translateZ(10px) rotateY(-12deg) scale(0.95);
            opacity: 1;
            box-shadow: 0 20px 50px rgba(229, 23, 72, 0.45);
        }

        /* Far Left Card */
        .stack-card.pos-far-left {
            z-index: 2;
            transform: translateX(-240px) translateY(30px) translateZ(-110px) rotateY(32deg) scale(0.81);
            opacity: 0.65;
            pointer-events: auto;
        }

        /* Far Right Card */
        .stack-card.pos-far-right {
            z-index: 2;
            transform: translateX(240px) translateY(30px) translateZ(-110px) rotateY(-32deg) scale(0.81);
            opacity: 0.65;
            pointer-events: auto;
        }

        /* Hidden/Back Card */
        .stack-card.pos-back {
            z-index: 1;
            transform: translateY(40px) translateZ(-200px) scale(0.7);
            opacity: 0;
            pointer-events: none;
        }

        /* Navigation Arrows on 3D Stack (Dedicated outer clearance) */
        .stack-nav-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: rgba(25, 6, 12, 0.92);
            border: 1px solid var(--border-wine);
            color: #FFFFFF;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 30;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.8);
            transition: all 0.25s ease;
        }

        .stack-nav-btn:hover {
            background: var(--wine-ruby);
            border-color: #FFFFFF;
            box-shadow: 0 0 20px rgba(229, 23, 72, 0.7);
            transform: translateY(-50%) scale(1.1);
        }

        .stack-nav-prev { left: -52px; }
        .stack-nav-next { right: -52px; }

        /* ================= DYNAMIC FLOATING OBJECTS (Wine & Gold) ================= */
        /* 1. Floating Gold Rating Capsule (Top-Right) */
        .floating-obj-score {
            position: absolute;
            top: 20px;
            right: -25px;
            z-index: 20;
            background: rgba(25, 7, 14, 0.88);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-gold);
            padding: 0.6rem 1.15rem;
            border-radius: 100px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.6), 0 0 20px rgba(245, 158, 11, 0.25);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-family: var(--font-tech);
            font-size: 0.85rem;
            color: #FFFFFF;
            animation: floatSlow 5.5s ease-in-out infinite alternate;
        }

        .score-gold-star {
            color: var(--cinema-gold);
            font-size: 1.15rem;
            filter: drop-shadow(0 0 8px var(--cinema-gold));
        }

        /* 2. Floating VIP Premiere Pass (Bottom-Left) */
        .floating-obj-ticket {
            position: absolute;
            bottom: 20px;
            left: -35px;
            z-index: 20;
            background: linear-gradient(135deg, rgba(229, 23, 72, 0.25), rgba(138, 14, 40, 0.35));
            backdrop-filter: blur(18px);
            border: 1px solid var(--border-wine);
            padding: 0.7rem 1.25rem;
            border-radius: 14px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.7), 0 0 25px rgba(229, 23, 72, 0.35);
            display: flex;
            flex-direction: column;
            gap: 0.2rem;
            animation: floatReverse 6.5s ease-in-out infinite alternate;
        }

        .ticket-code {
            font-family: var(--font-mono);
            font-size: 0.65rem;
            color: var(--cinema-amber);
            letter-spacing: 1.5px;
            font-weight: 700;
        }

        .ticket-title {
            font-family: var(--font-display);
            font-size: 0.9rem;
            font-weight: 700;
            color: #FFFFFF;
        }

        /* 3. Floating Dolby Atmos Audio Badge (Relocated to Bottom-Right to completely clear arrows) */
        .floating-obj-atmos {
            position: absolute;
            bottom: 25px;
            right: -25px;
            z-index: 20;
            background: rgba(22, 5, 12, 0.88);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-wine);
            padding: 0.5rem 0.95rem;
            border-radius: 12px;
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.6), 0 0 20px rgba(229, 23, 72, 0.2);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-family: var(--font-mono);
            font-size: 0.74rem;
            color: var(--wine-ruby);
            animation: floatDrift 7.5s ease-in-out infinite alternate;
        }

        .atmos-bars {
            display: flex;
            gap: 2.5px;
            align-items: flex-end;
            height: 14px;
        }

        .atmos-bar {
            width: 2.5px;
            background: var(--wine-ruby);
            border-radius: 2px;
            animation: barJump 1.2s ease-in-out infinite alternate;
        }

        .atmos-bar:nth-child(2) { animation-delay: 0.2s; height: 12px; }
        .atmos-bar:nth-child(3) { animation-delay: 0.4s; height: 8px; }
        .atmos-bar:nth-child(4) { animation-delay: 0.1s; height: 14px; }

        @keyframes barJump {
            0% { height: 4px; }
            100% { height: 14px; }
        }

        /* 4. Ambient Rotating Ring */
        .floating-holo-ring {
            position: absolute;
            width: 490px;
            height: 490px;
            border-radius: 50%;
            border: 1px dashed rgba(229, 23, 72, 0.22);
            pointer-events: none;
            z-index: 1;
            transform: rotateX(65deg);
            animation: ringSpin 32s linear infinite;
        }

        @keyframes ringSpin {
            0% { transform: rotateX(65deg) rotateZ(0deg); }
            100% { transform: rotateX(65deg) rotateZ(360deg); }
        }

        /* Floating Keyframes */
        @keyframes floatSlow {
            0% { transform: translateY(0px) rotate(0deg); }
            100% { transform: translateY(-18px) rotate(2deg); }
        }

        @keyframes floatReverse {
            0% { transform: translateY(0px) rotate(0deg); }
            100% { transform: translateY(16px) rotate(-2deg); }
        }

        @keyframes floatDrift {
            0% { transform: translateY(0px) translateX(0px); }
            50% { transform: translateY(-12px) translateX(8px); }
            100% { transform: translateY(8px) translateX(-6px); }
        }

        /* ================= LAYER 4: STREAMING CORRIDOR WITH VELOCITY CONTROLS ================= */
        .streaming-corridor-section {
            max-width: 1400px;
            margin: 1.5rem auto 4.5rem auto;
            padding: 0 2rem;
            position: relative;
            z-index: 10;
        }

        .section-header-hud {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .hud-title-cluster {
            display: flex;
            flex-direction: column;
            gap: 0.2rem;
        }

        .hud-label {
            font-family: var(--font-tech);
            font-size: 0.75rem;
            color: var(--cinema-gold);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .hud-title {
            font-family: var(--font-display);
            font-size: 1.85rem;
            font-weight: 800;
            color: var(--text-pure);
        }

        /* Velocity HUD Bar */
        .velocity-hud-bar {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            background: rgba(22, 5, 11, 0.7);
            border: 1px solid var(--border-wine);
            padding: 0.35rem 0.6rem;
            border-radius: 10px;
            backdrop-filter: blur(12px);
        }

        .btn-speed-toggle {
            background: transparent;
            border: 1px solid transparent;
            color: var(--text-secondary);
            padding: 0.35rem 0.75rem;
            border-radius: 6px;
            font-family: var(--font-mono);
            font-size: 0.72rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-speed-toggle:hover {
            color: #FFFFFF;
            background: rgba(255, 255, 255, 0.08);
        }

        .btn-speed-toggle.active {
            color: #FFFFFF;
            background: var(--wine-ruby);
            border-color: rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 12px var(--wine-ruby);
        }

        /* Stream Viewport */
        .streaming-viewport {
            overflow: hidden;
            border-radius: 18px;
            border: 1px solid var(--border-wine);
            background: rgba(14, 3, 7, 0.5);
            backdrop-filter: blur(16px);
            padding: 1.2rem 0;
            position: relative;
        }

        .streaming-track {
            display: flex;
            gap: 1.25rem;
            width: max-content;
            animation: streamGlide 35s linear infinite;
        }

        .stream-movie-card {
            width: 215px;
            flex-shrink: 0;
            border-radius: 14px;
            overflow: hidden;
            background: rgba(26, 7, 14, 0.85);
            border: 1px solid rgba(255, 255, 255, 0.09);
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
        }

        .stream-movie-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--wine-ruby);
            box-shadow: 0 15px 35px rgba(229, 23, 72, 0.35);
        }

        .stream-movie-poster {
            width: 100%;
            height: 275px;
            position: relative;
            overflow: hidden;
        }

        .stream-movie-poster img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            image-rendering: -webkit-optimize-contrast;
            transition: transform 0.4s ease;
        }

        .stream-movie-card:hover .stream-movie-poster img {
            transform: scale(1.06);
        }

        .stream-score-tag {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(10, 2, 5, 0.85);
            backdrop-filter: blur(8px);
            border: 1px solid var(--border-gold);
            color: var(--cinema-amber);
            font-family: var(--font-tech);
            font-size: 0.72rem;
            font-weight: 700;
            padding: 0.2rem 0.55rem;
            border-radius: 6px;
        }

        .stream-movie-meta {
            padding: 0.9rem;
        }

        .stream-movie-title {
            font-family: var(--font-display);
            font-size: 0.98rem;
            font-weight: 700;
            color: var(--text-pure);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .stream-movie-sub {
            font-family: var(--font-tech);
            font-size: 0.75rem;
            color: var(--text-secondary);
            margin-top: 0.2rem;
            display: flex;
            justify-content: space-between;
        }

        @keyframes streamGlide {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        /* ================= LAYER 5: BESPOKE WINE COMMAND MODULES ================= */
        .futuristic-command-section {
            max-width: 1400px;
            margin: 0 auto 5rem auto;
            padding: 0 2rem;
            position: relative;
            z-index: 10;
        }

        .command-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.8rem;
        }

        .command-module-card {
            border-radius: 20px;
            background: rgba(22, 5, 11, 0.75);
            border: 1px solid var(--border-wine);
            backdrop-filter: blur(20px);
            padding: 2.2rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
            transition: all 0.35s cubic-bezier(0.2, 0.8, 0.2, 1);
        }

        .command-module-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--module-accent, var(--wine-ruby)), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .command-module-card:hover {
            transform: translateY(-6px);
            border-color: var(--wine-ruby);
            box-shadow: 0 20px 45px rgba(0, 0, 0, 0.65), 0 0 25px rgba(229, 23, 72, 0.25);
        }

        .command-module-card:hover::before {
            opacity: 1;
        }

        .module-badge {
            font-family: var(--font-tech);
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--module-accent, var(--wine-ruby));
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.8rem;
        }

        .module-heading {
            font-family: var(--font-display);
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--text-pure);
            margin-bottom: 0.5rem;
        }

        .module-summary {
            font-size: 0.9rem;
            color: var(--text-secondary);
            line-height: 1.5;
            margin-bottom: 1.5rem;
        }

        .module-metric-display {
            display: flex;
            align-items: center;
            gap: 1.2rem;
            padding: 1.1rem;
            border-radius: 14px;
            background: rgba(255, 255, 255, 0.035);
            border: 1px solid rgba(255, 255, 255, 0.06);
            margin-bottom: 1.5rem;
        }

        .metric-digits {
            font-family: var(--font-display);
            font-size: 2.4rem;
            font-weight: 900;
            color: var(--text-pure);
            line-height: 1;
        }

        .metric-info {
            display: flex;
            flex-direction: column;
        }

        .metric-title {
            font-family: var(--font-tech);
            font-size: 0.85rem;
            font-weight: 700;
            color: #FFFFFF;
        }

        .metric-sub {
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        .module-button-row {
            display: flex;
            gap: 0.8rem;
        }

        .btn-module-action {
            flex: 1;
            padding: 0.7rem 1rem;
            border-radius: 10px;
            font-family: var(--font-tech);
            font-size: 0.85rem;
            font-weight: 700;
            text-align: center;
            text-decoration: none;
            transition: all 0.25s ease;
        }

        .btn-module-glow {
            background: var(--module-accent, var(--wine-ruby));
            color: #FFFFFF;
            box-shadow: 0 0 15px rgba(229, 23, 72, 0.35);
        }

        .btn-module-glow:hover {
            box-shadow: 0 0 25px rgba(229, 23, 72, 0.65);
            transform: translateY(-2px);
        }

        .btn-module-ghost {
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #FFFFFF;
        }

        .btn-module-ghost:hover {
            background: rgba(229, 23, 72, 0.15);
            border-color: var(--wine-ruby);
            transform: translateY(-2px);
        }

        /* Taxonomy Pill Cloud */
        .taxonomy-pill-cloud {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
        }

        .taxo-pill {
            padding: 0.4rem 0.85rem;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--border-wine);
            font-family: var(--font-tech);
            font-size: 0.76rem;
            color: #E2E8F0;
            font-weight: 600;
        }

        /* ================= LAYER 6: FLOATING STUDIO DOCK ================= */
        .floating-studio-dock {
            position: fixed;
            bottom: 1.5rem;
            left: 50%;
            transform: translateX(-50%);
            z-index: 100;
            background: rgba(18, 4, 9, 0.9);
            backdrop-filter: blur(25px) saturate(200%);
            border: 1px solid var(--border-wine);
            padding: 0.55rem 0.85rem;
            border-radius: 100px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.85), 0 0 30px rgba(229, 23, 72, 0.25);
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .dock-brand-tag {
            font-family: var(--font-tech);
            font-size: 0.75rem;
            font-weight: 700;
            color: #FFFFFF;
            padding: 0.35rem 0.8rem;
            border-right: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .dock-action-btn {
            font-family: var(--font-tech);
            font-size: 0.78rem;
            font-weight: 600;
            color: #E2E8F0;
            text-decoration: none;
            padding: 0.4rem 0.9rem;
            border-radius: 100px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.08);
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .dock-action-btn:hover {
            color: #FFFFFF;
            background: rgba(229, 23, 72, 0.2);
            border-color: var(--wine-ruby);
            box-shadow: 0 0 15px rgba(229, 23, 72, 0.35);
            transform: translateY(-1px);
        }

        /* ================= LAYER 7: PRESTIGE CINEMA FOOTER ================= */
        .futuristic-footer {
            margin-top: auto;
            background: rgba(6, 1, 3, 0.96);
            border-top: 1px solid rgba(229, 23, 72, 0.15);
            padding: 2.5rem 2rem 5.5rem 2rem;
            position: relative;
            z-index: 10;
        }

        .footer-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .footer-top-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .footer-brand {
            font-family: var(--font-display);
            font-size: 1.25rem;
            font-weight: 800;
            color: #FFFFFF;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .cinema-spec-pills {
            display: flex;
            flex-wrap: wrap;
            gap: 0.6rem;
        }

        .spec-badge {
            font-family: var(--font-mono);
            font-size: 0.72rem;
            color: var(--text-secondary);
            padding: 0.3rem 0.75rem;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.035);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }

        .footer-bottom-text {
            font-size: 0.8rem;
            color: var(--text-muted);
            border-top: 1px solid rgba(255, 255, 255, 0.04);
            padding-top: 1.2rem;
            text-align: center;
        }

        @media (max-width: 1100px) {
            .hero-stage-grid {
                grid-template-columns: 1fr;
                gap: 3rem;
            }
            .command-grid {
                grid-template-columns: 1fr;
            }
            .nav-links-deck {
                display: none;
            }
            .floating-studio-dock {
                width: 90%;
                justify-content: space-around;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>

    <!-- LAYER 0: Cinema Velvet Atmosphere -->
    <div class="ambient-cinema-mesh"></div>
    <div class="ambient-projector-wine"></div>
    <div class="ambient-flare-gold"></div>

    <!-- LAYER 1: Apex Wine Glass Navigation Bar -->
    <header class="apex-navbar">
        <div class="apex-inner">
            <a href="index.jsp" class="brand-cluster">
                <div class="brand-wine-badge">📽️</div>
                <div class="brand-text-block">
                    <div class="brand-title"><span>CineTrack</span> Cinema</div>
                    <div class="brand-sub-tag">CURATED STUDIO &bull; PREMIERE EDITION</div>
                </div>
            </a>

            <!-- Clean Status Indicator (Zero Technical DB Jargon) -->
            <div class="live-status-pill">
                <div class="live-status-dot"></div>
                <span>PREMIERE CINEMA VAULT &bull; ACTIVE</span>
            </div>

            <!-- Navigation Links -->
            <nav>
                <ul class="nav-links-deck">
                    <li><a href="index.jsp" class="nav-link active">Studio Deck</a></li>
                    <li><a href="viewMovies" class="nav-link">Film Vault</a></li>
                    <li><a href="viewDirectors" class="nav-link">Filmmakers</a></li>
                    <li><a href="viewActors" class="nav-link">Star Talent</a></li>
                    <li><a href="viewGenres" class="nav-link">Categories</a></li>
                </ul>
            </nav>

            <a href="displayMovie" class="btn-wine-primary">
                <span>+ Catalog Film</span>
            </a>
        </div>
    </header>

    <!-- LAYER 2: Velvet Ribbon Marquee (Infinite Motion) -->
    <div class="cinema-marquee-ribbon">
        <div class="cinema-marquee-track">
            <div class="marquee-chip"><span class="marquee-chip-tag">SPOTLIGHT</span> RRR &bull; S.S. Rajamouli <span class="marquee-chip-gold">★ 8.8</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">GLOBAL HIT</span> Avengers: Endgame &bull; Russo Brothers <span class="marquee-chip-gold">★ 8.4</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">ALL-TIME</span> Dangal &bull; Nitesh Tiwari <span class="marquee-chip-gold">★ 8.3</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">EPIC</span> Baahubali 2: The Conclusion &bull; S.S. Rajamouli <span class="marquee-chip-gold">★ 8.2</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">CULT CLASSIC</span> 3 Idiots &bull; Rajkumar Hirani <span class="marquee-chip-gold">★ 8.4</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">MASTERPIECE</span> Oppenheimer &bull; Christopher Nolan <span class="marquee-chip-gold">★ 8.9</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">STUDIO VAULT</span> <%= movieCount %> Masterpieces Cataloged &bull; <%= directorCount %> Visionary Directors &bull; <%= actorCount %> Headline Talents</div>
            
            <!-- Seamless Duplicate for Infinite Marquee Glide -->
            <div class="marquee-chip"><span class="marquee-chip-tag">SPOTLIGHT</span> RRR &bull; S.S. Rajamouli <span class="marquee-chip-gold">★ 8.8</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">GLOBAL HIT</span> Avengers: Endgame &bull; Russo Brothers <span class="marquee-chip-gold">★ 8.4</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">ALL-TIME</span> Dangal &bull; Nitesh Tiwari <span class="marquee-chip-gold">★ 8.3</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">EPIC</span> Baahubali 2: The Conclusion &bull; S.S. Rajamouli <span class="marquee-chip-gold">★ 8.2</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">CULT CLASSIC</span> 3 Idiots &bull; Rajkumar Hirani <span class="marquee-chip-gold">★ 8.4</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">MASTERPIECE</span> Oppenheimer &bull; Christopher Nolan <span class="marquee-chip-gold">★ 8.9</span></div>
            <div class="marquee-chip"><span class="marquee-chip-tag">STUDIO VAULT</span> <%= movieCount %> Masterpieces Cataloged &bull; <%= directorCount %> Visionary Directors &bull; <%= actorCount %> Headline Talents</div>
        </div>
    </div>

    <!-- MAIN WORKSPACE -->
    <main>

        <!-- LAYER 3: 3D HERO STAGE WITH ROTATING CROSS-STACKED POSTERS -->
        <section class="hero-stage-section">
            <div class="hero-stage-grid">
                
                <!-- Left Intel Block -->
                <div class="hero-intel-block">
                    <div class="hero-spotlight-tag">
                        <span>⚡ FEATURED SPOTLIGHT</span> &bull; <span class="highlight">CURATED MASTERPIECES</span> &bull; <span><%= movieCount %> TITLES</span>
                    </div>

                    <h1 class="hero-headline">
                        Where Cinema<br>
                        Meets <em>Precision Curation.</em>
                    </h1>

                    <div class="hero-director-quote" id="activeQuote">
                        &ldquo;Cinema is not just about moving pictures; it is the deliberate preservation of world-building, director vision, and dramatic performances.&rdquo;
                        <cite id="activeCite">&mdash; S.S. Rajamouli &bull; Director of RRR &amp; Baahubali</cite>
                    </div>

                    <!-- Interactive Film Tabs -->
                    <div class="interactive-switcher-pills">
                        <button type="button" class="pill-switch-btn active" onclick="rotateTo(0)">1. RRR</button>
                        <button type="button" class="pill-switch-btn" onclick="rotateTo(1)">2. Avengers: Endgame</button>
                        <button type="button" class="pill-switch-btn" onclick="rotateTo(2)">3. Oppenheimer</button>
                        <button type="button" class="pill-switch-btn" onclick="rotateTo(3)">4. Dangal</button>
                        <button type="button" class="pill-switch-btn" onclick="rotateTo(4)">5. Baahubali 2</button>
                        <button type="button" class="pill-switch-btn" onclick="rotateTo(5)">6. 3 Idiots</button>
                    </div>

                    <div class="hero-cta-group">
                        <a href="viewMovies" class="btn-hero-solid">
                            <span>🎬 Explore Library (<%= movieCount %>)</span>
                        </a>
                        <a href="displayMovie" class="btn-hero-acrylic">
                            <span>+ Add New Feature</span>
                        </a>
                    </div>
                </div>

                <!-- Right Arena: 3D ROTATING CROSS-STACK & DYNAMIC FLOATING OBJECTS -->
                <div class="cross-stacked-arena">
                    
                    <!-- Ambient 3D Rotating Ring -->
                    <div class="floating-holo-ring"></div>

                    <!-- Stack Navigation Arrows -->
                    <button type="button" class="stack-nav-btn stack-nav-prev" onclick="rotatePrev()" title="Previous Film">&#10094;</button>
                    <button type="button" class="stack-nav-btn stack-nav-next" onclick="rotateNext()" title="Next Film">&#10095;</button>

                    <!-- Floating Object 1: Gold Star Rating Capsule -->
                    <div class="floating-obj-score">
                        <span class="score-gold-star">★</span>
                        <span id="floatingScoreText">8.8 IMDb SCORE</span>
                    </div>

                    <!-- Floating Object 2: Velvet Cinema Premiere Pass -->
                    <div class="floating-obj-ticket">
                        <span class="ticket-code">VIP PASS // DCI-P3</span>
                        <span class="ticket-title" id="floatingTicketText">RRR &bull; ULTRA 8K</span>
                    </div>

                    <!-- Floating Object 3: Dolby Atmos Audio Waves -->
                    <div class="floating-obj-atmos">
                        <div class="atmos-bars">
                            <div class="atmos-bar"></div>
                            <div class="atmos-bar"></div>
                            <div class="atmos-bar"></div>
                            <div class="atmos-bar"></div>
                        </div>
                        <span>DOLBY ATMOS 3D</span>
                    </div>

                    <!-- 3D ROTATING POSTER STACK: All cards are distinct physical entities that rotate smoothly in 3D -->
                    <div class="poster-stack-3d" id="posterStack">
                        
                        <!-- Card 0: RRR (Default Center) -->
                        <div class="stack-card pos-center" id="card-0" onclick="handleCardClick(0)">
                            <img src="https://m.media-amazon.com/images/M/MV5BODUwNDNjMTctODUxNy00ZTA2LWIyYTEtMDc5Y2E5NjgzZmFiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg" 
                                 alt="RRR"
                                 onerror="this.onerror=null; this.src='https://upload.wikimedia.org/wikipedia/en/d/d7/RRR_Poster.jpg';">
                            <div class="stack-card-overlay">
                                <div class="stack-card-tag">🏆 MASTER VAULT #01</div>
                                <div class="stack-card-title">RRR</div>
                                <div class="stack-card-score">★ 8.8 IMDb &bull; 187 min</div>
                            </div>
                        </div>

                        <!-- Card 1: Avengers: Endgame (Default Right) -->
                        <div class="stack-card pos-right" id="card-1" onclick="handleCardClick(1)">
                            <img src="https://image.tmdb.org/t/p/w780/or06FN3Dka5tukK1e9sl16pB3iy.jpg" alt="Avengers: Endgame">
                            <div class="stack-card-overlay">
                                <div class="stack-card-tag">⭐ BOX OFFICE TITAN</div>
                                <div class="stack-card-title">Avengers: Endgame</div>
                                <div class="stack-card-score">★ 8.4 IMDb &bull; 181 min</div>
                            </div>
                        </div>

                        <!-- Card 2: Oppenheimer (Default Far-Right) -->
                        <div class="stack-card pos-far-right" id="card-2" onclick="handleCardClick(2)">
                            <img src="https://image.tmdb.org/t/p/w780/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg" alt="Oppenheimer">
                            <div class="stack-card-overlay">
                                <div class="stack-card-tag">⚡ BEST PICTURE WINNER</div>
                                <div class="stack-card-title">Oppenheimer</div>
                                <div class="stack-card-score">★ 8.9 IMDb &bull; 180 min</div>
                            </div>
                        </div>

                        <!-- Card 3: Dangal (Default Hidden/Back) -->
                        <div class="stack-card pos-back" id="card-3" onclick="handleCardClick(3)">
                            <img src="https://m.media-amazon.com/images/M/MV5BMTQ4MzQzMzM2Nl5BMl5BanBnXkFtZTgwMTQ1NzU3MDI@._V1_FMjpg_UX1000_.jpg" alt="Dangal">
                            <div class="stack-card-overlay">
                                <div class="stack-card-tag">🥇 SPORTS BIOPIC MILESTONE</div>
                                <div class="stack-card-title">Dangal</div>
                                <div class="stack-card-score">★ 8.3 IMDb &bull; 161 min</div>
                            </div>
                        </div>

                        <!-- Card 4: Baahubali 2 (Default Far-Left) -->
                        <div class="stack-card pos-far-left" id="card-4" onclick="handleCardClick(4)">
                            <img src="https://image.tmdb.org/t/p/w780/95ZDi8xnG7lApf88TL35GvGyq9k.jpg" alt="Baahubali 2">
                            <div class="stack-card-overlay">
                                <div class="stack-card-tag">👑 PAN-INDIA PHENOMENON</div>
                                <div class="stack-card-title">Baahubali 2</div>
                                <div class="stack-card-score">★ 8.2 IMDb &bull; 167 min</div>
                            </div>
                        </div>

                        <!-- Card 5: 3 Idiots (Default Left) -->
                        <div class="stack-card pos-left" id="card-5" onclick="handleCardClick(5)">
                            <img src="https://image.tmdb.org/t/p/w780/66A9MqXOyVFCssoloscw79z8Tew.jpg" alt="3 Idiots">
                            <div class="stack-card-overlay">
                                <div class="stack-card-tag">🎓 ALL-TIME CULT CLASSIC</div>
                                <div class="stack-card-title">3 Idiots</div>
                                <div class="stack-card-score">★ 8.4 IMDb &bull; 170 min</div>
                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </section>

        <!-- LAYER 4: STREAMING CORRIDOR WITH VELOCITY CONTROLS -->
        <section class="streaming-corridor-section">
            <div class="section-header-hud">
                <div class="hud-title-cluster">
                    <div class="hud-label">
                        <span>⚡</span> Live Trending Stream
                    </div>
                    <h2 class="hud-title">Trending &amp; Blockbuster Masterpieces</h2>
                </div>

                <!-- Velocity HUD Controls -->
                <div class="velocity-hud-bar">
                    <span style="font-family: var(--font-mono); font-size: 0.72rem; color: var(--text-muted); margin-right: 0.3rem;">STREAM SPEED:</span>
                    <button type="button" class="btn-speed-toggle" onclick="setSpeed('slow')">0.5x</button>
                    <button type="button" class="btn-speed-toggle active" onclick="setSpeed('normal')">1.0x</button>
                    <button type="button" class="btn-speed-toggle" onclick="setSpeed('fast')">2.0x</button>
                    <button type="button" class="btn-speed-toggle" onclick="setSpeed('freeze')">⏸ Pause</button>
                </div>
            </div>

            <div class="streaming-viewport">
                <div class="streaming-track" id="streamTrack">
                    
                    <!-- Card 1: RRR -->
                    <div class="stream-movie-card" onclick="rotateTo(0)">
                        <div class="stream-movie-poster">
                            <img src="https://m.media-amazon.com/images/M/MV5BODUwNDNjMTctODUxNy00ZTA2LWIyYTEtMDc5Y2E5NjgzZmFiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg" 
                                 alt="RRR"
                                 onerror="this.onerror=null; this.src='https://upload.wikimedia.org/wikipedia/en/d/d7/RRR_Poster.jpg';">
                            <span class="stream-score-tag">★ 8.8</span>
                        </div>
                        <div class="stream-movie-meta">
                            <div class="stream-movie-title">RRR</div>
                            <div class="stream-movie-sub">
                                <span>2022 &bull; 187m</span>
                                <span>S.S. Rajamouli</span>
                            </div>
                        </div>
                    </div>

                    <!-- Card 2: Avengers Endgame -->
                    <div class="stream-movie-card" onclick="rotateTo(1)">
                        <div class="stream-movie-poster">
                            <img src="https://image.tmdb.org/t/p/w780/or06FN3Dka5tukK1e9sl16pB3iy.jpg" alt="Avengers: Endgame">
                            <span class="stream-score-tag">★ 8.4</span>
                        </div>
                        <div class="stream-movie-meta">
                            <div class="stream-movie-title">Avengers: Endgame</div>
                            <div class="stream-movie-sub">
                                <span>2019 &bull; 181m</span>
                                <span>Russo Bros</span>
                            </div>
                        </div>
                    </div>

                    <!-- Card 3: Dangal -->
                    <div class="stream-movie-card" onclick="rotateTo(3)">
                        <div class="stream-movie-poster">
                            <img src="https://m.media-amazon.com/images/M/MV5BMTQ4MzQzMzM2Nl5BMl5BanBnXkFtZTgwMTQ1NzU3MDI@._V1_FMjpg_UX1000_.jpg" alt="Dangal">
                            <span class="stream-score-tag">★ 8.3</span>
                        </div>
                        <div class="stream-movie-meta">
                            <div class="stream-movie-title">Dangal</div>
                            <div class="stream-movie-sub">
                                <span>2016 &bull; 161m</span>
                                <span>Nitesh Tiwari</span>
                            </div>
                        </div>
                    </div>

                    <!-- Card 4: Oppenheimer -->
                    <div class="stream-movie-card" onclick="rotateTo(2)">
                        <div class="stream-movie-poster">
                            <img src="https://image.tmdb.org/t/p/w780/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg" alt="Oppenheimer">
                            <span class="stream-score-tag">★ 8.9</span>
                        </div>
                        <div class="stream-movie-meta">
                            <div class="stream-movie-title">Oppenheimer</div>
                            <div class="stream-movie-sub">
                                <span>2023 &bull; 180m</span>
                                <span>C. Nolan</span>
                            </div>
                        </div>
                    </div>

                    <!-- Card 5: Baahubali 2 -->
                    <div class="stream-movie-card" onclick="rotateTo(4)">
                        <div class="stream-movie-poster">
                            <img src="https://image.tmdb.org/t/p/w780/95ZDi8xnG7lApf88TL35GvGyq9k.jpg" alt="Baahubali 2">
                            <span class="stream-score-tag">★ 8.2</span>
                        </div>
                        <div class="stream-movie-meta">
                            <div class="stream-movie-title">Baahubali 2</div>
                            <div class="stream-movie-sub">
                                <span>2017 &bull; 167m</span>
                                <span>S.S. Rajamouli</span>
                            </div>
                        </div>
                    </div>

                    <!-- Card 6: 3 Idiots -->
                    <div class="stream-movie-card" onclick="rotateTo(5)">
                        <div class="stream-movie-poster">
                            <img src="https://image.tmdb.org/t/p/w780/66A9MqXOyVFCssoloscw79z8Tew.jpg" alt="3 Idiots">
                            <span class="stream-score-tag">★ 8.4</span>
                        </div>
                        <div class="stream-movie-meta">
                            <div class="stream-movie-title">3 Idiots</div>
                            <div class="stream-movie-sub">
                                <span>2009 &bull; 170m</span>
                                <span>R. Hirani</span>
                            </div>
                        </div>
                    </div>

                    <!-- SEAMLESS DUPLICATE RUN FOR INFINITE GLIDE -->
                    <div class="stream-movie-card" onclick="rotateTo(0)">
                        <div class="stream-movie-poster">
                            <img src="https://m.media-amazon.com/images/M/MV5BODUwNDNjMTctODUxNy00ZTA2LWIyYTEtMDc5Y2E5NjgzZmFiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg" 
                                 alt="RRR"
                                 onerror="this.onerror=null; this.src='https://upload.wikimedia.org/wikipedia/en/d/d7/RRR_Poster.jpg';">
                            <span class="stream-score-tag">★ 8.8</span>
                        </div>
                        <div class="stream-movie-meta">
                            <div class="stream-movie-title">RRR</div>
                            <div class="stream-movie-sub">
                                <span>2022 &bull; 187m</span>
                                <span>S.S. Rajamouli</span>
                            </div>
                        </div>
                    </div>

                    <div class="stream-movie-card" onclick="rotateTo(1)">
                        <div class="stream-movie-poster">
                            <img src="https://image.tmdb.org/t/p/w780/or06FN3Dka5tukK1e9sl16pB3iy.jpg" alt="Avengers: Endgame">
                            <span class="stream-score-tag">★ 8.4</span>
                        </div>
                        <div class="stream-movie-meta">
                            <div class="stream-movie-title">Avengers: Endgame</div>
                            <div class="stream-movie-sub">
                                <span>2019 &bull; 181m</span>
                                <span>Russo Bros</span>
                            </div>
                        </div>
                    </div>

                    <div class="stream-movie-card" onclick="rotateTo(3)">
                        <div class="stream-movie-poster">
                            <img src="https://m.media-amazon.com/images/M/MV5BMTQ4MzQzMzM2Nl5BMl5BanBnXkFtZTgwMTQ1NzU3MDI@._V1_FMjpg_UX1000_.jpg" alt="Dangal">
                            <span class="stream-score-tag">★ 8.3</span>
                        </div>
                        <div class="stream-movie-meta">
                            <div class="stream-movie-title">Dangal</div>
                            <div class="stream-movie-sub">
                                <span>2016 &bull; 161m</span>
                                <span>Nitesh Tiwari</span>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <!-- LAYER 5: BESPOKE WINE COMMAND MODULES -->
        <section class="futuristic-command-section">
            <div class="section-header-hud">
                <div class="hud-title-cluster">
                    <div class="hud-label">
                        <span>🎛️</span> Studio Command
                    </div>
                    <h2 class="hud-title">Cinema Universe Management Modules</h2>
                </div>
            </div>

            <div class="command-grid">
                
                <!-- Module 1: Films Vault -->
                <div class="command-module-card" style="--module-accent: var(--wine-ruby);">
                    <div>
                        <div class="module-badge">
                            <span>🎬</span> <span>MODULE 01 &bull; CINEMA VAULT</span>
                        </div>
                        <h3 class="module-heading">Master Film Library</h3>
                        <p class="module-summary">
                            Catalog feature films with high-definition specs, runtime telemetry, critic ratings, and international releases.
                        </p>

                        <div class="module-metric-display">
                            <div class="metric-digits"><%= movieCount %></div>
                            <div class="metric-info">
                                <span class="metric-title">Cataloged Releases</span>
                                <span class="metric-sub">Master Titles in Library</span>
                            </div>
                        </div>
                    </div>

                    <div class="module-button-row">
                        <a href="displayMovie" class="btn-module-action btn-module-glow">+ Catalog Film</a>
                        <a href="viewMovies" class="btn-module-action btn-module-ghost">Inspect Vault</a>
                    </div>
                </div>

                <!-- Module 2: Directors Atelier -->
                <div class="command-module-card" style="--module-accent: var(--cinema-gold);">
                    <div>
                        <div class="module-badge">
                            <span>🎥</span> <span>MODULE 02 &bull; VISIONARIES</span>
                        </div>
                        <h3 class="module-heading">Director Atelier</h3>
                        <p class="module-summary">
                            Maintain dossiers for legendary filmmakers, directorial visionaries, filmography records, and national affiliations.
                        </p>

                        <div class="module-metric-display">
                            <div class="metric-digits"><%= directorCount %></div>
                            <div class="metric-info">
                                <span class="metric-title">Visionary Directors</span>
                                <span class="metric-sub">Registered Filmmakers</span>
                            </div>
                        </div>
                    </div>

                    <div class="module-button-row">
                        <a href="displayDirector" class="btn-module-action btn-module-glow" style="background: var(--cinema-gold); color: #060103; box-shadow: 0 0 15px rgba(245, 158, 11, 0.45);">+ Add Director</a>
                        <a href="viewDirectors" class="btn-module-action btn-module-ghost">Dossiers</a>
                    </div>
                </div>

                <!-- Module 3: Star Talent & Categories -->
                <div class="command-module-card" style="--module-accent: #C084FC;">
                    <div>
                        <div class="module-badge">
                            <span>🎭</span> <span>MODULE 03 &bull; TALENT &amp; GENRES</span>
                        </div>
                        <h3 class="module-heading">Talent &amp; Categories</h3>
                        <p class="module-summary">
                            Organize headline acting talent rosters, star character assignments, and dynamic cinema genre taxonomies.
                        </p>

                        <div class="taxonomy-pill-cloud">
                            <span class="taxo-pill">⚡ Action (<%= genreCount %>)</span>
                            <span class="taxo-pill">🚀 Sci-Fi Contenders</span>
                            <span class="taxo-pill">🤼 Biographies</span>
                            <span class="taxo-pill">🎭 <%= actorCount %> Actors Active</span>
                        </div>
                    </div>

                    <div class="module-button-row">
                        <a href="displayActor" class="btn-module-action btn-module-glow" style="background: #A855F7; color: #fff; box-shadow: 0 0 15px rgba(168, 85, 247, 0.4);">+ Add Talent</a>
                        <a href="viewGenres" class="btn-module-action btn-module-ghost">Categories</a>
                    </div>
                </div>

            </div>
        </section>

    </main>

    <!-- LAYER 6: FLOATING STUDIO DOCK -->
    <div class="floating-studio-dock">
        <div class="dock-brand-tag">
            <span style="color: var(--wine-ruby);">📽️</span> CINETRACK
        </div>
        <a href="displayMovie" class="dock-action-btn">+ Film</a>
        <a href="displayDirector" class="dock-action-btn">+ Director</a>
        <a href="displayActor" class="dock-action-btn">+ Talent</a>
        <a href="displayGenre" class="dock-action-btn">+ Category</a>
        <a href="viewMovies" class="dock-action-btn" style="background: rgba(229, 23, 72, 0.2); border-color: var(--wine-ruby); color: #FF2459;">Vault &rarr;</a>
    </div>

    <!-- LAYER 7: PRESTIGE CINEMA FOOTER (Zero DB Jargon) -->
    <footer class="futuristic-footer">
        <div class="footer-container">
            <div class="footer-top-row">
                <div class="footer-brand">
                    <span>📽️</span> CineTrack Cinema Universe
                </div>

                <div class="cinema-spec-pills">
                    <span class="spec-badge">ULTRA-HD 8K MASTERING</span>
                    <span class="spec-badge">DOLBY ATMOS &bull; SPATIAL AUDIO</span>
                    <span class="spec-badge">DCI-P3 100% COLOR SPECTRUM</span>
                    <span class="spec-badge">IMAX 1.90:1 RATIO</span>
                    <span class="spec-badge">120 FPS HFR PLAYBACK</span>
                </div>
            </div>

            <div class="footer-bottom-text">
                &copy; 2026 CineTrack Cinema Universe. Designed for cinema curators, film archivists, and visionary storytellers worldwide.
            </div>
        </div>
    </footer>

    <!-- INTERACTIVE 3D CROSS-STACK ROTATION LOGIC -->
    <script>
        const moviesDatabase = [
            {
                key: "rrr",
                title: "RRR",
                scoreText: "8.8 IMDb SCORE",
                ticketText: "RRR • ULTRA 8K",
                quote: "Cinema is not just about moving pictures; it is the deliberate preservation of world-building, director vision, and dramatic performances.",
                cite: "— S.S. Rajamouli • Director of RRR & Baahubali",
                url: "editMovie?id=1"
            },
            {
                key: "endgame",
                title: "Avengers: Endgame",
                scoreText: "8.4 IMDb SCORE",
                ticketText: "ENDGAME • IMAX 3D",
                quote: "Part of the journey is the end. We set out to give audiences a grand climax that honors a decade of world cinema storytelling.",
                cite: "— Anthony & Joe Russo • Directors of Avengers",
                url: "editMovie?id=7"
            },
            {
                key: "oppenheimer",
                title: "Oppenheimer",
                scoreText: "8.9 IMDb SCORE",
                ticketText: "OPPENHEIMER • 70MM IMAX",
                quote: "Now I am become Death, the destroyer of worlds. The theatrical canvas is meant to take you inside the paradox of human ambition.",
                cite: "— Christopher Nolan • Master of Time & Sound",
                url: "displayMovie"
            },
            {
                key: "dangal",
                title: "Dangal",
                scoreText: "8.3 IMDb SCORE",
                ticketText: "DANGAL • BIOPIC HIT",
                quote: "Mhaari chhoriyan chhoron se kam hain ke? Real triumph in cinema comes from authentic human resilience and sheer grit.",
                cite: "— Nitesh Tiwari • Director of Dangal",
                url: "editMovie?id=2"
            },
            {
                key: "baahubali",
                title: "Baahubali 2",
                scoreText: "8.2 IMDb SCORE",
                ticketText: "BAAHUBALI 2 • 4K ATMOS",
                quote: "Amarendra Baahubali ane nenu! Mythological grandeur requires absolute commitment to scale, loyalty, and cinematic spectacle.",
                cite: "— S.S. Rajamouli • Master of Indian Epic Cinema",
                url: "editMovie?id=4"
            },
            {
                key: "idiots",
                title: "3 Idiots",
                scoreText: "8.4 IMDb SCORE",
                ticketText: "3 IDIOTS • CULT HIT",
                quote: "All is well! Follow excellence, and success will chase you pants down. An evergreen lesson packaged in unforgettable laughter.",
                cite: "— Rajkumar Hirani • Director of 3 Idiots",
                url: "editMovie?id=3"
            }
        ];

        const TOTAL_CARDS = moviesDatabase.length;
        let currentCenterIndex = 0;

        // Position classes in order of offset from center
        const positionClasses = ['pos-center', 'pos-right', 'pos-far-right', 'pos-back', 'pos-far-left', 'pos-left'];

        function updateStack(newCenterIndex) {
            currentCenterIndex = ((newCenterIndex % TOTAL_CARDS) + TOTAL_CARDS) % TOTAL_CARDS;

            // Update each physical card's 3D position
            for (let i = 0; i < TOTAL_CARDS; i++) {
                const card = document.getElementById('card-' + i);
                if (!card) continue;

                // Remove previous position classes
                card.classList.remove('pos-center', 'pos-left', 'pos-right', 'pos-far-left', 'pos-far-right', 'pos-back');

                // Calculate relative cyclic offset from center: 0, 1, 2, 3, -2, -1
                let offset = (i - currentCenterIndex) % TOTAL_CARDS;
                if (offset < 0) offset += TOTAL_CARDS;

                if (offset === 0) {
                    card.classList.add('pos-center');
                } else if (offset === 1) {
                    card.classList.add('pos-right');
                } else if (offset === 2) {
                    card.classList.add('pos-far-right');
                } else if (offset === 3) {
                    card.classList.add('pos-back');
                } else if (offset === 4) {
                    card.classList.add('pos-far-left');
                } else if (offset === 5) {
                    card.classList.add('pos-left');
                }
            }

            // Update Tab Buttons
            document.querySelectorAll('.pill-switch-btn').forEach((btn, idx) => {
                if (idx === currentCenterIndex) {
                    btn.classList.add('active');
                } else {
                    btn.classList.remove('active');
                }
            });

            // Update Intel Details (Quote, Floating Badges)
            const currentMovie = moviesDatabase[currentCenterIndex];
            const quoteEl = document.getElementById('activeQuote');
            if (quoteEl) {
                quoteEl.style.opacity = '0.5';
                setTimeout(() => {
                    quoteEl.innerHTML = `&ldquo;${currentMovie.quote}&rdquo;<cite id="activeCite">${currentMovie.cite}</cite>`;
                    quoteEl.style.opacity = '1';
                }, 150);
            }

            const scoreText = document.getElementById('floatingScoreText');
            if (scoreText) scoreText.textContent = currentMovie.scoreText;

            const ticketText = document.getElementById('floatingTicketText');
            if (ticketText) ticketText.textContent = currentMovie.ticketText;
        }

        function handleCardClick(clickedIndex) {
            if (clickedIndex === currentCenterIndex) {
                // If user clicks the front center card, navigate to edit/inspect
                const movie = moviesDatabase[currentCenterIndex];
                if (movie && movie.url) {
                    window.location.href = movie.url;
                }
            } else {
                // Smoothly rotate the stack so the clicked card rotates to center!
                rotateTo(clickedIndex);
            }
        }

        function rotateTo(index) {
            updateStack(index);
        }

        function rotateNext() {
            updateStack(currentCenterIndex + 1);
        }

        function rotatePrev() {
            updateStack(currentCenterIndex - 1);
        }

        // Keyboard Arrow Navigation
        window.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowRight') rotateNext();
            if (e.key === 'ArrowLeft') rotatePrev();
        });

        // Speed toggle for infinite marquee
        function setSpeed(speed) {
            document.querySelectorAll('.btn-speed-toggle').forEach(b => b.classList.remove('active'));
            event.target.classList.add('active');
            const track = document.getElementById('streamTrack');

            if (speed === 'slow') {
                track.style.animationPlayState = 'running';
                track.style.animationDuration = '60s';
            } else if (speed === 'normal') {
                track.style.animationPlayState = 'running';
                track.style.animationDuration = '35s';
            } else if (speed === 'fast') {
                track.style.animationPlayState = 'running';
                track.style.animationDuration = '18s';
            } else if (speed === 'freeze') {
                track.style.animationPlayState = 'paused';
            }
        }

        // Initialize stack on page load
        document.addEventListener('DOMContentLoaded', () => {
            updateStack(0);
        });
    </script>

</body>
</html>
