package com.service.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.service.spring.domain.Member;
import jakarta.servlet.http.HttpSession;
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

import com.service.spring.domain.Note;
import com.service.spring.service.NoteService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/note")
public class NoteController {

    @Autowired
    private NoteService noteService;
    
    @GetMapping({"", "/"})
    public String notePage(HttpSession session, Model model) {
        int memId = -1;
        Member member = (Member)session.getAttribute("member");

        memId = member.getMemId();

        try {
            List<Note> noteList = noteService.getAllNote(memId);
            model.addAttribute("noteList", noteList);
        } catch (Exception e) {
            // e.printStackTrace(); // 로깅 또는 에러 처리
            model.addAttribute("msg", e.getMessage());
        }
        return "pages/note/note"; // 뷰 리졸버 설정에 따라 note.jsp를 의미함
    }


    // ✅ JSP 페이지로 이동
    @GetMapping("/view")
    public String noteViewPage() {
        return "noteViewPage";  // /WEB-INF/views/noteViewPage.jsp
    }

    // ✅ 전체 메모 목록 (JSON)
    @GetMapping("/list")
    @ResponseBody
    public List<Note> getNotes(@RequestParam int memId,
                               @RequestParam(required = false) Boolean important) throws Exception {
        if (Boolean.TRUE.equals(important)) {
            return noteService.getImpNote(memId);
        }
        return noteService.getAllNote(memId);
    }

    
    @PostMapping("/addNote")
    @ResponseBody
    public Note addNote(@RequestBody Note dto, HttpSession session) throws Exception {
        Member login = (Member) session.getAttribute("member");
        if (login == null) {
            throw new RuntimeException("로그인이 필요합니다."); // or 401 응답
        }

        Note note = new Note();
        note.setMemId(login.getMemId());        // ✅ 클라이언트 memId 무시하고 서버에서 설정
        note.setNoteName(dto.getNoteName());
        note.setNoteContent(dto.getNoteContent());
        // 기타 필드 복사

        return noteService.addNote(note);
    }


    // ✅ 메모 수정
    @PutMapping("/updateNote")
    @ResponseBody
    public Map<String, Object> updateNote(@RequestBody Note note,
                                          HttpSession session) throws Exception {
        Integer memId = (Integer) session.getAttribute("memId");
        if (memId == null) memId = 1; // 테스트용
        note.setMemId(memId);

        int updated = noteService.changeNote(note); // update count 반환하도록

        Map<String, Object> res = new HashMap<>();
        res.put("success", updated > 0);
        res.put("updated", updated);
        res.put("noteId", note.getNoteId());
        return res;
    }

    // ✅ 메모 삭제
    @PostMapping("/delete")
    @ResponseBody
    public int deleteNote(@RequestParam int noteId) throws Exception {
        return noteService.deleteNote(noteId);
    }

    // ✅ 중요 표시 토글
    @PostMapping("/important")
    @ResponseBody
    public int toggleImportant(@RequestBody Note note) throws Exception {
        return noteService.isImpNote(note);
    }
}