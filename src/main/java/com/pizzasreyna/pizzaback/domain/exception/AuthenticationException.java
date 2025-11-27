package com.pizzasreyna.pizzaback.domain.exception;

/**
 * Exception thrown when authentication fails.
 * This includes scenarios like incorrect password, inactive user, or duplicate registration.
 */
public class AuthenticationException extends RuntimeException {
    
    public AuthenticationException(String message) {
        super(message);
    }
    
    public AuthenticationException(String message, Throwable cause) {
        super(message, cause);
    }
}
