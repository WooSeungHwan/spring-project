package com.service.spring.controller;

import com.service.spring.domain.Member;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GoalController {
    @GetMapping("/goal")
    public String moveGoal(HttpSession session) {
        Member member = (Member)session.getAttribute("member");

        if (member == null) {
            return "redirect:/pages/member/login.jsp";
        } else {
            return "pages/goal/myGoal";
        }
    }
}
