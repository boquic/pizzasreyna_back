package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;
import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class IngredienteDTO {
    private Long id;
    private String nombre;
    private String descripcion;
    private BigDecimal precioAdicional;
    private Boolean disponible;
    private String imagenUrl;
}
