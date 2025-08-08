package com.service.spring.controller;

import com.service.spring.domain.Account;
import com.service.spring.domain.Member;
import com.service.spring.service.AccountService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
public class AsyncAccountController {

    @Autowired
    private AccountService accountService;

    @GetMapping("/getMonthAcc")
    public List<Account> getMonthAcc(LocalDate date, Model model, HttpSession session) {
        Member member;
        LocalDate curDate;

        try {
            member = (Member)session.getAttribute("member");
            if (member == null)
                return null;

            curDate = LocalDate.now(); // TODO: 달 변경 가능하도록 할 것

            return accountService.getMonthAcc(member.getMemId(), curDate);
        } catch (Exception e) {
            model.addAttribute("msg", e.getMessage());
            return null;
        }
    }

    @PostMapping("addAcc")
    @ResponseBody
    public Account addAcc(HttpSession session, @RequestBody Account acc) { // json으로 데이터를 받음
        Member member = (Member)session.getAttribute("member");

        System.out.println(acc);

        try {
            if (acc == null) {
                System.out.println("Account is Null!");
                return null;
            }

            if (member == null) {
                System.out.println("Member is Null!");
                return null;
            }

            acc.setMemId(member.getMemId());

            accountService.addAcc(acc);
        } catch (Exception e) {
            return null;
        }

        return acc;
    }

    @PostMapping("/deleteAcc")
    @ResponseBody
    public int deleteAcc(HttpSession session, @RequestBody int accId) { // json으로 데이터를 받음
        Member member = (Member)session.getAttribute("member");

        try {
            if (member == null) {
                System.out.println("Member is Null!");
                return -1;
            }

            accountService.deleteAcc(accId);
        } catch (Exception e) {
            return -1;
        }

        return accId;
    }
}
