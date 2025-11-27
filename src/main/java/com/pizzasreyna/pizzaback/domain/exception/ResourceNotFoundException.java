package com.pizzasreyna.pizzaback.domain.exception;

/**
 * Exception thrown when a requested resource is not found.
 * This includes scenarios like user not found, role not found, etc.
 */
public class ResourceNotFoundException extends RuntimeException {
    
    public ResourceNotFoundException(String message) {
        super(message);
    }
    
    public ResourceNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}
