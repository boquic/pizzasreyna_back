package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PagoDTO {
    private Long id;
    private Long pedidoId;
    private String metodoPago;
    private BigDecimal monto;
    private String estado;
    private String transaccionId;
    private LocalDateTime fechaPago;
}
