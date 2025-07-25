package com.service.spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.domain.Todo;

@Repository
public class TodoDAO {
	public static final String NS = "ns.sql.TodoMapper.";

  @Autowired	
	private SqlSession sqlSession;
	

	public Todo addTodo(Todo vo) throws Exception {
		sqlSession.insert(NS+"addTodo", vo);
		return vo;
	}
	
	public int deleteTodo(int vo) throws Exception{
		return sqlSession.delete(NS+"deleteTodo", vo);
	}
	
	public int changeTodo(Todo vo) throws Exception{
		return sqlSession.update(NS+"changeTodo", vo);
	}
	
	public int isTodoDone(Todo vo) throws Exception{
		return sqlSession.update(NS+"isTodoDone", vo);
	}
	
	public List<Todo> getTodoByToday(String date) throws Exception{
		List<Todo> list = sqlSession.selectList(NS+"getTodoByToday", date);
		return list;
	}
	
	public List<Todo> getTodoByImportant(Todo vo) throws Exception{
		List<Todo> list = sqlSession.selectList(NS+"getTodoByImportant", vo);
		return list;
	}
}
