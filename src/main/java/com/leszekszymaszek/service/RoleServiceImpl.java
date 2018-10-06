package com.leszekszymaszek.service;

import com.leszekszymaszek.dao.RoleDao;
import com.leszekszymaszek.entity.Role;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
public class RoleServiceImpl implements RoleService {

    private final RoleDao roleDao;

    @Autowired
    public RoleServiceImpl (RoleDao roleDao) {
        this.roleDao = roleDao;
    }

    @Override
    @Transactional
    public Role findRoleByName (String roleName) {
        return roleDao.findRoleByName(roleName);
    }

    @Override
    @Transactional
    public Role findRoleById (Long id) {
        return roleDao.findRoleById(id);
    }
}
