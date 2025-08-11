package com.service.spring.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service.spring.domain.Health;
import com.service.spring.domain.PInfo;
import com.service.spring.service.HealthService;
import com.service.spring.service.PInfoService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HealthController {
	@Autowired
	private HealthService healthService;
	@Autowired
	private PInfoService pInfoService;
	
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
				PInfo pInfo = pInfoService.getPInfo(memId);
				pInfo.setBMI(pInfoService.getBMI(memId));
				HashMap<String, List<?>> chartMap = healthService.getChartData(list);
				model.addAttribute("healthList", list);
				model.addAttribute("pInfo", pInfo);
				model.addAttribute("chartData", chartMap.get("chartData"));
				model.addAttribute("chartLabel", chartMap.get("chartLabel"));
			} catch (SQLException e) {
				e.getMessage();
			}
		}
		return "health";
	}
	
	@ResponseBody
	@PostMapping("/changePInfo")
	public PInfo changePInfo(@RequestParam("height") double height, @RequestParam("weight") double weight, HttpSession session, Model model) {
		Object memIdAttr = session.getAttribute("memId");
		PInfo newPInfo = null;
		int memId = 1;
		if (memIdAttr != null)
			memId = (int)memIdAttr;
		if (memId != 0) {
			PInfo prevPInfo = pInfoService.getPInfo(memId);
			newPInfo = new PInfo(memId, height, weight);
			if (prevPInfo == null)
				pInfoService.addPInfo(newPInfo);
			else
				pInfoService.changePInfo(newPInfo);
			newPInfo.setBMI(pInfoService.getBMI(memId)); 
		}
		return newPInfo;
	}
	
	@ResponseBody
	@PostMapping("/addHealth")
	public Map<String, Object> addHealth(@RequestParam("healthName") String healthName, @RequestParam("healthAmount") int healthAmount, HttpSession session){
	    Object memIdAttr = session.getAttribute("memId");
	    int memId = 1;
	    if (memIdAttr != null)
	        memId = (int)memIdAttr;
	    Map<String, Object> response = new HashMap<>();    
	    if (memId != 0) {
	        Health newHealth = new Health(healthName, healthAmount, false, memId);
	        try {
	            healthService.addHealth(newHealth);
	            HashMap<String, Object> map = new HashMap<String, Object>();
	            map.put("memId", memId);
	            List<Health> newHealthList = healthService.getHealth(map);
	            response.put("success", true);
	            response.put("healthList", newHealthList);
	            HashMap<String, List<?>> chartMap = healthService.getChartData(newHealthList);
				response.put("chartData", chartMap.get("chartData"));
				response.put("chartLabel", chartMap.get("chartLabel"));
	        } catch (SQLException e) {
	            e.printStackTrace();
	            response.put("success", false);
	            response.put("message", "데이터베이스 오류로 운동 추가에 실패했습니다.");
	        }
	    } else {
	        response.put("success", false);
	        response.put("message", "사용자 정보가 유효하지 않습니다.");
	    }
	    return response;
	}
	
	@ResponseBody
	@PostMapping("/changeHealthDone")
	public Map<String, Object> changeHealDone(@RequestParam("healId") int healId, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    Object memIdAttr = session.getAttribute("memId");
	    int memId = 1;
		if (memIdAttr != null)
			memId = 1;
		if (memId != 0) {
	    try {
	        Health rHealth = healthService.getHealth(healId);
	        if (rHealth != null) {
	            rHealth.setHealDone(true);
	            healthService.updateHealth(rHealth);
	            HashMap<String, Object> map = new HashMap<String, Object>();
	            map.put("memId", memId);
	            List<Health> newHealthList = healthService.getHealth(map);
	            response.put("success", true);
	            response.put("healthList", newHealthList);
	            HashMap<String, List<?>> chartMap = healthService.getChartData(newHealthList);
				response.put("chartData", chartMap.get("chartData"));
				response.put("chartLabel", chartMap.get("chartLabel"));
	        } else {
	            response.put("success", false);
	            response.put("message", "해당 운동을 찾을 수 없거나 소유자가 다릅니다.");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.put("success", false);
	        response.put("message", "데이터베이스 오류가 발생했습니다.");
	    }
		}
	    return response;
	}
}
