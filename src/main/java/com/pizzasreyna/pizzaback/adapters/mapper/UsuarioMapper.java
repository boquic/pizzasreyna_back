package com.pizzasreyna.pizzaback.adapters.mapper;

import com.pizzasreyna.pizzaback.adapters.dto.UsuarioDTO;
import com.pizzasreyna.pizzaback.domain.model.Usuario;
import org.springframework.stereotype.Component;

@Component
public class UsuarioMapper {
    
    public UsuarioDTO toDTO(Usuario usuario) {
        if (usuario == null) return null;
        
        return UsuarioDTO.builder()
                .id(usuario.getId())
                .nombre(usuario.getNombre())
                .apellido(usuario.getApellido())
                .email(usuario.getEmail())
                .telefono(usuario.getTelefono())
                .direccion(usuario.getDireccion())
                .rol(usuario.getRol().getNombre())
                .activo(usuario.getActivo())
                .build();
    }
}
