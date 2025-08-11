package com.service.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.TodoDAO;
import com.service.spring.domain.Todo;

@Service
public class TodoService {
	
	@Autowired
	private TodoDAO todoDAO;
	
	public Todo addTodo(Todo todo) throws Exception{
		return todoDAO.addTodo(todo);
	}
	
	public int deleteTodo(int vo) throws Exception {
		return todoDAO.deleteTodo(vo);
	}
	
	public int changeTodo(Todo vo) throws Exception{
		return todoDAO.changeTodo(vo);
	}
	
	public int isTodoDone(Todo vo)throws Exception{
		return todoDAO.isTodoDone(vo);
	}
	
	public List<Todo> getTodoByToday(int memId) throws Exception{
		return todoDAO.getTodoByToday(memId);
	}
	
	public List<Todo> getTodoByImportant(Todo vo) throws Exception{
		return todoDAO.getTodoByImportant(vo);
	}
}
