package com.leszekszymaszek.controller;

import com.leszekszymaszek.utils.AttributeNames;
import com.leszekszymaszek.utils.Mappings;
import com.leszekszymaszek.utils.ViewNames;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Controller
public class LoginAndAuthController {

	// == HANDLER METHODS ==

	// == home "/" ==
	@GetMapping(Mappings.HOME)
	public String showHome() {

		return ViewNames.HOME;
	}

	// request mapping for /systems
	@GetMapping(Mappings.SYSTEMS)
	public String showSystems() {

		return ViewNames.ADMIN_PANEL;
	}

	// == login ==
	@GetMapping(Mappings.LOGIN)
	public String showMyLoginPage(HttpServletRequest servletRequest) {

		//getting last url before login
		String referrer = servletRequest.getHeader("Referer");
		log.info("referer is {}", referrer);

		// checking if login is not after registration complete
		if(referrer == null || referrer.contains(Mappings.PROCESS_REGISTRATION_FORM) || referrer.contains(Mappings.LOGIN)) {
			//getting root
			String rootUrl = servletRequest.getRequestURL().toString().replace(servletRequest.getRequestURI(), servletRequest.getContextPath());
			referrer = rootUrl;
		}

		log.info("url prior login is {}", referrer);

		//adding prior login url string as a session attribute
		servletRequest.getSession().setAttribute(AttributeNames.URL_PRIOR_LOGIN, referrer);

		return ViewNames.LOGIN_PAGE;

	}

	// == access denied ==
	@GetMapping(Mappings.ACCESS_DENIED)
	public String showAccessDenied() {
		
		return ViewNames.ACCESS_DENIED;
		
	}
	
}









