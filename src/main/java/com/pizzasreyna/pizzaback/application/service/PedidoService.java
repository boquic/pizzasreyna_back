package com.pizzasreyna.pizzaback.application.service;

import com.pizzasreyna.pizzaback.adapters.dto.CrearPedidoRequest;
import com.pizzasreyna.pizzaback.adapters.dto.PedidoDTO;
import com.pizzasreyna.pizzaback.adapters.dto.PedidoEstadoDTO;
import com.pizzasreyna.pizzaback.adapters.mapper.PedidoMapper;
import com.pizzasreyna.pizzaback.domain.model.*;
import com.pizzasreyna.pizzaback.domain.repository.*;
import com.pizzasreyna.pizzaback.infrastructure.websocket.PedidoWebSocketService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PedidoService {

    private final PedidoRepository pedidoRepository;
    private final UsuarioRepository usuarioRepository;
    private final EstadoPedidoRepository estadoPedidoRepository;
    private final PizzaRepository pizzaRepository;
    private final ComboRepository comboRepository;
    private final IngredienteRepository ingredienteRepository;
    private final RepartidorRepository repartidorRepository;
    private final PedidoMapper pedidoMapper;
    private final PedidoWebSocketService webSocketService;

    @Transactional
    public PedidoDTO crearPedido(String email, CrearPedidoRequest request) {
        Usuario usuario = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        EstadoPedido estadoPendiente = estadoPedidoRepository.findByNombre("PENDIENTE")
                .orElseThrow(() -> new RuntimeException("Estado PENDIENTE no encontrado"));

        Pedido pedido = Pedido.builder()
                .usuario(usuario)
                .estado(estadoPendiente)
                .direccionEntrega(request.getDireccionEntrega())
                .telefonoContacto(request.getTelefonoContacto())
                .notas(request.getNotas())
                .costoEnvio(BigDecimal.valueOf(5.00))
                .build();

        BigDecimal subtotal = BigDecimal.ZERO;

        for (CrearPedidoRequest.ItemPedidoRequest itemReq : request.getItems()) {
            PedidoDetalle detalle = PedidoDetalle.builder()
                    .pedido(pedido)
                    .cantidad(itemReq.getCantidad())
                    .notas(itemReq.getNotas())
                    .build();

            BigDecimal precioUnitario = BigDecimal.ZERO;

            if (itemReq.getPizzaId() != null) {
                Pizza pizza = pizzaRepository.findById(itemReq.getPizzaId())
                        .orElseThrow(() -> new RuntimeException("Pizza no encontrada"));
                detalle.setPizza(pizza);
                precioUnitario = pizza.getPrecioBase();

                if (itemReq.getIngredientesPersonalizadosIds() != null) {
                    Set<Ingrediente> ingredientes = new HashSet<>(
                            ingredienteRepository.findAllById(itemReq.getIngredientesPersonalizadosIds())
                    );
                    detalle.setIngredientesPersonalizados(ingredientes);
                    precioUnitario = precioUnitario.add(
                            ingredientes.stream()
                                    .map(Ingrediente::getPrecioAdicional)
                                    .reduce(BigDecimal.ZERO, BigDecimal::add)
                    );
                }
            } else if (itemReq.getComboId() != null) {
                Combo combo = comboRepository.findById(itemReq.getComboId())
                        .orElseThrow(() -> new RuntimeException("Combo no encontrado"));
                detalle.setCombo(combo);
                precioUnitario = combo.getPrecio();
            }

            detalle.setPrecioUnitario(precioUnitario);
            detalle.setSubtotal(precioUnitario.multiply(BigDecimal.valueOf(itemReq.getCantidad())));
            subtotal = subtotal.add(detalle.getSubtotal());

            pedido.getDetalles().add(detalle);
        }

        pedido.setSubtotal(subtotal);
        pedido.setTotal(subtotal.add(pedido.getCostoEnvio()));
        pedido.setFechaEntregaEstimada(LocalDateTime.now().plusMinutes(45));

        pedido = pedidoRepository.save(pedido);

        webSocketService.notificarNuevoPedido(pedido.getId());

        return pedidoMapper.toDTO(pedido);
    }

    @Transactional
    public PedidoDTO actualizarEstado(Long pedidoId, String nuevoEstado) {
        Pedido pedido = pedidoRepository.findById(pedidoId)
                .orElseThrow(() -> new RuntimeException("Pedido no encontrado"));

        EstadoPedido estado = estadoPedidoRepository.findByNombre(nuevoEstado)
                .orElseThrow(() -> new RuntimeException("Estado no encontrado"));

        pedido.setEstado(estado);

        if ("ENTREGADO".equals(nuevoEstado)) {
            pedido.setFechaEntregaReal(LocalDateTime.now());
        }

        pedido = pedidoRepository.save(pedido);

        PedidoEstadoDTO estadoDTO = PedidoEstadoDTO.builder()
                .pedidoId(pedido.getId())
                .estadoNombre(estado.getNombre())
                .estadoDescripcion(estado.getDescripcion())
                .fechaCambio(LocalDateTime.now())
                .build();

        webSocketService.notificarCambioEstado(pedidoId, estadoDTO);

        return pedidoMapper.toDTO(pedido);
    }

    @Transactional
    public PedidoDTO asignarRepartidor(Long pedidoId, Long repartidorId) {
        Pedido pedido = pedidoRepository.findById(pedidoId)
                .orElseThrow(() -> new RuntimeException("Pedido no encontrado"));

        Repartidor repartidor = repartidorRepository.findById(repartidorId)
                .orElseThrow(() -> new RuntimeException("Repartidor no encontrado"));

        pedido.setRepartidor(repartidor);
        pedido = pedidoRepository.save(pedido);

        return pedidoMapper.toDTO(pedido);
    }

    @Transactional(readOnly = true)
    public List<PedidoDTO> obtenerPedidosUsuario(String email) {
        Usuario usuario = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        return pedidoRepository.findByUsuarioOrderByFechaPedidoDesc(usuario).stream()
                .map(pedidoMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<PedidoDTO> obtenerTodosPedidos() {
        return pedidoRepository.findAll().stream()
                .map(pedidoMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public PedidoDTO obtenerPedido(Long id) {
        Pedido pedido = pedidoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pedido no encontrado"));
        return pedidoMapper.toDTO(pedido);
    }
}
