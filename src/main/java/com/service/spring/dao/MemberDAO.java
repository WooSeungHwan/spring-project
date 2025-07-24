
package com.service.spring.dao;
import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.dao.MemberDAO;
import com.service.spring.domain.Member;


@Repository
public class MemberDAO{	
	public static final String NS = "ns.sql.MemberMapper.";

	@Autowired
	private SqlSession sqlSession;
	
}







