package com.pizzasreyna.pizzaback.domain.repository;

import com.pizzasreyna.pizzaback.domain.model.Repartidor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface RepartidorRepository extends JpaRepository<Repartidor, Long> {
    List<Repartidor> findByDisponibleTrue();
}
