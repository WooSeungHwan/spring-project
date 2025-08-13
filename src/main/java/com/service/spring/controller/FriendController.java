package com.service.spring.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service.spring.domain.Friend;
import com.service.spring.domain.Health;
import com.service.spring.domain.Member;
import com.service.spring.domain.PInfo;
import com.service.spring.service.FriendService;
import com.service.spring.service.HealthService;
import com.service.spring.service.MemberService;
import com.service.spring.service.PInfoService;

import jakarta.servlet.http.HttpSession;

@Controller
public class FriendController {
	
	@Autowired
	private FriendService friendService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/moveProfile")
	public String moveProfile(HttpSession session, Model model) {
		if ((Member)session.getAttribute("member") == null)
			return "pages/member/login";
		Member member = (Member)session.getAttribute("member");
			
		try {
			List<Member> friendList = friendService.getFriendList(member.getMemId());
			model.addAttribute("friendList", friendList);
		}catch(SQLException e) {
			e.getMessage();
			return "redirect:/pages/member/login.jsp";
		}
		return "pages/profile/profile";
	}
	
	@PostMapping("/searchMembers")
	@ResponseBody
	public List<Member> getMember(@RequestParam String nickname) {
		List<Member> list = null;
		try {
			list = memberService.searchMember(nickname);
		} catch(SQLException e) {
			e.getMessage();
		}
		return list;
	}
	
	@PostMapping("/addFriend")
	public String addFriend(@RequestParam int friendId, HttpSession session, Model model) {
		if ((Member)session.getAttribute("member") == null)
			return "pages/member/login";
		Member member = (Member)session.getAttribute("member");
		try {
			Friend friend = new Friend(member.getMemId(), friendId, "pending");
			friendService.addFriend(friend);
		} catch (SQLException e) {
			e.getMessage();
		}
		
		return "pages/profile/profile";
	}
}
