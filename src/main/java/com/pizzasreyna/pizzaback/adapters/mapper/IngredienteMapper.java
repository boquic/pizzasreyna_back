package com.pizzasreyna.pizzaback.adapters.mapper;

import com.pizzasreyna.pizzaback.adapters.dto.IngredienteDTO;
import com.pizzasreyna.pizzaback.domain.model.Ingrediente;
import org.springframework.stereotype.Component;

@Component
public class IngredienteMapper {
    
    public IngredienteDTO toDTO(Ingrediente ingrediente) {
        if (ingrediente == null) return null;
        
        return IngredienteDTO.builder()
                .id(ingrediente.getId())
                .nombre(ingrediente.getNombre())
                .descripcion(ingrediente.getDescripcion())
                .precioAdicional(ingrediente.getPrecioAdicional())
                .disponible(ingrediente.getDisponible())
                .imagenUrl(ingrediente.getImagenUrl())
                .build();
    }
}
