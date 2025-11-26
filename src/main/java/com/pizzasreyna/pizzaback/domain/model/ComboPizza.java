package com.pizzasreyna.pizzaback.domain.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "combo_pizza")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ComboPizza {
    @EmbeddedId
    private ComboPizzaId id;

    @ManyToOne
    @MapsId("comboId")
    @JoinColumn(name = "combo_id")
    private Combo combo;

    @ManyToOne
    @MapsId("pizzaId")
    @JoinColumn(name = "pizza_id")
    private Pizza pizza;

    @Column(nullable = false)
    private Integer cantidad = 1;

    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class ComboPizzaId implements java.io.Serializable {
        private Long comboId;
        private Long pizzaId;
    }
}
