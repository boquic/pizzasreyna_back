package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;
import java.math.BigDecimal;
import java.util.Set;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PedidoDetalleDTO {
    private Long id;
    private Long pizzaId;
    private String pizzaNombre;
    private Long comboId;
    private String comboNombre;
    private Integer cantidad;
    private BigDecimal precioUnitario;
    private BigDecimal subtotal;
    private String notas;
    private Set<IngredienteDTO> ingredientesPersonalizados;
}
