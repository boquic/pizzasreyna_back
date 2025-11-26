package com.pizzasreyna.pizzaback.infrastructure.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.io.IOException;

import static org.mockito.Mockito.*;

class JwtAuthenticationFilterTest {

    @Mock
    private JwtUtil jwtUtil;

    @Mock
    private UserDetailsService userDetailsService;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private FilterChain filterChain;

    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        jwtAuthenticationFilter = new JwtAuthenticationFilter(jwtUtil, userDetailsService);
        SecurityContextHolder.clearContext();
    }

    @Test
    void shouldHandleMalformedJwtGracefully() throws ServletException, IOException {
        // Given
        when(request.getHeader("Authorization")).thenReturn("Bearer malformedToken");
        when(jwtUtil.extractUsername("malformedToken")).thenThrow(new io.jsonwebtoken.MalformedJwtException("JWT strings must contain exactly 2 period characters. Found: 0"));

        // When
        jwtAuthenticationFilter.doFilterInternal(request, response, filterChain);

        // Then
        verify(filterChain).doFilter(request, response);
        // Verify that the filter continues processing even when a malformed token is provided
    }

    @Test
    void shouldHandleEmptyJwtGracefully() throws ServletException, IOException {
        // Given
        when(request.getHeader("Authorization")).thenReturn("Bearer ");

        // When
        jwtAuthenticationFilter.doFilterInternal(request, response, filterChain);

        // Then
        verify(filterChain).doFilter(request, response);
        // Verify that the filter continues processing even when an empty token is provided
    }

    @Test
    void shouldHandleNullAuthorizationHeaderGracefully() throws ServletException, IOException {
        // Given
        when(request.getHeader("Authorization")).thenReturn(null);

        // When
        jwtAuthenticationFilter.doFilterInternal(request, response, filterChain);

        // Then
        verify(filterChain).doFilter(request, response);
        // Verify that the filter continues processing even when no Authorization header is provided
    }
}