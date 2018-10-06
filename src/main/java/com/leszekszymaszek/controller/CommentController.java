package com.leszekszymaszek.controller;

import com.leszekszymaszek.entity.Bike;
import com.leszekszymaszek.entity.Comment;
import com.leszekszymaszek.entity.Role;
import com.leszekszymaszek.entity.User;
import com.leszekszymaszek.service.BikeService;
import com.leszekszymaszek.service.CommentService;
import com.leszekszymaszek.service.UserService;
import com.leszekszymaszek.utils.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;

@Slf4j
@Controller
public class CommentController {

    // == FIELDS ==
    private final UserService userService;
    private final BikeService bikeService;
    private final CommentService commentService;

    // == CONSTRUCTORS ==
    @Autowired
    public CommentController (UserService userService, BikeService bikeService, CommentService commentService) {
        this.userService = userService;
        this.bikeService = bikeService;
        this.commentService = commentService;
    }

    // == HANDLER METHODS ==

    // == posting comment ==
    @PostMapping(Mappings.POST_COMMENT)
    public String postComment (@RequestParam("commentContent") String commentContent,
                               @RequestParam("bikeId") Long bikeId,
                               @RequestParam("userId") Long userId,
                               Model model) {

        // getting proper bike from bike table
        Bike bike = bikeService.getBike(bikeId);
        log.info("bike id param is {} ", userId);

        // getting proper user from user table
        User user = userService.findByUserId(userId);

        //creating comment
        Comment comment = new Comment();
        comment.setBike(bike);
        comment.setBikeId(bike.getId()); //there is no need to set bike id manually
        comment.setUser(user);
        comment.setUserId(userId); //there is no need to set user id manually
        comment.setCreatedAt(LocalDateTime.now());
        comment.setContent(commentContent);

        log.info("bike is {} ", bike);

        log.info("comment content is {} ", commentContent);
        log.info("comment is {} ", comment);

        // adding comment to the collection of bike comments
        bike.getComments().add(comment);
        log.info("bike comments are: {}", bike.getComments());

        // saving comment and data into join tables
        if(bikeService.addComment(comment)) {

            //adding attribute for flash message
            log.info("comment added to db");
            model.addAttribute(AttributeNames.COMMENT_ADDED, MessagesForUser.COMMENT_ADDED);
        }

        // adding some model attributes
        model.addAttribute("id", bike.getId());
        model.addAttribute("bike", bike);
        model.addAttribute("user", user);


        //getting username - must add Principal to method args
//        model.addAttribute("currentUser", principal.getName());
        return "redirect:/" + Mappings.VIEW_BIKE;
    }

    // == deleting comment ==
    @GetMapping(Mappings.DELETE_COMMENT)
    public String deleteComment (@RequestParam("commentId") Long id,
                                 @RequestParam(required = false, defaultValue = "") String commentAuthor,
                                 Model model) {

        //getting proper comment
        Comment comment = commentService.getCommentById(id);

        //getting bike for which comment belongs to
        Bike bike = bikeService.getBike(comment.getBikeId());

        // getting current logged in user name - currentPrincipalName
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentPrincipalName = authentication.getName();

        // getting current logged in user
        User loggedUser = userService.findByUserName(currentPrincipalName);

        log.info("current logged in user is: {}", loggedUser);

        //getting user for which comment belongs to
        User user = userService.findByUserId(comment.getUserId());

        //if user is deleted removing comment from bike
        if(user == null && hasAdminRole(loggedUser)) {

            // removing the comment from bike's comments list
            bike.getComments().remove(comment);
        }

        // checking if currently logged in user is comment author, or has a role of admin
        if (commentAuthor.equals(currentPrincipalName) || hasAdminRole(loggedUser)) {

            // removing the comment from bike's comments list
            bike.getComments().remove(comment);

            // removing the comment from users's comments list(if user exist)
            if(user != null) {
                user.getComments().remove(comment);
            }

            //deleting the comment and adding attribute for flash message
            if(commentService.deleteComment(comment)) {
                log.info("comment deleted from db");
                model.addAttribute(AttributeNames.COMMENT_DELETED, MessagesForUser.COMMENT_DELETED);
            }
            return "redirect:/" + Mappings.VIEW_BIKE + "?id=" + bike.getId();

        }
        return ViewNames.ACCESS_DENIED;
    }

    // == PRIVATE METHODS ==

    // checking if user has an admin role
    private boolean hasAdminRole (User user) {
        for (Role role : user.getRoles()) {
            if (role.getName().equals("ROLE_" + UserRoleNames.ADMIN)) {
                return true;
            }
        }
        return false;
    }
}
