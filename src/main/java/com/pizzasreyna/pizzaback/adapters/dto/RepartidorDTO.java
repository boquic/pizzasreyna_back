package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;
import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RepartidorDTO {
    private Long id;
    private Long usuarioId;
    private String usuarioNombre;
    private String vehiculo;
    private String placa;
    private Boolean disponible;
    private BigDecimal latitud;
    private BigDecimal longitud;
}
