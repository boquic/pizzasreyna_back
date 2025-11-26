package com.pizzasreyna.pizzaback.adapters.controller;

import com.pizzasreyna.pizzaback.adapters.dto.PizzaDTO;
import com.pizzasreyna.pizzaback.application.service.PizzaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/pizzas")
@RequiredArgsConstructor
@Tag(name = "Pizzas", description = "Gestión de pizzas")
public class PizzaController {

    private final PizzaService pizzaService;

    @GetMapping
    @Operation(summary = "Obtener todas las pizzas disponibles")
    public ResponseEntity<List<PizzaDTO>> obtenerPizzasDisponibles() {
        return ResponseEntity.ok(pizzaService.obtenerPizzasDisponibles());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Obtener pizza por ID")
    public ResponseEntity<PizzaDTO> obtenerPizza(@PathVariable Long id) {
        return ResponseEntity.ok(pizzaService.obtenerPizza(id));
    }
}
