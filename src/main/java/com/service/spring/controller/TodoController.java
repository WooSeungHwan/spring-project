package com.service.spring.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.service.spring.domain.Member;
import com.service.spring.domain.Todo;
import com.service.spring.service.TodoService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/todo")
public class TodoController {

    @Autowired
    private TodoService todoService;

    /** 세션에서 memId 꺼내는 헬퍼 (없으면 테스트용 1) */
    private int resolveMemId(HttpSession session) {
        Member m = (Member) session.getAttribute("member");
        return (m != null) ? m.getMemId() : 1;
    }

    /** ✅ 페이지 진입: 회원의 모든 To-Do를 모델에 담아 JSP 렌더 */
    @GetMapping
    public String view(HttpSession session, Model model) throws Exception {
        int memId = resolveMemId(session);
        model.addAttribute("currentMenu", "todo");
        model.addAttribute("todoList", todoService.getAllByMember(memId)); // 서비스에 구현 필요
        return "pages/todo/todo";
    }

    /** ✅ 전체 목록 (JSON) */
    @GetMapping("/list")
    @ResponseBody
    public List<Todo> listAll(HttpSession session) throws Exception {
        int memId = resolveMemId(session);
        return todoService.getAllByMember(memId);
    }

    /** ✅ 오늘 일정만 (JSON) */
    @GetMapping("/list/today")
    @ResponseBody
    public List<Todo> listToday(HttpSession session) throws Exception {
        int memId = resolveMemId(session);
        return todoService.getTodoByToday(memId);
    }

    /** ✅ 중요 표시만 (JSON) */
    @GetMapping("/important")
    @ResponseBody
    public List<Todo> listImportant(HttpSession session) throws Exception {
        int memId = resolveMemId(session);
        Todo q = new Todo();
        q.setMemId(memId);
        q.setTodoImportant(true);
        return todoService.getTodoByImportant(q);
    }

    /** ✅ 등록 (JSON) */
    private static String s(Object o){
        return (o == null) ? null : String.valueOf(o).trim();
    }
    private static boolean isIsoDate(String s){
        return s != null && s.matches("\\d{4}-\\d{2}-\\d{2}");
    }
    private static String normTime(String t){
        if (t == null) return null;
        t = t.trim();
        if (!t.matches("\\d{2}:\\d{2}(:\\d{2})?")) return null;
        return (t.length() == 5) ? t + ":00" : t; // HH:mm -> HH:mm:ss
    }

    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> add(@RequestBody Map<String, Object> body, HttpSession session) {
        Map<String, Object> res = new HashMap<>();
        try {
            int memId = resolveMemId(session);

            String content   = s(body.get("todoContent"));
            boolean important= Boolean.parseBoolean(String.valueOf(body.getOrDefault("todoImportant", false)));

            String dateStr = s(body.get("todoDate"));   // 기대: yyyy-MM-dd
            LocalDate date = isIsoDate(dateStr) 
            		? LocalDate.parse(dateStr) 
            		: LocalDate.now(ZoneId.of("Asia/Seoul"));

            String time = normTime(s(body.get("todoTime"))); // 기대: HH:mm[:ss] 또는 null

            Todo t = new Todo(false, content, Date.valueOf(date), time, important, memId);
            t.setTodoTime(time); // String 매핑

            Todo saved = todoService.addTodo(t);
            res.put("success", true);
            res.put("todo", saved);
        } catch (Exception e) {
            res.put("success", false);
            res.put("error", e.getMessage());
        }
        return res;
    }


    /** ✅ 수정 (JSON) */
    @PutMapping("/update")
    @ResponseBody
    public Map<String, Object> update(@RequestBody Map<String, Object> body, HttpSession session) throws Exception {
        int memId = resolveMemId(session);

        int id           = Integer.parseInt(String.valueOf(body.get("todoId")));
        String content   = String.valueOf(body.getOrDefault("todoContent", "")).trim();
        boolean important= Boolean.parseBoolean(String.valueOf(body.getOrDefault("todoImportant", false)));
        boolean done     = Boolean.parseBoolean(String.valueOf(body.getOrDefault("todoDone", false)));
        String time      = (String) body.getOrDefault("todoTime", null);

        LocalDate date = LocalDate.now();
        if (body.get("todoDate") != null && !String.valueOf(body.get("todoDate")).isBlank()) {
            date = LocalDate.parse(String.valueOf(body.get("todoDate")));
        }

        Todo t = new Todo();
        t.setTodoTime(time); // 🕒 시간 세팅
        int updated = todoService.changeTodo(t);

        Map<String, Object> res = new HashMap<>();
        res.put("success", updated > 0);
        res.put("updated", updated);
        return res;
    }

    /** ✅ 완료 체크 토글 */
    @PostMapping("/done")
    @ResponseBody
    public Map<String, Object> toggleDone(@RequestParam int todoId, @RequestParam boolean done) throws Exception {
        int updated = todoService.isTodoDone(new Todo(todoId, done));
        Map<String, Object> res = new HashMap<>();
        res.put("success", updated > 0);
        res.put("updated", updated);
        return res;
    }

    /** ✅ 삭제 */
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
