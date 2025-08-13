package com.service.spring.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.service.spring.domain.Member;
import com.service.spring.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	
	@Value("${file.upload-dir}")
    private String uploadDir;

    @Value("${file.access-url}")
    private String accessUrl;

	
	@Autowired
	private MemberService memberService;

	@GetMapping("/")
	public String getDefault(HttpSession session, Model model) {
		// 로그인되어있다면 main, 아니면 login으로
		Member member = (Member)session.getAttribute("member");
		if (member != null) {
			model.addAttribute("currentMenu", "dashboard");
			return "main";
		}
		else
			return "pages/member/login";
	}

	@GetMapping("/main")
	public String getMain(Model model) {
		model.addAttribute("currentMenu", "dashboard");
		return "main";
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
	
	@PostMapping("/updateMember")
	public String updateMember(
			@RequestParam("profileImage") MultipartFile profileImage,
	        @RequestParam("eMail") String eMail,
	        @RequestParam("password") String password,
	        @RequestParam("nickName") String nickName,
	        @RequestParam("gender") String gender, HttpSession session, Model model) {
		
		try {
			Member loginMember = (Member) session.getAttribute("member");
            if (loginMember == null) {
                model.addAttribute("errorMsg", "로그인이 필요합니다.");
                return "redirect:/pages/member/login.jsp";
            }
            if (profileImage != null && !profileImage.isEmpty()) {
                String fileName = UUID.randomUUID().toString() + "_" + profileImage.getOriginalFilename();
                File dest = new File(uploadDir, fileName);
                if (!dest.getParentFile().exists()) {
                    dest.getParentFile().mkdirs();
                }
                profileImage.transferTo(dest);
                loginMember.setProfileImg(accessUrl + fileName);
            }
            loginMember.setEmail(eMail);
            loginMember.setPassword(password);
            loginMember.setNickname(nickName);
            loginMember.setGender(gender);
            memberService.changeMember(loginMember);
            session.setAttribute("loginMember", loginMember);
            model.addAttribute("successMsg", "회원 정보가 수정되었습니다.");
        } catch (IOException e) {
            e.getMessage();
            model.addAttribute("errorMsg", "파일 업로드 중 오류가 발생했습니다.");
            return "redirect:/pages/member/login.jsp";
        } catch (Exception e) {
            e.getMessage();
            model.addAttribute("errorMsg", "회원 정보 수정 중 오류가 발생했습니다.");
            return "redirect:/pages/member/login.jsp";
        }
		return "/pages/profile/profile";
	}
}
















