package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;
import java.math.BigDecimal;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ComboDTO {
    private Long id;
    private String nombre;
    private String descripcion;
    private BigDecimal precio;
    private BigDecimal descuento;
    private Boolean disponible;
    private String imagenUrl;
    private List<PizzaDTO> pizzas;
}
