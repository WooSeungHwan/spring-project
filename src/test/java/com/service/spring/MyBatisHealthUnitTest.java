package com.service.spring;


import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;

import com.service.spring.domain.Health;


public class MyBatisHealthUnitTest {
	/*
	@Test
	public void unit1() throws Exception {
		Reader r=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(r);
		
		SqlSession session=factory.openSession();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memId", 1);
		List<Health> list = session.selectList("getHealth", map);
		System.out.println("-------------------1---------------------");
		for(Health h : list) {
			System.out.println(h);
		}
	}
	
	@Test
	public void unit2() throws Exception {
		Reader r=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(r);
		
		SqlSession session=factory.openSession();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("memId", 5);
		map.put("healDone", false);
		map.put("healName", "달리기");
		System.out.println("-------------------2---------------------");
		List<Health> list = session.selectList("getHealth", map);
		for(Health h : list) {
			System.out.println(h);
		}
	}
	*/
	/*
	@Test
	public void unit3() throws Exception {
		Reader r=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(r);
		
		SqlSession session=factory.openSession();
		
		System.out.println("-------------------3---------------------");
		System.out.println(session.insert("addHealth", new Health("윗몸일으키기", 100, true, 3)));
	}
	
	@Test
	public void unit4() throws Exception {
		Reader r=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(r);
		
		SqlSession session=factory.openSession();
		
		System.out.println("-------------------4---------------------");
		System.out.println(session.update("changeHealth", new Health(301, "물 마시기", 8, true, 1)));
	}
	*/
	@Test
	public void unit5() throws Exception {
		Reader r=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(r);
		
		SqlSession session=factory.openSession();
		
		System.out.println("-------------------5---------------------");
		System.out.println(session.delete("deleteHealth", 301));
	}
}
