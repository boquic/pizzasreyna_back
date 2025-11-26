package com.pizzasreyna.pizzaback.adapters.controller;

import com.pizzasreyna.pizzaback.adapters.dto.PedidoDTO;
import com.pizzasreyna.pizzaback.application.service.PedidoService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/admin/pedidos")
@RequiredArgsConstructor
@SecurityRequirement(name = "bearerAuth")
@Tag(name = "Admin - Pedidos", description = "Gestión administrativa de pedidos")
public class AdminPedidoController {

    private final PedidoService pedidoService;

    @GetMapping
    @Operation(summary = "Obtener todos los pedidos")
    public ResponseEntity<List<PedidoDTO>> obtenerTodosPedidos() {
        return ResponseEntity.ok(pedidoService.obtenerTodosPedidos());
    }

    @PutMapping("/{id}/estado")
    @Operation(summary = "Actualizar estado del pedido")
    public ResponseEntity<PedidoDTO> actualizarEstado(
            @PathVariable Long id,
            @RequestParam String estado) {
        return ResponseEntity.ok(pedidoService.actualizarEstado(id, estado));
    }

    @PutMapping("/{id}/repartidor")
    @Operation(summary = "Asignar repartidor al pedido")
    public ResponseEntity<PedidoDTO> asignarRepartidor(
            @PathVariable Long id,
            @RequestParam Long repartidorId) {
        return ResponseEntity.ok(pedidoService.asignarRepartidor(id, repartidorId));
    }
}
