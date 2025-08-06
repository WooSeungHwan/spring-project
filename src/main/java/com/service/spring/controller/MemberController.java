package com.service.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.service.spring.domain.Member;
import com.service.spring.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	@GetMapping("/")
	public String getDefault(HttpSession session) {
		// 로그인되어있다면 main, 아니면 login으로
		Member member = (Member)session.getAttribute("member");
		if (member != null)
			return "main";
		else
			return "pages/member/login";
	}
	
	@GetMapping("/login")
	public String moveLogin() {
		return "pages/member/login";
	}

	@PostMapping("/login")
	public String doLogin(Member member, HttpSession session, Model model) {
		try {
			Member loginMember = memberService.login(member);
			if (loginMember == null)
				return "pages/member/login";

			session.setAttribute("member", loginMember);
		} catch (Exception e) {
			// 에러 처리
			return "error";
		}

		return "main";
	}

	// 로그아웃
	@GetMapping("/logout")
	public String doLogout(HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		if (member != null)
			session.invalidate();

		return "redirect:/";
	}

	@GetMapping("/register")
	public String moveRegister() {
		return "/pages/member/register";
	}

	@PostMapping("/register")
	public String doRegister(Member member, Model model) {
		System.out.println(member);
		try {
			memberService.addMember(member);
		} catch (Exception e) {
			// 에러 처리
			model.addAttribute("msg", e.getMessage());
			return "error";
		}

		return "/pages/member/login";
	}

	@GetMapping("/main")
	public String getMain() {
		return "main";
	}
}















