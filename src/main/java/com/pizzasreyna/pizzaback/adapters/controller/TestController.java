package com.pizzasreyna.pizzaback.adapters.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/test")
@CrossOrigin(origins = "*")
public class TestController {

    @GetMapping("/hello")
    public ResponseEntity<String> helloGet() {
        return ResponseEntity.ok("Hello from GET!");
    }

    @PostMapping("/hello")
    public ResponseEntity<Map<String, String>> helloPost(@RequestBody Map<String, String> body) {
        return ResponseEntity.ok(Map.of(
            "message", "Hello from POST!",
            "received", body.toString()
        ));
    }
}
