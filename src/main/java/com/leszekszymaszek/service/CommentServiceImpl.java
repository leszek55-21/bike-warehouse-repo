package com.leszekszymaszek.service;

import com.leszekszymaszek.dao.CommentDao;
import com.leszekszymaszek.entity.Comment;

import com.leszekszymaszek.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CommentServiceImpl implements CommentService {

    // == FILEDS ==
    private final CommentDao commentDao;

    // == CONSTRUCTORS ==
    @Autowired
    public CommentServiceImpl (CommentDao commentDao) {
        this.commentDao = commentDao;
    }

    // == OVERRIDEN METHODS ==
    @Transactional
    @Override
    public boolean addComment (Comment comment) {
        return commentDao.addComment(comment);
    }

    @Transactional
    @Override
    public boolean deleteComment (Comment comment) {
        return commentDao.deleteComment(comment);
    }

    @Transactional
    @Override
    public Comment getCommentById (Long id) {
        return commentDao.getCommentById(id);
    }

    @Transactional
    @Override
    public User getUserForComment(Comment comment){
        return commentDao.getUserForComment(comment);
    }

}
