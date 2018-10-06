package com.leszekszymaszek.controller;

import com.leszekszymaszek.entity.Role;
import com.leszekszymaszek.entity.User;
import com.leszekszymaszek.service.RoleService;
import com.leszekszymaszek.service.UserService;
import com.leszekszymaszek.utils.AttributeNames;
import com.leszekszymaszek.utils.Mappings;
import com.leszekszymaszek.utils.MessagesForUser;
import com.leszekszymaszek.utils.ViewNames;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Controller
public class UserController {

    // == FIELS ==
    private final RoleService roleService;
    private final UserService userService;

    // == CONSTRUCTORS ==
    @Autowired
    public UserController (RoleService roleService, UserService userService) {
        this.roleService = roleService;
        this.userService = userService;
    }

    // == HANDLER METHODS ==

    // == user profile ==
    @GetMapping(Mappings.USER_PROFILE)
    public String userProfile (@RequestParam String username, Model model) {

        //getting the user
        User user = userService.findByUserName(username);
        if(user == null) {
            model.addAttribute(AttributeNames.NO_USER, MessagesForUser.NO_USER);
            return ViewNames.USER_PROFILE;
        }
        log.info("user roles are {}", user.getRoles());

        //adding user to the model
        model.addAttribute(AttributeNames.USER, user);
        return ViewNames.USER_PROFILE;
    }

    // == showing users ==
    @GetMapping(Mappings.SYSTEMS + "/" + Mappings.SHOW_USERS)
    public String showUsers (Model model) {
        List<User> users = userService.showUsers();

        // getting admin role from db and adding it to the model.
        // It helps check, if user has an admin role
        // after check it will display a link to add an admin role to the user, if user is NOT an admin
        Role adminRole = roleService.findRoleByName("ROLE_ADMIN");

        model.addAttribute(AttributeNames.ADMIN_ROLE, adminRole);

        //adding users to the model
        model.addAttribute(AttributeNames.USERS, users);
        return ViewNames.ADMIN_PANEL;
    }

    // showing searched users
    @PostMapping(Mappings.SYSTEMS + "/" + Mappings.SHOW_USERS)
    public String showSearchedUsers (@RequestParam String searchString, Model model) {
        log.info("searching for users...");

        //getting proper users from db
        List<User> users = userService.findUsers(searchString);

        //flag
        boolean emptyUsersList = false;

        //checking if result list is empty, if it is adding an attribute
        if(users.isEmpty()) {
            emptyUsersList = true;
            model.addAttribute(AttributeNames.EMPTY_USERS_LIST, emptyUsersList);
        }

        log.info("users from searching are: {}", users);

        //getting admin role from db ad adding to the model
        Role adminRole = roleService.findRoleByName("ROLE_ADMIN");
        model.addAttribute(AttributeNames.ADMIN_ROLE, adminRole);

        //adding found users to the model
        model.addAttribute(AttributeNames.USERS, users);
        return ViewNames.ADMIN_PANEL;
    }

    // == searching for users based on searchstring from search field in admin_panel.jsp
    @GetMapping(Mappings.SYSTEMS + "/" + Mappings.DELETE_USER)
    public String deleteUser (@RequestParam Long id, Model model) {

        //getting a user to delete - his name
        User userToDelete = userService.findByUserId(id);
        String userToDeleteName = userToDelete.getUserName();

        // getting current logged in user name - currentPrincipalName
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentPrincipalName = authentication.getName();

        //if the user you want to delete is not you, you can delete him(even admin)
        if (!userToDeleteName.equals(currentPrincipalName)) {
            userService.delete(id);
            model.addAttribute(AttributeNames.DELETE_SUCCESS, userToDeleteName + MessagesForUser.USER_DELETED_SUCCESS);
        } else {
            model.addAttribute(AttributeNames.DELETE_ERROR, MessagesForUser.CANNOT_DELETE_YOURSELF);
        }
        return "redirect:" + Mappings.SYSTEMS + "/" + Mappings.SHOW_USERS;
    }

    // == making user an admin ==
    @GetMapping(Mappings.SYSTEMS + "/" + Mappings.MAKE_AN_ADMIN)
    public String makeAnAdmin (@RequestParam Long userId, Model model) {
        log.info("in make an admin method");

        User user = userService.findByUserId(userId);

        //giveUserAdminRole will return true if success
        if(userService.giveUserAdminRole(userId)) {
            model.addAttribute(AttributeNames.ADMIN_ADDED, MessagesForUser.NEW_ADMIN_ADDED + user.getUserName());
        } else {
            model.addAttribute(AttributeNames.ALREADY_ADMIN, user.getUserName() + MessagesForUser.ADMIN_ALREADY);
        }
        return "redirect:" + Mappings.SYSTEMS + "/" + Mappings.SHOW_USERS;
    }
}
