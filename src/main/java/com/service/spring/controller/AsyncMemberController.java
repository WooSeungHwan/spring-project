package com.service.spring.controller;

import com.service.spring.domain.Member;
import com.service.spring.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AsyncMemberController {
	
	@Autowired
	private MemberService memberService;

	@GetMapping("/check/email")
	public Boolean checkEmail(String email) {
        try {
            return memberService.checkEmail(email) != null;
        } catch (Exception e) {
            return true;
        }
	}
}















