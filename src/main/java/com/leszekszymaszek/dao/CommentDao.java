package com.leszekszymaszek.dao;

import com.leszekszymaszek.entity.Comment;
import com.leszekszymaszek.entity.User;

import java.util.List;

public interface CommentDao {

    boolean addComment (Comment comment);

    boolean deleteComment(Comment comment);

    Comment getCommentById(Long id);

    User getUserForComment(Comment comment);
}
