package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;
import java.math.BigDecimal;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CarritoDTO {
    private Long id;
    private Long usuarioId;
    private List<CarritoItemDTO> items;
    private BigDecimal total;
}
