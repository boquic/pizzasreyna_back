package com.pizzasreyna.pizzaback.application.service;

import com.pizzasreyna.pizzaback.adapters.dto.PizzaDTO;
import com.pizzasreyna.pizzaback.adapters.mapper.PizzaMapper;
import com.pizzasreyna.pizzaback.domain.model.Pizza;
import com.pizzasreyna.pizzaback.domain.repository.PizzaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PizzaService {

    private final PizzaRepository pizzaRepository;
    private final PizzaMapper pizzaMapper;

    @Transactional(readOnly = true)
    public List<PizzaDTO> obtenerTodasPizzas() {
        return pizzaRepository.findAll().stream()
                .map(pizzaMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<PizzaDTO> obtenerPizzasDisponibles() {
        return pizzaRepository.findByDisponibleTrue().stream()
                .map(pizzaMapper::toDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public PizzaDTO obtenerPizza(Long id) {
        Pizza pizza = pizzaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pizza no encontrada"));
        return pizzaMapper.toDTO(pizza);
    }

    @Transactional
    public PizzaDTO crearPizza(Pizza pizza) {
        pizza = pizzaRepository.save(pizza);
        return pizzaMapper.toDTO(pizza);
    }

    @Transactional
    public PizzaDTO actualizarPizza(Long id, Pizza pizzaActualizada) {
        Pizza pizza = pizzaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pizza no encontrada"));

        pizza.setNombre(pizzaActualizada.getNombre());
        pizza.setDescripcion(pizzaActualizada.getDescripcion());
        pizza.setPrecioBase(pizzaActualizada.getPrecioBase());
        pizza.setTamanio(pizzaActualizada.getTamanio());
        pizza.setDisponible(pizzaActualizada.getDisponible());
        pizza.setImagenUrl(pizzaActualizada.getImagenUrl());
        pizza.setIngredientes(pizzaActualizada.getIngredientes());

        pizza = pizzaRepository.save(pizza);
        return pizzaMapper.toDTO(pizza);
    }

    @Transactional
    public void eliminarPizza(Long id) {
        pizzaRepository.deleteById(id);
    }
}
