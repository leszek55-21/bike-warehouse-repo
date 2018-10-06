package com.leszekszymaszek.dao;

import com.leszekszymaszek.entity.User;

import java.util.List;

public interface UserDao {

    List<User> showUsers ();

    boolean giveUserAdminRole(Long userId);

    List<User> findUsers(String searchString);

    User findByUserName (String userName);

    User findByUserEmail(String email);

    User findByUserId(Long id);

    void save (User user);

    void delete(Long id);
    
}
