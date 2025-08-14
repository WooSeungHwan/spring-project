package com.service.spring.controller;

import java.sql.SQLException;
import java.time.LocalDate;
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
import com.service.spring.domain.Member;
import com.service.spring.domain.PInfo;
import com.service.spring.service.FriendService;
import com.service.spring.service.HealthService;
import com.service.spring.service.MemberService;
import com.service.spring.service.PInfoService;

import jakarta.servlet.http.HttpSession;

@Controller
public class HealthController {
	@Autowired
	private HealthService healthService;
	@Autowired
	private PInfoService pInfoService;
	@Autowired
	private FriendService friendService;
	@Autowired
	private MemberService memberService;
	@GetMapping("/moveHealth")
	public String moveHealth(HttpSession session, Model model) {
		if ((Member)session.getAttribute("member") == null)
			return "pages/member/login";
		Member member = (Member)session.getAttribute("member");
		System.out.println(member);
		int memId = member.getMemId();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memId", memId);
		try {
				List<Health> list = healthService.getHealth(map);
				map.put("healDate", LocalDate.now().toString());
				PInfo pInfo = pInfoService.getPInfo(memId);
				if (pInfo != null)
					pInfo.setBMI(pInfoService.getBMI(memId));
				else {
					pInfo = new PInfo(memId, 0, 0);
				}
				HashMap<String, List<?>> chartMap = healthService.getChartData(list);
				list = healthService.getHealth(map);
				List<Member> RankingList = friendService.getFriendList(memId);
				RankingList.add(memberService.searchMember(memId));
				List<Map.Entry<String, Double>> healthDoneRanking = healthService.getHealthDoneRanking(RankingList);
				model.addAttribute("healthRanking", healthDoneRanking);
				model.addAttribute("healthList", list);
				model.addAttribute("pInfo", pInfo);
				model.addAttribute("chartData", chartMap.get("chartData"));
				model.addAttribute("chartLabel", chartMap.get("chartLabel"));
			} catch (Exception e) {
				model.addAttribute("msg", e.getMessage());
				e.getMessage();
			}
		return "pages/health/health";
	}
	
	
	@ResponseBody
	@PostMapping("/changePInfo")
	public PInfo changePInfo(@RequestParam("height") double height, @RequestParam("weight") double weight, HttpSession session, Model model) {
		Member member = (Member)session.getAttribute("member");
		PInfo newPInfo = null;
		int memId = member.getMemId();
		if (member != null) {
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
		Member member = (Member)session.getAttribute("member");
	    int memId = member.getMemId();
	    Map<String, Object> response = new HashMap<>();    
	    if (member != null) {
	        Health newHealth = new Health(healthName, healthAmount, false, memId);
	        try {
	            healthService.addHealth(newHealth);
	            HashMap<String, Object> map = new HashMap<String, Object>();
	            map.put("memId", memId);
	            List<Health> newHealthList = healthService.getHealth(map);
	            HashMap<String, List<?>> chartMap = healthService.getChartData(newHealthList);
	            map.put("healDate", LocalDate.now().toString());
	            newHealthList = healthService.getHealth(map);
	            response.put("success", true);
	            response.put("healthList", newHealthList);
				response.put("chartData", chartMap.get("chartData"));
				response.put("chartLabel", chartMap.get("chartLabel"));
	        } catch (SQLException e) {
	            e.printStackTrace();
	            response.put("success", false);
	            response.put("message", "데이터베이스 오류로 운동 추가에 실패했습니다.");
	        }
	    }
	    return response;
	}
	
	@ResponseBody
	@PostMapping("/changeHealthDone")
	public Map<String, Object> changeHealDone(@RequestParam("healId") int healId, HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		Map<String, Object> response = new HashMap<>();
	    int memId = member.getMemId();
		if (member != null) {
		    try {
		        Health rHealth = healthService.getHealth(healId);
		        if (rHealth != null) {
		            rHealth.setHealDone(true);
		            healthService.updateHealth(rHealth);
		            HashMap<String, Object> map = new HashMap<String, Object>();
		            map.put("memId", memId);
		            List<Health> newHealthList = healthService.getHealth(map);
		            HashMap<String, List<?>> chartMap = healthService.getChartData(newHealthList);
		            map.put("healDate", LocalDate.now().toString());
		            newHealthList = healthService.getHealth(map);
		            response.put("success", true);
		            response.put("healthList", newHealthList);
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
