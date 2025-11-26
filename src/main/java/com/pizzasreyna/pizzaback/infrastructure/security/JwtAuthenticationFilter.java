package com.pizzasreyna.pizzaback.infrastructure.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final UserDetailsService userDetailsService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        final String authorizationHeader = request.getHeader("Authorization");

        String username = null;
        String jwt = null;

        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            jwt = authorizationHeader.substring(7);
            try {
                // Only proceed if the JWT token is not empty or null
                if (jwt != null && !jwt.isEmpty()) {
                    username = jwtUtil.extractUsername(jwt);

                    // Only proceed with authentication if username was successfully extracted
                    if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                        UserDetails userDetails = this.userDetailsService.loadUserByUsername(username);

                        try {
                            if (jwtUtil.validateToken(jwt, userDetails)) {
                                UsernamePasswordAuthenticationToken authenticationToken = 
                                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                                authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                            }
                        } catch (Exception e) {
                            logger.error("Error validating JWT token", e);
                            // Continue without authentication
                        }
                    }
                }
            } catch (Exception e) {
                logger.error("Error extracting username from JWT", e);
                // Continue without authentication
            }
        }

        filterChain.doFilter(request, response);
    }
}
