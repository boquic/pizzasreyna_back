package com.pizzasreyna.pizzaback.infrastructure.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final UserDetailsService userDetailsService;

    // Constructor con @Lazy para evitar dependencia circular
    public JwtAuthenticationFilter(JwtUtil jwtUtil, @Lazy UserDetailsService userDetailsService) {
        this.jwtUtil = jwtUtil;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        String path = request.getRequestURI();
        String method = request.getMethod();
        
        // Skip filter for OPTIONS requests (CORS preflight)
        if ("OPTIONS".equals(method)) {
            return true;
        }
        
        // Skip filter for public endpoints
        return path.startsWith("/api/auth/") || 
               path.startsWith("/api/pizzas") ||
               path.startsWith("/ws/") ||
               path.startsWith("/api-docs") ||
               path.startsWith("/swagger-ui") ||
               path.startsWith("/v3/api-docs");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        final String authorizationHeader = request.getHeader("Authorization");
        
        // Debug logging
        logger.info("=== JWT Filter Debug ===");
        logger.info("Path: " + request.getRequestURI());
        logger.info("Method: " + request.getMethod());
        logger.info("Auth Header: " + (authorizationHeader != null ? "Present" : "Missing"));

        String username = null;
        String jwt = null;

        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            jwt = authorizationHeader.substring(7);
            try {
                username = jwtUtil.extractUsername(jwt);
                logger.info("Extracted username: " + username);
            } catch (Exception e) {
                logger.error("Error extracting username from JWT: " + e.getMessage(), e);
            }
        } else {
            logger.warn("No Bearer token found in Authorization header");
        }

        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            try {
                UserDetails userDetails = this.userDetailsService.loadUserByUsername(username);
                logger.info("User loaded: " + userDetails.getUsername());
                logger.info("Authorities: " + userDetails.getAuthorities());

                if (jwtUtil.validateToken(jwt, userDetails)) {
                    UsernamePasswordAuthenticationToken authenticationToken = 
                        new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                    logger.info("✅ Authentication set successfully for: " + username);
                } else {
                    logger.warn("❌ Token validation failed for user: " + username);
                }
            } catch (Exception e) {
                logger.error("❌ Error loading user or validating token: " + e.getMessage(), e);
            }
        } else if (username == null) {
            logger.warn("Username is null, skipping authentication");
        } else {
            logger.info("Authentication already exists in SecurityContext");
        }
        
        logger.info("========================");
        filterChain.doFilter(request, response);
    }
}
