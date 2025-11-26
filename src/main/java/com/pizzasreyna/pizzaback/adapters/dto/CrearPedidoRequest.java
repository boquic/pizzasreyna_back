package com.pizzasreyna.pizzaback.adapters.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CrearPedidoRequest {
    @NotBlank(message = "La dirección de entrega es obligatoria")
    private String direccionEntrega;

    @NotBlank(message = "El teléfono de contacto es obligatorio")
    private String telefonoContacto;

    private String notas;

    @NotEmpty(message = "El pedido debe tener al menos un item")
    private List<ItemPedidoRequest> items;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ItemPedidoRequest {
        private Long pizzaId;
        private Long comboId;
        private Integer cantidad;
        private String notas;
        private List<Long> ingredientesPersonalizadosIds;
    }
}
