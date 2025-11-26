package com.pizzasreyna.pizzaback.adapters.controller;

import com.pizzasreyna.pizzaback.adapters.dto.PizzaDTO;
import com.pizzasreyna.pizzaback.application.service.PizzaService;
import com.pizzasreyna.pizzaback.domain.model.Pizza;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/admin/pizzas")
@RequiredArgsConstructor
@SecurityRequirement(name = "bearerAuth")
@Tag(name = "Admin - Pizzas", description = "Gestión administrativa de pizzas")
public class AdminPizzaController {

    private final PizzaService pizzaService;

    @GetMapping
    @Operation(summary = "Obtener todas las pizzas (incluidas no disponibles)")
    public ResponseEntity<List<PizzaDTO>> obtenerTodasPizzas() {
        return ResponseEntity.ok(pizzaService.obtenerTodasPizzas());
    }

    @PostMapping
    @Operation(summary = "Crear nueva pizza")
    public ResponseEntity<PizzaDTO> crearPizza(@RequestBody Pizza pizza) {
        return ResponseEntity.ok(pizzaService.crearPizza(pizza));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Actualizar pizza")
    public ResponseEntity<PizzaDTO> actualizarPizza(
            @PathVariable Long id,
            @RequestBody Pizza pizza) {
        return ResponseEntity.ok(pizzaService.actualizarPizza(id, pizza));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Eliminar pizza")
    public ResponseEntity<Void> eliminarPizza(@PathVariable Long id) {
        pizzaService.eliminarPizza(id);
        return ResponseEntity.ok().build();
    }
}
