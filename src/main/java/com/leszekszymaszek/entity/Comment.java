package com.leszekszymaszek.entity;


import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@EqualsAndHashCode(of = "id")
@Entity
@Table(name = "comment", schema = "web_bike_warehouse")
public class Comment implements Serializable, Comparable {

    // == FIELDS ==

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name="content")
    private String content;

    @Column(name = "user_id")
    private Long userId;

    @Column(name = "bike_id")
    private Long bikeId;

    @Column(name= "created_at")
    private LocalDateTime createdAt;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.PERSIST, CascadeType.DETACH,
    CascadeType.MERGE, CascadeType.REFRESH})
    @JoinTable(name = "comments_bikes",
            joinColumns = @JoinColumn(name = "comment_id"),
            inverseJoinColumns = @JoinColumn(name = "bike_id"))
    private Bike bike;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.PERSIST, CascadeType.DETACH,
            CascadeType.MERGE, CascadeType.REFRESH})
    @JoinTable(name = "comments_users",
            joinColumns = @JoinColumn(name = "comment_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id"))
    private User user;

    // == CONSTRUCTORS ==
    public Comment() {}

    public Comment (String content) {
        this.content = content;
    }

    public Comment (String content, Long userId, Long bikeId, LocalDateTime createdAt) {
        this.content = content;
        this.userId = userId;
        this.bikeId = bikeId;
        this.createdAt = createdAt;
    }

    public Comment (Long id, @NotBlank(message = "you can't post empty comment") String content, Long userId, Long bikeId, LocalDateTime createdAt, Bike bike, User user) {
        this.id = id;
        this.content = content;
        this.userId = userId;
        this.bikeId = bikeId;
        this.createdAt = createdAt;
        this.bike = bike;
        this.user = user;
    }

    //comment will be compared on crearedAt
    @Override
    public int compareTo (Object o) {
        return this.getCreatedAt().compareTo(((Comment)o).getCreatedAt());
    }
}
