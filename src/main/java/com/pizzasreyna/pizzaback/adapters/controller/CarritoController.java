package com.pizzasreyna.pizzaback.adapters.controller;

import com.pizzasreyna.pizzaback.adapters.dto.AgregarCarritoRequest;
import com.pizzasreyna.pizzaback.adapters.dto.CarritoDTO;
import com.pizzasreyna.pizzaback.application.service.CarritoService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/usuario/carrito")
@RequiredArgsConstructor
@SecurityRequirement(name = "bearerAuth")
@Tag(name = "Carrito", description = "Gestión del carrito de compras")
public class CarritoController {

    private final CarritoService carritoService;

    @GetMapping
    @Operation(summary = "Obtener carrito del usuario")
    public ResponseEntity<CarritoDTO> obtenerCarrito(Authentication authentication) {
        return ResponseEntity.ok(carritoService.obtenerCarrito(authentication.getName()));
    }

    @PostMapping("/agregar")
    @Operation(summary = "Agregar item al carrito")
    public ResponseEntity<CarritoDTO> agregarItem(
            Authentication authentication,
            @Valid @RequestBody AgregarCarritoRequest request) {
        return ResponseEntity.ok(carritoService.agregarItem(authentication.getName(), request));
    }

    @DeleteMapping("/limpiar")
    @Operation(summary = "Limpiar carrito")
    public ResponseEntity<Void> limpiarCarrito(Authentication authentication) {
        carritoService.limpiarCarrito(authentication.getName());
        return ResponseEntity.ok().build();
    }
}
