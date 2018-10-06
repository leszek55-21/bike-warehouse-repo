package com.leszekszymaszek.service;

import com.leszekszymaszek.entity.User;
import com.leszekszymaszek.user.CrmUser;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {

    List<User> showUsers ();

    boolean giveUserAdminRole(Long userId);

    List<User> findUsers (String searchString);

    User findByUserName (String userName);

    User findByUserEmail(String email);

    User findByUserId(Long id);

    void save (CrmUser crmUser);

    void delete(Long id);
}
