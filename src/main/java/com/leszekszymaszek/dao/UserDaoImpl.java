package com.leszekszymaszek.dao;

import com.leszekszymaszek.entity.Role;
import com.leszekszymaszek.entity.User;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.*;

@Slf4j
@Repository
public class UserDaoImpl implements UserDao {

	// == FIELDS ==
	private final SessionFactory sessionFactory;

	// == CONSTRUCTORS ==
	@Autowired
	public UserDaoImpl (SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	// == OVERRIDEN METHODS ==

	// == showing users ==
	@Override
	public List<User> showUsers () {
		// get the current hibernate session
		Session session = sessionFactory.getCurrentSession();

		//create query
		Query<User> query = session.createQuery("from User order by id");
		List<User> users = query.getResultList();

		log.info("all users are {}", users);
		return users;
	}

	// == showing users ==
	@Override
	public List<User> findUsers (String searchString) {
		// get the current hibernate session

		Session session = sessionFactory.getCurrentSession();

		//query
		Query<User> query = null;

		// only search by username, first name, last name or email, if searchingString is not empty
		if(searchString != null && searchString.trim().length() > 0) {
			query = session.createQuery("from User where lower(userName) like :searchString" +
					" or lower(firstName) like :searchString" +
					" or lower(lastName) like :searchString" +
					" or lower(email) like :searchString" +
					" order by id ASC", User.class);
			query.setParameter("searchString", "%" + searchString + "%");
		} else {
			query = session.createQuery("from User order by id", User.class);
		}

		List<User> foundUsers = query.getResultList();
		Map<User, Collection<Role>> usersWithRoles = new HashMap<>();
		for(User user: foundUsers) {
			usersWithRoles.put(user, user.getRoles());
			log.info("putting into map: " + user + " and " + user.getRoles());
		}
		return foundUsers;
	}

	// == giving admin role
	@Override
	public boolean giveUserAdminRole(Long userId) {
		// get the current hibernate session
		Session session = sessionFactory.getCurrentSession();

		// now retrieve/read from database using user id
		User user = null;
		try {
			user = session.get(User.class, userId);
		} catch (Exception e) {
			user = null;
		}

		//getting Admin role from database
		Role adminRole = session.get(Role.class, 2L);

		// adding admin role to user roles and save user
		Collection<Role> roles = user.getRoles();
		if(!roles.contains(adminRole)) {
			roles.add(adminRole);
			user.setRoles(roles);
			log.info("now roles are {}", roles);

			try {
				session.saveOrUpdate(user);
				log.info("user is {}", user);
			} catch(Exception e) {
				log.warn("Exception is {}", e.getMessage());
			}

			log.info("user saved as {}", user);
			return true;
		} else {
			log.warn("User is admin already");
			return false;
		}


	}

	@Override
	public User findByUserName(String userName) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// now retrieve/read from database using username
		Query<User> theQuery = currentSession.createQuery("from User where userName=:uName", User.class);
		theQuery.setParameter("uName", userName);
		User user = null;
		try {
			user = theQuery.getSingleResult();
			log.info("user for displaying profile is: {}", user);
		} catch (Exception e) {
			user = null;
		}

		return user;
	}

	@Override
	public User findByUserEmail(String email) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// now retrieve/read from database using email
		Query<User> query = currentSession.createQuery("from User where email=:uEmail", User.class);
		query.setParameter("uEmail", email);
		User user = null;
		try {
			user = query.getSingleResult();
		} catch (Exception e) {
			user = null;
		}

		return user;
	}

	@Override
	public User findByUserId (Long id) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// now retrieve/read from database using email
		Query<User> query = currentSession.createQuery("from User where id=:id", User.class);
		query.setParameter("id", id);
		User user = null;
		try {
			user = query.getSingleResult();
		} catch (Exception e) {
			user = null;
		}

		return user;
	}

	@Override
	public void save(User user) {
		// get current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// create the user
		currentSession.saveOrUpdate(user);
	}

	@Override
	public void delete (Long id) {
		// get current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// deleteComment object with primary key
		Query query = currentSession.createQuery("delete from User where id =:id");
		query.setParameter("id", id);

		query.executeUpdate();
	}
}
