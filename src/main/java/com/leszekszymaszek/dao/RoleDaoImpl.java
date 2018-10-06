package com.leszekszymaszek.dao;

import com.leszekszymaszek.entity.Role;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RoleDaoImpl implements RoleDao {

	// == FIELDS ==
	private SessionFactory sessionFactory;

	// == CONSTRUCTORS ==
	@Autowired
	public RoleDaoImpl (SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	// == OVERRIDEN METHODS ==
	@Override
	public Role findRoleByName(String roleName) {

		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// now retrieve/read from database using name
		Query<Role> query = currentSession.createQuery("from Role where name=:roleName", Role.class);
		query.setParameter("roleName", roleName);
		
		Role role = null;
		
		try {
			role = query.getSingleResult();
		} catch (Exception e) {
			role = null;
		}

		return role;
	}

	@Override
	public Role findRoleById (Long id) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// now retrieve/read from database using name
		Query<Role> query = currentSession.createQuery("from Role where id=:id", Role.class);
		query.setParameter("id", id);

		Role role = null;

		try {
			role = query.getSingleResult();
		} catch (Exception e) {
			role = null;
		}

		return role;
	}
}
