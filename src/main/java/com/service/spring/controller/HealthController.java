package com.service.spring.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.service.spring.domain.Health;
import com.service.spring.service.HealthService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HealthController {
	@Autowired
	private HealthService healthService;
	
	@GetMapping("/moveHealth")
	public String moveHealth(HttpSession session, Model model) {
		Object memIdAttr = session.getAttribute("memId");
		int memId = 1;
		if (memIdAttr != null)
			memId = (int)memIdAttr;
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (memId != 0) {
			map.put("memId", memId);
			try {
				List<Health> list = healthService.getHealth(map);
				model.addAttribute("healthList", list);
			} catch (SQLException e) {
				e.getMessage();
			}
		}
		return "health";
	}
}
