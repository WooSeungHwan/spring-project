package com.service.spring.controller;

import com.service.spring.domain.Member;
import com.service.spring.domain.Todo;
import com.service.spring.service.TodoService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/todo")
public class TodoController {

    @Autowired
    private TodoService todoService;

    /** 세션에서 memId 꺼내는 헬퍼 */
    private int resolveMemId(HttpSession session) {
        Member m = (Member) session.getAttribute("member");
        // 로그인 전 테스트용 fallback
        return (m != null) ? m.getMemId() : 1;
    }

    /** 페이지 진입 (JSP 렌더) */
    @GetMapping
    public String view(HttpSession session, Model model) {
        model.addAttribute("currentMenu", "todo");   // 사이드바 active 표시용(선택)
        return "pages/todo/todo";
    }

    /** 오늘 할일 목록 (JSON) */
    @GetMapping("/list")
    @ResponseBody
    public List<Todo> listToday(HttpSession session) throws Exception {
        int memId = resolveMemId(session);
        return todoService.getTodoByToday(memId);
    }

    /** 중요 표시만 목록 (JSON) */
    @GetMapping("/important")
    @ResponseBody
    public List<Todo> listImportant(HttpSession session) throws Exception {
        int memId = resolveMemId(session);
        // DAO 시그니처가 int를 받도록 정리했으면 아래처럼:
        // return todoService.getTodoByImportant(memId);
        // 현재 서비스가 Todo를 받는다면:
        Todo q = new Todo();
        q.setMemId(memId);
        q.setTodoImportant(true);
        return todoService.getTodoByImportant(q);
    }

    /** 등록 (JSON) */
    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> add(@RequestBody Map<String, Object> body, HttpSession session) throws Exception {
        int memId = resolveMemId(session);

        String content = String.valueOf(body.getOrDefault("todoContent", "")).trim();
        boolean important = Boolean.parseBoolean(String.valueOf(body.getOrDefault("todoImportant", false)));

        // 날짜가 안 오면 오늘
        LocalDate date = LocalDate.now();
        if (body.get("todoDate") != null) {
            date = LocalDate.parse(String.valueOf(body.get("todoDate"))); // 'yyyy-MM-dd'
        }

        Todo t = new Todo(false, content, Date.valueOf(date), important, memId);
        Todo saved = todoService.addTodo(t);

        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("todo", saved);
        return res;
    }

    /** 수정 (JSON) */
    @PutMapping("/update")
    @ResponseBody
    public Map<String, Object> update(@RequestBody Map<String, Object> body, HttpSession session) throws Exception {
        int memId = resolveMemId(session);

        int id = Integer.parseInt(String.valueOf(body.get("todoId")));
        String content = String.valueOf(body.getOrDefault("todoContent", "")).trim();
        boolean important = Boolean.parseBoolean(String.valueOf(body.getOrDefault("todoImportant", false)));
        boolean done = Boolean.parseBoolean(String.valueOf(body.getOrDefault("todoDone", false)));

        LocalDate date = LocalDate.now();
        if (body.get("todoDate") != null) {
            date = LocalDate.parse(String.valueOf(body.get("todoDate")));
        }

        Todo t = new Todo(id, done, content, Date.valueOf(date), important, memId);
        int updated = todoService.changeTodo(t);

        Map<String, Object> res = new HashMap<>();
        res.put("success", updated > 0);
        res.put("updated", updated);
        return res;
    }

    /** 완료 체크 토글 (폼 or 쿼리파라미터) */
    @PostMapping("/done")
    @ResponseBody
    public Map<String, Object> toggleDone(@RequestParam int todoId, @RequestParam boolean done) throws Exception {
        int updated = todoService.isTodoDone(new Todo(todoId, done));
        Map<String, Object> res = new HashMap<>();
        res.put("success", updated > 0);
        res.put("updated", updated);
        return res;
    }

    /** 삭제 */
    @PostMapping("/delete")
    @ResponseBody
    public Map<String, Object> delete(@RequestParam int todoId) throws Exception {
        int deleted = todoService.deleteTodo(todoId);
        Map<String, Object> res = new HashMap<>();
        res.put("success", deleted > 0);
        res.put("deleted", deleted);
        return res;
    }
}
