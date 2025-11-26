package com.pizzasreyna.pizzaback.adapters.mapper;

import com.pizzasreyna.pizzaback.adapters.dto.PizzaDTO;
import com.pizzasreyna.pizzaback.domain.model.Pizza;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class PizzaMapper {
    
    private final IngredienteMapper ingredienteMapper;
    
    public PizzaDTO toDTO(Pizza pizza) {
        if (pizza == null) return null;
        
        return PizzaDTO.builder()
                .id(pizza.getId())
                .nombre(pizza.getNombre())
                .descripcion(pizza.getDescripcion())
                .precioBase(pizza.getPrecioBase())
                .tamanio(pizza.getTamanio().name())
                .disponible(pizza.getDisponible())
                .imagenUrl(pizza.getImagenUrl())
                .esPersonalizada(pizza.getEsPersonalizada())
                .ingredientes(pizza.getIngredientes().stream()
                        .map(ingredienteMapper::toDTO)
                        .collect(Collectors.toSet()))
                .build();
    }
}
