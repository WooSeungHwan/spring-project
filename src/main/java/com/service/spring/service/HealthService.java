package com.service.spring.service;

import java.sql.SQLException;
import java.util.ArrayList;
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
	
	public List<Health> getHealth(HashMap<String, Object> map) throws SQLException {
		return healthDAO.getHealth(map);
	}
	
	public Health getHealth(int healId) throws SQLException {
		return healthDAO.getHealth(healId);
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
	
	private double calcHealthDonePercent(List<Health> list) {
		double count = 0;
		for(Health h : list) {
			if (h.isHealDone() == true)
				count += 1;
		}
		if (count == 0)
			return 0;
		return Math.round(((count / list.size()) * 100) * 100) / 100.0;
	}
	
	public double getHealthDonePercent(List<Health> list) {
		if(list == null)
			return 0;
		return calcHealthDonePercent(list);
	}
	
	public HashMap<String, List<?>> getChartData(List<Health> list) {
		HashMap<String, List<?>> map = new HashMap<String, List<?>>();
		double donePer = getHealthDonePercent(list);
		List<Double> chartData = new ArrayList<Double>();
		chartData.add(donePer);
		chartData.add(100.0 - donePer);
		List<String> chartLabel = new ArrayList<String>();
		chartLabel.add("완료");
		chartLabel.add("진행중");
		map.put("chartData", chartData);
		map.put("chartLabel", chartLabel);
		return map; 
	}
}
