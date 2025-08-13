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
public class AsyncFriendController {

    @Autowired
    private AccountService accountService;

   
}
