package com.leszekszymaszek.controller;

import com.leszekszymaszek.entity.User;
import com.leszekszymaszek.service.UserService;
import com.leszekszymaszek.user.CrmUser;
import com.leszekszymaszek.utils.AttributeNames;
import com.leszekszymaszek.utils.Mappings;
import com.leszekszymaszek.utils.MessagesForUser;
import com.leszekszymaszek.utils.ViewNames;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Slf4j
@Controller
@RequestMapping(Mappings.REGISTER)
public class RegistrationController {
	
    // == FIELDS ==
    private final UserService userService;

    // == CONSTRUCTORS ==
	@Autowired
	public RegistrationController (UserService userService) {
		this.userService = userService;
	}

	// == PUBLIC METHODS ==
	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		
		StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
		
		dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
	}

	// == HANDLER METHODS ==

	// == showing registration form ==
	@GetMapping(Mappings.SHOW_REGISTRATION_FORM)
	public String showMyLoginPage(Model model) {
		
		model.addAttribute(AttributeNames.CRM_USER, new CrmUser());
		
		return ViewNames.REGISTRATION_FORM;
	}

	// == processing registration form ==
	@PostMapping(Mappings.PROCESS_REGISTRATION_FORM)
	public String processRegistrationForm(
				@Valid @ModelAttribute(AttributeNames.CRM_USER) CrmUser crmUser,
				BindingResult theBindingResult,
				Model model) {
		
		String userName = crmUser.getUserName();
		log.info("Processing registration form for: ()", userName);
		
		// form validation
		 if (theBindingResult.hasErrors()){
			 return ViewNames.REGISTRATION_FORM;
		 }

		// check the database if user already exists
		//by username
        User existing = userService.findByUserName(userName);
        if (existing != null){
        	model.addAttribute(AttributeNames.CRM_USER, new CrmUser());
			model.addAttribute(AttributeNames.REGISTRATION_ERROR, MessagesForUser.USERNAME_EXIST);

			log.warn("User name already exists.");
        	return ViewNames.REGISTRATION_FORM;
        }

        //by email
        existing = userService.findByUserEmail(crmUser.getEmail());
		if (existing != null){
			model.addAttribute(AttributeNames.CRM_USER, new CrmUser());
			model.addAttribute(AttributeNames.REGISTRATION_ERROR, MessagesForUser.USER_EMAIL_EXIST);

			log.warn("User email already exists.");
			return ViewNames.REGISTRATION_FORM;
		}

     	// create user account
        userService.save(crmUser);
        
        log.info("Successfully created user: {}", userName);
        
        return ViewNames.REGISTRATION_CONFIRMATION;
	}
}
