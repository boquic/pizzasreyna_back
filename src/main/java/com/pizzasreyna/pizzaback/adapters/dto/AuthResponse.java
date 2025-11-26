package com.pizzasreyna.pizzaback.adapters.dto;

import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuthResponse {
    private String token;
    private String refreshToken;
    private String tipo = "Bearer";
    private UsuarioDTO usuario;
}
