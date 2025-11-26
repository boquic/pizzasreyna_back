package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PedidoEstadoDTO {
    private Long pedidoId;
    private String estadoNombre;
    private String estadoDescripcion;
    private LocalDateTime fechaCambio;
    private String comentario;
}
