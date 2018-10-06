package com.leszekszymaszek.dao;

import com.leszekszymaszek.entity.Comment;
import com.leszekszymaszek.entity.User;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@Slf4j
public class CommentDaoImpl implements CommentDao {

    // == FIELDS ==
    private final SessionFactory sessionFactory;

    // == CONSTRUCTORS ==
    @Autowired
    public CommentDaoImpl (SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }


    // == OVERRIDEN METHODS ==
    @Override
    public boolean addComment (Comment comment) {
        // get current hibernate session
        Session session = sessionFactory.getCurrentSession();

        //logs comment to be saved
        log.info("comment to save is: {}", comment);

        // save or update comment
        // flag = true if saveOrUpdate success
        boolean success = false;
        try {
            session.saveOrUpdate(comment);
            success = true;
        } catch (Exception e) {
            success = false;
        }
        return success;
    }

    @Override
    public boolean deleteComment (Comment comment) {
        // get current hibernate session
        Session session = sessionFactory.getCurrentSession();

        // delete comment
        // flag = true if saveOrUpdate success
        boolean success = false;
        try {
            session.delete(comment);
            success = true;
        } catch (Exception e) {
            success = false;
        }
        return success;
    }

    @Override
    public Comment getCommentById (Long id) {
        // get current hibernate session
        Session session = sessionFactory.getCurrentSession();

        //create query
        Query<Comment> query = session.createQuery("from Comment where id=:id");
        query.setParameter("id", id);

        Comment comment = query.getSingleResult();
        return comment;
    }

    @Override
    public User getUserForComment (Comment comment) {

        // get current hibernate session
        Session currentSession = sessionFactory.getCurrentSession();

        //query
        Query<User> query = currentSession.createQuery("select username from Comment c " +
                "inner join User on Comment.userId = User.Id where Comment.id =: commentId");
        query.setParameter("commentId", comment.getId());
        return query.getSingleResult();
    }
}
