package com.pizzasreyna.pizzaback.infrastructure.websocket;

import com.pizzasreyna.pizzaback.adapters.dto.PedidoEstadoDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PedidoWebSocketService {

    private final SimpMessagingTemplate messagingTemplate;

    public void notificarCambioEstado(Long pedidoId, PedidoEstadoDTO estadoDTO) {
        messagingTemplate.convertAndSend("/topic/pedidos/" + pedidoId, estadoDTO);
    }

    public void notificarNuevoPedido(Long pedidoId) {
        messagingTemplate.convertAndSend("/topic/pedidos/nuevos", pedidoId);
    }
}
