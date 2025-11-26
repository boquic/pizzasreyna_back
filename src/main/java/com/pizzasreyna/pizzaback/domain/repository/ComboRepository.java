package com.pizzasreyna.pizzaback.domain.repository;

import com.pizzasreyna.pizzaback.domain.model.Combo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ComboRepository extends JpaRepository<Combo, Long> {
    List<Combo> findByDisponibleTrue();
}
