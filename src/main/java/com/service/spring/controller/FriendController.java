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
			List<Member> friendPendingList = friendService.getPendingFriendList(member.getMemId());
			System.out.println("친구 대기 목록 개수: " + friendList.size());
			friendPendingList.forEach(f -> System.out.println(f.getNickname()));
			model.addAttribute("friendList", friendList);
			model.addAttribute("friendPendingList", friendPendingList);
		}catch(SQLException e) {
			return "redirect:/pages/member/login.jsp";
		}
		return "pages/profile/profile";
	}

    @GetMapping("/get-all-friend")
    public List<Member> getAllFriend(HttpSession session, Model model) {
        if ((Member)session.getAttribute("member") == null)
            return null;

        Member member = (Member)session.getAttribute("member");

        try {
            return friendService.getFriendList(member.getMemId());
        } catch(SQLException e) {
            return null;
        }
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
		
		return "redirect:/moveProfile";
	}
	
	@PostMapping("/acceptFriend")
	public String acceptFriend(@RequestParam int friendId, HttpSession session, Model model) {
		if ((Member)session.getAttribute("member") == null)
			return "pages/member/login";
		Member member = (Member)session.getAttribute("member");
		try {
	        Friend friend = new Friend(member.getMemId(), friendId, "accepted");
			friendService.updateFriendStatus(friend);
		} catch(SQLException e) {
			e.getMessage();
		}
		return "redirect:/moveProfile";
	}
	
	@PostMapping("/deleteFriend")
	public String deleteFriend(@RequestParam int friendId, HttpSession session, Model model) {
		if ((Member)session.getAttribute("member") == null)
			return "pages/member/login";
		Member member = (Member)session.getAttribute("member");
		try {
			Friend friend = new Friend(member.getMemId(), friendId, null);
			friendService.deleteFriend(friend);
		}catch(SQLException e) {
			e.getMessage();
		}
		
		return "redirect:/moveProfile";
	}
}
