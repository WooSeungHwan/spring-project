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
	

	public void addTodo(Todo vo) throws Exception {
		sqlSession.insert(NS+"addTodo", vo);
	}
	
	public void deleteTodo(String todoId) throws Exception{
		sqlSession.delete(NS+"deleteTodo", todoId);
	}
	
	public void changeTodo(Todo vo) throws Exception{
		sqlSession.update(NS+"changeTodo", vo);
	}
	
	public void isTodoDone(Todo vo) throws Exception{
		sqlSession.update(NS+"isTodoDone", vo);
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
