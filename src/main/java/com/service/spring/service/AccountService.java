package com.service.spring.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.AccountDAO;
import com.service.spring.domain.Account;
import com.service.spring.domain.TargetAccount;

@Service
public class AccountService {
	@Autowired
	private AccountDAO accountDAO;
	
	public List<Account> getMonthAcc(int memId, LocalDate date) throws SQLException {
		return accountDAO.getMonthAcc(memId, date);
	}

	public int addAcc(Account account) throws SQLException {
		return accountDAO.addAcc(account);
	}

	public int changeAcc(Account account)  throws SQLException {
		return accountDAO.changeAcc(account);
	}

	public int deleteAcc(int accId)  throws SQLException {
		return accountDAO.deleteAcc(accId);
	}
	
	public int getMonthSum(Account account) throws SQLException {
		return accountDAO.getMonthSum(account);
	}
    
	public TargetAccount getTarget(Account account) throws SQLException {
		return accountDAO.getTarget(account);
	}

	public List<TargetAccount> getAllTarget(Account account) throws SQLException {
		return accountDAO.getAllTarget(account);
	}

	public int setTarget(TargetAccount targetAccount) throws SQLException {
		return accountDAO.setTarget(targetAccount);
	}

	public int changeTarget(TargetAccount targetAccount) throws SQLException {
		return accountDAO.changeTarget(targetAccount);
	}
	
}