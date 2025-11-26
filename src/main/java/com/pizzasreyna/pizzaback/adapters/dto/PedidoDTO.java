package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PedidoDTO {
    private Long id;
    private Long usuarioId;
    private String usuarioNombre;
    private Long repartidorId;
    private String repartidorNombre;
    private String estadoNombre;
    private String direccionEntrega;
    private String telefonoContacto;
    private BigDecimal subtotal;
    private BigDecimal costoEnvio;
    private BigDecimal total;
    private String notas;
    private LocalDateTime fechaPedido;
    private LocalDateTime fechaEntregaEstimada;
    private LocalDateTime fechaEntregaReal;
    private List<PedidoDetalleDTO> detalles;
}
