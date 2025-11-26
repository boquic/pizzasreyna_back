package com.pizzasreyna.pizzaback.domain.repository;

import com.pizzasreyna.pizzaback.domain.model.Carrito;
import com.pizzasreyna.pizzaback.domain.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface CarritoRepository extends JpaRepository<Carrito, Long> {
    Optional<Carrito> findByUsuario(Usuario usuario);
}
