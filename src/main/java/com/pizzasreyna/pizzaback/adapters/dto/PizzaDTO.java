package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;
import java.math.BigDecimal;
import java.util.Set;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PizzaDTO {
    private Long id;
    private String nombre;
    private String descripcion;
    private BigDecimal precioBase;
    private String tamanio;
    private Boolean disponible;
    private String imagenUrl;
    private Boolean esPersonalizada;
    private Set<IngredienteDTO> ingredientes;
}
