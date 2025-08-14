package com.service.spring.dao;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.dao.AccountDAO;
import com.service.spring.domain.Account;
import com.service.spring.domain.TargetAccount;

@Repository
public class AccountDAO {
	public static final String NS = "ns.sql.AccountMapper.";
	public static final String NS2 = "ns.sql.TargetAccountMapper.";
	
	@Autowired	
	private SqlSession sqlSession;
	
	public List<Account> getMonthAcc(int memId, LocalDate date) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("memId", memId);
		params.put("accDate", date);

		return sqlSession.selectList(NS + "getMonthAcc", params);
	}

	public int addAcc(Account account) throws SQLException {
		return sqlSession.insert(NS + "addAcc", account);
	}

	public int changeAcc(Account account)  throws SQLException {
		return sqlSession.update(NS + "changeAcc", account);
	}

	public int deleteAcc(int accId)  throws SQLException {
		return sqlSession.delete(NS + "deleteAcc", accId);
	}
	
	public int getMonthSum(Account account) throws SQLException {
        return (int) Optional.ofNullable(
                sqlSession.selectOne(NS + "getMonthSum", account)
        ).orElse(0);
	}
    
	public TargetAccount getTarget(TargetAccount targetAccount) throws SQLException {
		return sqlSession.selectOne(NS2 + "getTarget", targetAccount);
	}

	public List<TargetAccount> getAllTarget(TargetAccount targetAccount) throws SQLException {
		return sqlSession.selectList(NS2 + "getAllTarget", targetAccount);
	}

	public int setTarget(TargetAccount targetAccount) throws SQLException {
		return sqlSession.insert(NS2 + "setTarget", targetAccount);
	}

	public int changeTarget(TargetAccount targetAccount) throws SQLException {
		return sqlSession.update(NS2 + "changeTarget", targetAccount);
	}
}
