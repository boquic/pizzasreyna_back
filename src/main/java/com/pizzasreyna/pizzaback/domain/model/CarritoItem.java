package com.pizzasreyna.pizzaback.domain.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "carrito_item")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CarritoItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "carrito_id", nullable = false)
    private Carrito carrito;

    @ManyToOne
    @JoinColumn(name = "pizza_id")
    private Pizza pizza;

    @ManyToOne
    @JoinColumn(name = "combo_id")
    private Combo combo;

    @Column(nullable = false)
    private Integer cantidad = 1;

    @Column(columnDefinition = "TEXT")
    private String notas;

    @ManyToMany
    @JoinTable(
        name = "carrito_item_ingrediente",
        joinColumns = @JoinColumn(name = "carrito_item_id"),
        inverseJoinColumns = @JoinColumn(name = "ingrediente_id")
    )
    @Builder.Default
    private Set<Ingrediente> ingredientesPersonalizados = new HashSet<>();

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
