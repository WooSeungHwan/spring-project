package com.service.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.service.spring.domain.Note;
import com.service.spring.service.NoteService;

@Controller
@RequestMapping("/note")
public class NoteController {

    @Autowired
    private NoteService noteService;

    @GetMapping("/note.jsp")
    public String notePage(@RequestParam int memId, Model model) {
        try {
            List<Note> noteList = noteService.getAllNote(memId);
            model.addAttribute("noteList", noteList);
        } catch (Exception e) {
            e.printStackTrace(); // 로깅 또는 에러 처리
        }
        return "note"; // 뷰 리졸버 설정에 따라 note.jsp를 의미함
    }


    // ✅ JSP 페이지로 이동
    @GetMapping("/view")
    public String noteViewPage() {
        return "noteViewPage";  // /WEB-INF/views/noteViewPage.jsp
    }

    // ✅ 전체 메모 목록 (JSON)
    @GetMapping("/list")
    @ResponseBody
    public List<Note> getAllNote(@RequestParam int memId) throws Exception {
        return noteService.getAllNote(memId);
    }

    // ✅ 메모 등록
    @PostMapping("/addNote")
    @ResponseBody
    public Note addNote(@RequestBody Note note) throws Exception {
        note.setMemId(1); // 테스트용
        return noteService.addNote(note);
    }

    // ✅ 메모 수정
    @PutMapping("/updateNote")
    @ResponseBody
    public Note updateNote(@RequestBody Note note) throws Exception {
        return noteService.changeNote(note);
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
