package com.pizzasreyna.pizzaback.adapters.mapper;

import com.pizzasreyna.pizzaback.adapters.dto.PedidoDTO;
import com.pizzasreyna.pizzaback.adapters.dto.PedidoDetalleDTO;
import com.pizzasreyna.pizzaback.domain.model.Pedido;
import com.pizzasreyna.pizzaback.domain.model.PedidoDetalle;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class PedidoMapper {
    
    private final IngredienteMapper ingredienteMapper;
    
    public PedidoDTO toDTO(Pedido pedido) {
        if (pedido == null) return null;
        
        return PedidoDTO.builder()
                .id(pedido.getId())
                .usuarioId(pedido.getUsuario().getId())
                .usuarioNombre(pedido.getUsuario().getNombre() + " " + pedido.getUsuario().getApellido())
                .repartidorId(pedido.getRepartidor() != null ? pedido.getRepartidor().getId() : null)
                .repartidorNombre(pedido.getRepartidor() != null ? 
                        pedido.getRepartidor().getUsuario().getNombre() : null)
                .estadoNombre(pedido.getEstado().getNombre())
                .direccionEntrega(pedido.getDireccionEntrega())
                .telefonoContacto(pedido.getTelefonoContacto())
                .subtotal(pedido.getSubtotal())
                .costoEnvio(pedido.getCostoEnvio())
                .total(pedido.getTotal())
                .notas(pedido.getNotas())
                .fechaPedido(pedido.getFechaPedido())
                .fechaEntregaEstimada(pedido.getFechaEntregaEstimada())
                .fechaEntregaReal(pedido.getFechaEntregaReal())
                .detalles(pedido.getDetalles().stream()
                        .map(this::toDetalleDTO)
                        .collect(Collectors.toList()))
                .build();
    }
    
    public PedidoDetalleDTO toDetalleDTO(PedidoDetalle detalle) {
        if (detalle == null) return null;
        
        return PedidoDetalleDTO.builder()
                .id(detalle.getId())
                .pizzaId(detalle.getPizza() != null ? detalle.getPizza().getId() : null)
                .pizzaNombre(detalle.getPizza() != null ? detalle.getPizza().getNombre() : null)
                .comboId(detalle.getCombo() != null ? detalle.getCombo().getId() : null)
                .comboNombre(detalle.getCombo() != null ? detalle.getCombo().getNombre() : null)
                .cantidad(detalle.getCantidad())
                .precioUnitario(detalle.getPrecioUnitario())
                .subtotal(detalle.getSubtotal())
                .notas(detalle.getNotas())
                .ingredientesPersonalizados(detalle.getIngredientesPersonalizados().stream()
                        .map(ingredienteMapper::toDTO)
                        .collect(Collectors.toSet()))
                .build();
    }
}
