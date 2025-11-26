package com.pizzasreyna.pizzaback.application.service;

import com.pizzasreyna.pizzaback.adapters.dto.AgregarCarritoRequest;
import com.pizzasreyna.pizzaback.adapters.dto.CarritoDTO;
import com.pizzasreyna.pizzaback.adapters.mapper.CarritoMapper;
import com.pizzasreyna.pizzaback.domain.model.*;
import com.pizzasreyna.pizzaback.domain.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.HashSet;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class CarritoService {

    private final CarritoRepository carritoRepository;
    private final UsuarioRepository usuarioRepository;
    private final PizzaRepository pizzaRepository;
    private final ComboRepository comboRepository;
    private final IngredienteRepository ingredienteRepository;
    private final CarritoMapper carritoMapper;

    @Transactional
    public CarritoDTO agregarItem(String email, AgregarCarritoRequest request) {
        Usuario usuario = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        Carrito carrito = carritoRepository.findByUsuario(usuario)
                .orElseGet(() -> {
                    Carrito nuevoCarrito = Carrito.builder()
                            .usuario(usuario)
                            .build();
                    return carritoRepository.save(nuevoCarrito);
                });

        CarritoItem item = CarritoItem.builder()
                .carrito(carrito)
                .cantidad(request.getCantidad())
                .notas(request.getNotas())
                .build();

        if (request.getPizzaId() != null) {
            Pizza pizza = pizzaRepository.findById(request.getPizzaId())
                    .orElseThrow(() -> new RuntimeException("Pizza no encontrada"));
            item.setPizza(pizza);

            if (request.getIngredientesPersonalizadosIds() != null) {
                Set<Ingrediente> ingredientes = new HashSet<>(
                        ingredienteRepository.findAllById(request.getIngredientesPersonalizadosIds())
                );
                item.setIngredientesPersonalizados(ingredientes);
            }
        } else if (request.getComboId() != null) {
            Combo combo = comboRepository.findById(request.getComboId())
                    .orElseThrow(() -> new RuntimeException("Combo no encontrado"));
            item.setCombo(combo);
        } else {
            throw new RuntimeException("Debe especificar una pizza o un combo");
        }

        carrito.getItems().add(item);
        carrito = carritoRepository.save(carrito);

        return carritoMapper.toDTO(carrito);
    }

    @Transactional(readOnly = true)
    public CarritoDTO obtenerCarrito(String email) {
        Usuario usuario = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        Carrito carrito = carritoRepository.findByUsuario(usuario)
                .orElseGet(() -> Carrito.builder().usuario(usuario).build());

        return carritoMapper.toDTO(carrito);
    }

    @Transactional
    public void limpiarCarrito(String email) {
        Usuario usuario = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        carritoRepository.findByUsuario(usuario).ifPresent(carrito -> {
            carrito.getItems().clear();
            carritoRepository.save(carrito);
        });
    }
}
