package com.leszekszymaszek.user;

import com.leszekszymaszek.validation.FieldMatch;
import com.leszekszymaszek.validation.ValidEmail;
import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@FieldMatch.List({
    @FieldMatch(first = "password", second = "matchingPassword", message = "The password fields must match")
})
@Data
public class CrmUser {

	// == FIELDS ==
	@NotNull(message = "is required")
	@Size(min = 1, message = "is required")
	private String userName;

	@NotNull(message = "is required")
	@Size(min = 5, message = "must be at least 5 characters long")
	private String password;

	@NotNull(message = "is required")
	@Size(min = 5, message = "must be at least 5 characters long")
	private String matchingPassword;

	@NotNull(message = "is required")
	@Size(min = 1, message = "is required")
	private String firstName;

	@NotNull(message = "is required")
	@Size(min = 1, message = "is required")
	private String lastName;

	@ValidEmail
	@NotNull(message = "is required")
	@Size(min = 1, message = "is required")
	private String email;

	// == CONSTRUCTORS ==
	public CrmUser () {

	}
}