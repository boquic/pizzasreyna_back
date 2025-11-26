package com.pizzasreyna.pizzaback.domain.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "pizza")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Pizza {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(columnDefinition = "TEXT")
    private String descripcion;

    @Column(name = "precio_base", nullable = false, precision = 10, scale = 2)
    private BigDecimal precioBase;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private TamanoPizza tamanio;

    @Column(nullable = false)
    private Boolean disponible = true;

    @Column(name = "imagen_url", length = 500)
    private String imagenUrl;

    @Column(name = "es_personalizada", nullable = false)
    private Boolean esPersonalizada = false;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "pizza_ingrediente",
        joinColumns = @JoinColumn(name = "pizza_id"),
        inverseJoinColumns = @JoinColumn(name = "ingrediente_id")
    )
    @Builder.Default
    private Set<Ingrediente> ingredientes = new HashSet<>();

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public enum TamanoPizza {
        PEQUEÑA, MEDIANA, GRANDE, FAMILIAR
    }
}
