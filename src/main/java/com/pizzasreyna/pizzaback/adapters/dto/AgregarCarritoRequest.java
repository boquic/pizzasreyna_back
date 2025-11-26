package com.pizzasreyna.pizzaback.adapters.dto;

import jakarta.validation.constraints.Min;
import lombok.*;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AgregarCarritoRequest {
    private Long pizzaId;
    private Long comboId;
    
    @Min(value = 1, message = "La cantidad debe ser al menos 1")
    private Integer cantidad = 1;
    
    private String notas;
    private List<Long> ingredientesPersonalizadosIds;
}
