package com.leszekszymaszek.service;

import com.leszekszymaszek.entity.Role;

public interface RoleService {

    Role findRoleByName (String roleName);

    Role findRoleById (Long id);
}
