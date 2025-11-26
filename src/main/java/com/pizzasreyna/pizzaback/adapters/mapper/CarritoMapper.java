package com.pizzasreyna.pizzaback.adapters.mapper;

import com.pizzasreyna.pizzaback.adapters.dto.CarritoDTO;
import com.pizzasreyna.pizzaback.adapters.dto.CarritoItemDTO;
import com.pizzasreyna.pizzaback.domain.model.Carrito;
import com.pizzasreyna.pizzaback.domain.model.CarritoItem;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import java.math.BigDecimal;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class CarritoMapper {
    
    private final IngredienteMapper ingredienteMapper;
    
    public CarritoDTO toDTO(Carrito carrito) {
        if (carrito == null) return null;
        
        var items = carrito.getItems().stream()
                .map(this::toItemDTO)
                .collect(Collectors.toList());
        
        BigDecimal total = items.stream()
                .map(CarritoItemDTO::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        return CarritoDTO.builder()
                .id(carrito.getId())
                .usuarioId(carrito.getUsuario().getId())
                .items(items)
                .total(total)
                .build();
    }
    
    public CarritoItemDTO toItemDTO(CarritoItem item) {
        if (item == null) return null;
        
        BigDecimal precioUnitario = BigDecimal.ZERO;
        String nombre = "";
        
        if (item.getPizza() != null) {
            precioUnitario = item.getPizza().getPrecioBase();
            nombre = item.getPizza().getNombre();
            
            // Agregar precio de ingredientes personalizados
            if (item.getIngredientesPersonalizados() != null) {
                precioUnitario = precioUnitario.add(
                    item.getIngredientesPersonalizados().stream()
                        .map(ing -> ing.getPrecioAdicional())
                        .reduce(BigDecimal.ZERO, BigDecimal::add)
                );
            }
        } else if (item.getCombo() != null) {
            precioUnitario = item.getCombo().getPrecio();
            nombre = item.getCombo().getNombre();
        }
        
        BigDecimal subtotal = precioUnitario.multiply(BigDecimal.valueOf(item.getCantidad()));
        
        return CarritoItemDTO.builder()
                .id(item.getId())
                .pizzaId(item.getPizza() != null ? item.getPizza().getId() : null)
                .pizzaNombre(item.getPizza() != null ? item.getPizza().getNombre() : null)
                .comboId(item.getCombo() != null ? item.getCombo().getId() : null)
                .comboNombre(item.getCombo() != null ? item.getCombo().getNombre() : null)
                .cantidad(item.getCantidad())
                .precioUnitario(precioUnitario)
                .subtotal(subtotal)
                .notas(item.getNotas())
                .ingredientesPersonalizados(item.getIngredientesPersonalizados().stream()
                        .map(ingredienteMapper::toDTO)
                        .collect(Collectors.toSet()))
                .build();
    }
}
