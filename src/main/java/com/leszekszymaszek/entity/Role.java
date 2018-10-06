package com.leszekszymaszek.entity;

import lombok.Data;
import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "role")
public class Role implements Serializable {

    // == FIELDS ==
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "name")
	private String name;

    // == CONSTRUCTORS ==
	public Role () {
	}

	public Role (String name) {
		this.name = name;
	}

}