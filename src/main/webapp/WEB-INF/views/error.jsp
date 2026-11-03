<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - CineTrack</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { font-family: Arial, sans-serif; background: #1a1a2e; color: #eee; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .error-box { background: #16213e; border: 1px solid #e74c3c; border-radius: 10px; padding: 40px 60px; text-align: center; max-width: 600px; }
        .error-box h1 { color: #e74c3c; font-size: 2rem; margin-bottom: 10px; }
        .error-box h2 { color: #f39c12; font-size: 1.2rem; margin-bottom: 20px; }
        .error-box p { color: #bbb; margin-bottom: 30px; word-break: break-word; }
        .error-box a { background: #e74c3c; color: white; padding: 10px 25px; border-radius: 5px; text-decoration: none; font-weight: bold; }
        .error-box a:hover { background: #c0392b; }
    </style>
</head>
<body>
    <div class="error-box">
        <h1>&#x26A0; Something went wrong</h1>
        <h2>${not empty errorType ? errorType : 'Error'}</h2>
        <p>${not empty errorMessage ? errorMessage : 'An unexpected error occurred. Please try again or contact support.'}</p>
        <a href="${pageContext.request.contextPath}/">&#8592; Back to Dashboard</a>
    </div>
</body>
</html>
