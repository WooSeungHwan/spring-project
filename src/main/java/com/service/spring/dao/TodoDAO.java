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

	// 할 일 추가
	public Todo addTodo(Todo vo) throws Exception {
		sqlSession.insert(NS + "addTodo", vo);
		return vo;
	}

	// 할 일 삭제
	public int deleteTodo(int vo) throws Exception {
		return sqlSession.delete(NS + "deleteTodo", vo);
	}

	// 할 일 수정
	public int changeTodo(Todo vo) throws Exception {
		return sqlSession.update(NS + "changeTodo", vo);
	}

	// 할 일 완료 여부 수정
	public int isTodoDone(Todo vo) throws Exception {
		return sqlSession.update(NS + "isTodoDone", vo);
	}

	// 오늘의 할 일 조회
	public List<Todo> getTodoByToday(String date) throws Exception {
		return sqlSession.selectList(NS + "getTodoByToday", date);
	}

	// 중요할 일만 조회
	public List<Todo> getTodoByImportant(Todo vo) throws Exception {
		return sqlSession.selectList(NS + "getTodoByImportant", vo);
	}
}
