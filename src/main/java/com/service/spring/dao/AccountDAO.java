package com.service.spring.dao;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.dao.AccountDAO;
import com.service.spring.domain.Account;

@Repository
public class AccountDAO {
	public static final String NS = "ns.sql.AccountMapper.";
	
	@Autowired	
	private SqlSession sqlSession;
	
}
