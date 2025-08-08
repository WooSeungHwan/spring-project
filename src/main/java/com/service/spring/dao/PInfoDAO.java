package com.service.spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.domain.PInfo;

@Repository
public class PInfoDAO {
	public static final String NS = "ns.sql.PInfoMapper.";

  @Autowired	
	private SqlSession sqlSession;
	
  	public PInfo getPInfo(int memId) {
  		return sqlSession.selectOne(NS + "getPInfo", memId);
  	}
  	
	public int addPInfo(PInfo pInfo) {
		return sqlSession.insert(NS + "addPInfo", pInfo);
	}
	
	public int changePInfo(PInfo pInfo) {
		return sqlSession.update(NS + "changePInfo", pInfo);
	}
}
