package com.pizzasreyna.pizzaback.adapters.controller;

import com.pizzasreyna.pizzaback.adapters.dto.CrearPedidoRequest;
import com.pizzasreyna.pizzaback.adapters.dto.PedidoDTO;
import com.pizzasreyna.pizzaback.application.service.PedidoService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/usuario/pedidos")
@RequiredArgsConstructor
@SecurityRequirement(name = "bearerAuth")
@Tag(name = "Pedidos Usuario", description = "Gestión de pedidos del usuario")
public class PedidoController {

    private final PedidoService pedidoService;

    @PostMapping
    @Operation(summary = "Crear nuevo pedido")
    public ResponseEntity<PedidoDTO> crearPedido(
            Authentication authentication,
            @Valid @RequestBody CrearPedidoRequest request) {
        return ResponseEntity.ok(pedidoService.crearPedido(authentication.getName(), request));
    }

    @GetMapping
    @Operation(summary = "Obtener historial de pedidos del usuario")
    public ResponseEntity<List<PedidoDTO>> obtenerMisPedidos(Authentication authentication) {
        return ResponseEntity.ok(pedidoService.obtenerPedidosUsuario(authentication.getName()));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Obtener detalle de un pedido")
    public ResponseEntity<PedidoDTO> obtenerPedido(@PathVariable Long id) {
        return ResponseEntity.ok(pedidoService.obtenerPedido(id));
    }
}
