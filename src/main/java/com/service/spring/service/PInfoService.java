package com.service.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.PInfoDAO;
import com.service.spring.domain.PInfo;



@Service
public class PInfoService {
	
	@Autowired
	private PInfoDAO pInfoDAO;
	
	public PInfo getPInfo(int memId) {
  		return pInfoDAO.getPInfo(memId);
  	}
  	
	public int addPInfo(PInfo pInfo) {
		return pInfoDAO.addPInfo(pInfo);
	}
	
	public int changePInfo(PInfo pInfo) {
		return pInfoDAO.changePInfo(pInfo);
	}
	
	private double calcBMI(PInfo pInfo) {
		double heightMeter = pInfo.getHeight() / 100.0;
		return Math.round(pInfo.getWeight() / (heightMeter * heightMeter) * 100) / 100.0;
	}
	
	public double getBMI(int memId) {
		PInfo pInfo = pInfoDAO.getPInfo(memId);
		if (pInfo == null)
			return 0;
		pInfo.setBMI(calcBMI(pInfo));
		return pInfo.getbMI();
	}
}
