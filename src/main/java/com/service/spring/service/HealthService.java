package com.service.spring.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.HealthDAO;
import com.service.spring.domain.Health;

@Service
public class HealthService {
	
	@Autowired
	private HealthDAO healthDAO;
	
	public List<Object> getHealth(HashMap<String, Object> map) throws SQLException {
		return healthDAO.getHealth(map);
	}
	
	public int addHealth(Health health) throws SQLException {
		return healthDAO.addHealth(health);
	}
	
	public int deleteHealth(int healId) throws SQLException {
		return healthDAO.deleteHealth(healId);
	}
	
	public int updateHealth(Health health) throws SQLException {
		return healthDAO.updateHealth(health);
	}
}
