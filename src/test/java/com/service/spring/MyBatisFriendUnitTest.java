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
import com.service.spring.domain.Member;


public class MyBatisFriendUnitTest {
	@Test
	public void unit1() throws Exception {
		Reader r=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(r);
		
		SqlSession session=factory.openSession();
		
		System.out.println("-------------------1---------------------");
		
		List<Member> list = session.selectList("getFriend", 6);
		for(Member m : list) {
			System.out.println(m);
		}
	}
	/*
	@Test
	public void unit2() throws Exception {
		Reader r=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(r);
		
		SqlSession session=factory.openSession();
		
		System.out.println("-------------------2---------------------");
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("mem1Id", 6);
		map.put("mem2Id", 7);
		System.out.println(session.insert("addFriend", map));
	}
	*/
	@Test
	public void unit3() throws Exception {
		Reader r=Resources.getResourceAsReader("config/SqlMapConfig.xml");
		
		SqlSessionFactory factory=new SqlSessionFactoryBuilder().build(r);
		
		SqlSession session=factory.openSession();
		
		System.out.println("-------------------3---------------------");
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("mem1Id", 7);
		map.put("mem2Id", 4);
		System.out.println(session.delete("deleteFriend", map));
	}
}
