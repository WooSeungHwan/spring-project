
package com.service.spring.dao;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.dao.HealthDAO;
import com.service.spring.domain.Health;

@Repository
public class HealthDAO{	
	public static final String NS = "ns.sql.HealthMapper.";

	@Autowired
	private SqlSession sqlSession;
	
	public List<Object> getHealth(HashMap<String, Object> map) throws SQLException {
		return sqlSession.selectList(NS + "getHealth", map);
	}
	
	public int addHealth(Health health) throws SQLException {
		return sqlSession.insert(NS + "addHealth", health);
	}
	
	public int deleteHealth(int healId) throws SQLException {
		return sqlSession.delete(NS + "deleteHealth", healId);
	}
	
	public int updateHealth(Health health) throws SQLException {
		return sqlSession.update(NS + "changeHealth", health);
	}
}







