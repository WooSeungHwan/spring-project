package com.service.spring;


import java.sql.Date;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.service.spring.domain.Todo;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;

@SpringBootTest
public class TodoUnitTest {
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void addTodoTest() {
		Date date = Date.valueOf("2025-08-10");
		System.out.println(sqlSession.insert("ns.sql.TodoMapper.addTodo",
			new Todo(0, true, "텍스트테스트입니당", date, null, false,1)));
	}
	
		
	@Test
	public void deleteTodoTest() {
		System.out.println(sqlSession.delete("ns.sql.TodoMapper.deleteTodo",109));
	}
/*
	@Test
	public void changeTodoTest() {
		Date date = Date.valueOf("2025-10-10");
		System.out.println(sqlSession.update("ns.sql.TodoMapper.changeTodo",
			new Todo(110, true, "투두리스트 테스트하기2", date, true, 2)
				));
	}
*/
	@Test
	public void isTodoDoneTest() {
		System.out.println(sqlSession.update("ns.sql.TodoMapper.isTodoDone",
				new Todo(110, false)
				));
	}
		
	@Test
	public void getTodoByTodayTest() {
		Date date = Date.valueOf("2025-10-10");
		sqlSession.selectList("ns.sql.TodoMapper.getTodoByToday",date).forEach(b->{
			System.out.println(b);
		});
	}
	@Test
	public void getTodoByImportantTest() {
		sqlSession.selectList("ns.sql.TodoMapper.getTodoByImportant").forEach(b->{
			System.out.println(b);
		});
	}
}
