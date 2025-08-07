package com.service.spring.controller;

import java.time.LocalDate;
import java.util.List;

import com.service.spring.domain.Member;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.service.spring.domain.Account;
import com.service.spring.service.AccountService;

@Controller
public class AccountController {
	
	@Autowired
	private AccountService accountService;
	
	@GetMapping("/account")
	public String moveAccount(HttpSession session, Model model) {
		if ((Member)session.getAttribute("member") == null)
			return "pages/member/login";

		model.addAttribute("currentMenu", "account");
		return "pages/account/account";
	}
}





