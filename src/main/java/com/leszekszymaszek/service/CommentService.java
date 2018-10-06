package com.leszekszymaszek.service;

import com.leszekszymaszek.entity.Comment;
import com.leszekszymaszek.entity.User;

public interface CommentService {

    boolean addComment(Comment comment);

    boolean deleteComment(Comment comment);

    Comment getCommentById(Long id);

    User getUserForComment(Comment comment);


}
