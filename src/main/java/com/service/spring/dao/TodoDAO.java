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
	
	
/*
	public void insertBook(Book vo) throws Exception {	
		sqlSession.insert(NS + "insertBook", vo);
	}
	
	public List<Book> getBooks() throws Exception {
		List<Book> list = sqlSession.selectList(NS + "getBooks");

        return list;
	}
	
	public List<Book> searchByTitle(String word) throws Exception {
		List<Book> list = sqlSession.selectList(NS + "searchByTitle", word);
		
       return list;
	}

	public List<Book> searchByPublisher(String word) throws Exception {
		List<Book> list = sqlSession.selectList(NS + "searchByPublisher", word);
		
		return list;
	}
	
	public List<Book> searchByPrice(int price) throws Exception {
		List<Book> list = sqlSession.selectList(NS + "searchByPrice", price);
		
		return list;
	}

	public Book searchByIsbn(String word) throws Exception { 
		Book book = sqlSession.selectOne(NS + "searchByIsbn", word);
		
		return book;
	}

	
	public void delete(String word) throws Exception {
		sqlSession.delete(NS + "delete", word);
	}
	
	
	public Book getIsbn(String word) throws Exception {
		Book book = sqlSession.selectOne(NS + "getIsbn", word);
		
        return book;
	}
	
	public void update(Book vo) throws Exception {
		sqlSession.update(NS + "update", vo);
	}	
	
*/
}