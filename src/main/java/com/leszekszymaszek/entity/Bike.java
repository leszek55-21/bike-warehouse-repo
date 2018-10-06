package com.leszekszymaszek.entity;

import com.leszekszymaszek.dao.BikeDaoImpl;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.springframework.format.annotation.DateTimeFormat;


import javax.persistence.*;
import javax.validation.constraints.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.Collection;

@Data
@EqualsAndHashCode(of = "id")
@Entity
@Table(name = BikeDaoImpl.TABLE_NAME, schema = "web_bike_warehouse")
public class Bike implements Serializable {

    // == FIELDS ==
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = BikeDaoImpl.COL_ID)
    private Long id;

    @NotBlank(message = "brand is required")
    @Size(min = 2, max = 20, message = "brand needs to have minimum 2, or maximum 20 characters long")
    @Column(name = BikeDaoImpl.COL_BRAND)
    private String brand;

    @NotBlank(message = "model is required")
    @NotNull(message = "model is required")
    @Size(min = 1, max = 20, message = "model needs to have minimum 1, or maximum 20 character long")
    @Column(name = BikeDaoImpl.COL_MODEL)
    private String model;

    @NotBlank(message = "please choose bike type")
    @Column(name = BikeDaoImpl.COL_TYPE)
    private String type;

    @Size(max = 1000, message = "can't be longer than 1000 character long")
    @Column(name = BikeDaoImpl.COL_DETAILS)
    private String details;

    @Size(max = 400, message = "can't be longer than 400 character long")
    @Column(name = BikeDaoImpl.COL_IMAGE_URL)
    private String imageUrl;

    @DateTimeFormat(pattern = "dd.MM.yyyy")
    @Column(name = BikeDaoImpl.COL_IN_STOCK_FROM)
    private LocalDate inStockFrom;

    @DecimalMax(value = "100000", message = "Price must be lower than ${value}")
    @DecimalMin(value = "0.00", message = "Price cannot be negative")
    @Digits(integer = 7 /*precision*/,
            fraction = 2 /*scale*/,
            message = "Incorrect price format")
    @Column(name = BikeDaoImpl.COL_PRICE)
    private double price;

    @Min(value = 0, message = "Stock quantity cannot be negative")
    @DecimalMax(value = "10000", message = "Quantity cannot be higher than ${value}")
    @Column(name = BikeDaoImpl.COL_QUANTITY_IN_STOCK)
    private int quantityInStock;

    @ToString.Exclude
    @OneToMany(mappedBy = "bike", cascade = CascadeType.ALL)
    @Fetch(FetchMode.JOIN)
    private Collection<Comment> comments;


    // == CONSTRUCTORS ==
    public Bike (String brand, String model, String type, String imageUrl, LocalDate inStockFrom, double price,
                 int quantityInStock, String details) {
        this.brand = brand;
        this.model = model;
        this.type = type;
        this.imageUrl = imageUrl;
        this.inStockFrom = inStockFrom;
        this.price = price;
        this.quantityInStock = quantityInStock;
        this.details = details;
    }

    public Bike() {}
}
