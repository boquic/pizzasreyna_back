package com.pizzasreyna.pizzaback.domain.repository;

import com.pizzasreyna.pizzaback.domain.model.Ingrediente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface IngredienteRepository extends JpaRepository<Ingrediente, Long> {
    List<Ingrediente> findByDisponibleTrue();
}
