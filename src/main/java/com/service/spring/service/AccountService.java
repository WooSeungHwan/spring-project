package com.service.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.AccountDAO;
import com.service.spring.domain.Account;

@Service
public class AccountService {
	@Autowired
	private AccountDAO accountDAO;
	
}