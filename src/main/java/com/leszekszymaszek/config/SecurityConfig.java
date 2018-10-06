package com.leszekszymaszek.config;

import com.leszekszymaszek.service.UserService;
import com.leszekszymaszek.utils.Mappings;
import com.leszekszymaszek.utils.UserRoleNames;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	//a reference to our security data source
    @Autowired
    private UserService userService;
    
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authenticationProvider());
    }
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.authorizeRequests()
//			.antMatchers("/").hasRole(UserRoleNames.USER) // uncomment will force login on root "/"
			.antMatchers(Mappings.LOGIN + "/**").anonymous()
			.antMatchers(Mappings.LOGOUT + "/**").hasAnyRole(UserRoleNames.USER, UserRoleNames.ADMIN)
			.antMatchers(Mappings.POST_COMMENT + "/**").hasAnyRole(UserRoleNames.USER, UserRoleNames.ADMIN)
			.antMatchers(Mappings.DELETE_COMMENT + "/**").hasAnyRole(UserRoleNames.USER, UserRoleNames.ADMIN)
			.antMatchers("/" + Mappings.ADD_BIKE + "/**").hasRole(UserRoleNames.ADMIN)
			.antMatchers("/" + Mappings.DELETE_BIKE).hasRole(UserRoleNames.ADMIN)
			.antMatchers(Mappings.SYSTEMS + "/**").hasRole(UserRoleNames.ADMIN)
			.and()
			.formLogin()
				.loginPage(Mappings.LOGIN)
				.usernameParameter("username")
				.passwordParameter("password")
				.loginProcessingUrl(Mappings.AUTHENTICATE_USER)
				.successHandler(successHandler())
				.permitAll()
			.and()
			.logout().permitAll()
			.and()
			.exceptionHandling().accessDeniedPage(Mappings.ACCESS_DENIED);
		
	}
	
	//beans
	//bcrypt bean definition
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	//authenticationProvider bean definition
	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider auth = new DaoAuthenticationProvider();
		auth.setUserDetailsService(userService); //set the custom user details service
		auth.setPasswordEncoder(passwordEncoder()); //set the password encoder - bcrypt
		return auth;
	}
	// success handler bean
	@Bean
	public AuthenticationSuccessHandler successHandler() {
		return new MyCustomLoginSuccessHandler("/" + Mappings.BIKES);
	}
	  
}






