package com.leszekszymaszek.dao;

import com.leszekszymaszek.entity.Role;

public interface RoleDao {

	Role findRoleByName (String roleName);

	Role findRoleById (Long id);
	
}
