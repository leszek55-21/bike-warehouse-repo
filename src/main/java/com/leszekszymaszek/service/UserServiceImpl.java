package com.leszekszymaszek.service;

import com.leszekszymaszek.dao.CommentDao;
import com.leszekszymaszek.dao.RoleDao;
import com.leszekszymaszek.dao.UserDao;
import com.leszekszymaszek.entity.Role;
import com.leszekszymaszek.entity.User;
import com.leszekszymaszek.user.CrmUser;
import com.leszekszymaszek.utils.UserRoleNames;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {

	// == FIELDS ==

	private final UserDao userDao;
	private final RoleDao roleDao;
	private final CommentDao commentDao;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	// == CONSTRUCTORS ==

	@Autowired
	public UserServiceImpl (UserDao userDao, RoleDao roleDao, CommentDao commentDao) {
		this.userDao = userDao;
		this.roleDao = roleDao;
		this.commentDao = commentDao;
	}

	// == PUBLIC METHODS ==
	@Override
	@Transactional
	public List<User> showUsers () {
		return userDao.showUsers();
	}

	@Override
	@Transactional
	public boolean giveUserAdminRole(Long userId) {
		return userDao.giveUserAdminRole(userId);
	}

	@Override
	@Transactional
	public List<User> findUsers (String searchString) {
		return userDao.findUsers(searchString);
	}

	@Override
	@Transactional
	public User findByUserName(String userName) {
		return userDao.findByUserName(userName);
	}

	@Override
	@Transactional
	public User findByUserEmail(String email) {
		return userDao.findByUserEmail(email);
	}

	@Override
	@Transactional
	public User findByUserId (Long id) {
		return userDao.findByUserId(id);
	}

	@Override
	@Transactional
	public void save(CrmUser crmUser) {
		User user = new User();
		 // assign user details to the user object
		user.setUserName(crmUser.getUserName());
		user.setPassword(passwordEncoder.encode(crmUser.getPassword()));
		user.setFirstName(crmUser.getFirstName());
		user.setLastName(crmUser.getLastName());
		user.setEmail(crmUser.getEmail());


		// give user default role of "user"
		user.setRoles(Arrays.asList(roleDao.findRoleByName("ROLE_" + UserRoleNames.USER)));

		// save user in the database
		userDao.save(user);
	}

	@Override
	@Transactional
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		User user = userDao.findByUserName(userName);
		if (user == null) {
			throw new UsernameNotFoundException("Invalid username or password.");
		}
		return new org.springframework.security.core.userdetails.User(user.getUserName(), user.getPassword(),
				mapRolesToAuthorities(user.getRoles()));
	}

	@Override
	@Transactional
	public void delete (Long id) {
		userDao.delete(id);
	}

	private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Collection<Role> roles) {
		return roles.stream().map(role -> new SimpleGrantedAuthority(role.getName())).collect(Collectors.toList());
	}
}
