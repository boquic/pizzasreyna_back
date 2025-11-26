package com.pizzasreyna.pizzaback.domain.repository;

import com.pizzasreyna.pizzaback.domain.model.Pedido;
import com.pizzasreyna.pizzaback.domain.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PedidoRepository extends JpaRepository<Pedido, Long> {
    List<Pedido> findByUsuarioOrderByFechaPedidoDesc(Usuario usuario);
    List<Pedido> findByEstado_NombreOrderByFechaPedidoDesc(String estadoNombre);
}
