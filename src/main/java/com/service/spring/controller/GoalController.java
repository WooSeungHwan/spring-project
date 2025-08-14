package com.service.spring.controller;

import com.service.spring.domain.*;
import com.service.spring.service.AccountService;
import com.service.spring.service.HealthService;
import com.service.spring.service.MemberService;
import com.service.spring.service.TodoService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;

@Controller
public class GoalController {
    @Autowired
    MemberService memberService;

    @Autowired
    TodoService todoService;

    @Autowired
    HealthService healthService;

    @Autowired
    AccountService accountService;

    @GetMapping("/goal")
    public String moveGoal(HttpSession session) {
        Member member = (Member)session.getAttribute("member");

        if (member == null) {
            return "redirect:/pages/member/login.jsp";
        } else {
            return "pages/goal/myGoal";
        }
    }

    @PostMapping("/set-goal-exp")
    @ResponseBody
    public void calGoalExp(HttpSession session) {
        Member member = (Member)session.getAttribute("member");

        if (member == null) {
            return;
        }

        int memId = member.getMemId();
        Goal goal = member.getGoal();
        int goalExp = 0;

        // goal_name: 언제 계산을 했는 지, goal_exp: 총 경험치, goal_lv: exp / 50 + 1
        try {
            // todo 계산, 완료 시 +1
            List<Todo> todoList = todoService.getAllByMember(memId);
            for (Todo t : todoList) {
                if (t.isTodoDone()) {
                    goalExp += 1;
                }
            }

            // health 계산, 완료 시 +3
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("memId", memId);
            List<Health> healthList = healthService.getHealth(map);
            for (Health h : healthList) {
                if (h.isHealDone()) {
                    goalExp += 3;
                }
            }

            // account 계산, 완료 시 +25(한 달 간격)
            LocalDate currentDate = LocalDate.of(2025, 1, 1);;
            LocalDate today = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            int monthCount = 0;
            TargetAccount targetAccount = new TargetAccount();
            targetAccount.setMemId(memId);

            while (!currentDate.isAfter(today)) {
                monthCount++;
                currentDate = currentDate.plusMonths(1);
                // System.out.println(currentDate);
                Account account = new Account();
                account.setMemId(memId);
                account.setAccDate(currentDate);

                List<TargetAccount> targetAccList = accountService.getAllTarget(targetAccount);
                int totalSum = accountService.getMonthSum(account);
                for (TargetAccount tgtAcc : targetAccList) {
                    if (tgtAcc.getTargetAcc() > totalSum) {
                        goalExp += 25;
                    }
                }
            }

            // update goal_exp
            goal.setGoalExp(goalExp);
            goal.setGoalLv(goalExp / 50 + 1);
            // goal.setGoalName();

            memberService.updateGoal(memId, goal);
        } catch(Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
