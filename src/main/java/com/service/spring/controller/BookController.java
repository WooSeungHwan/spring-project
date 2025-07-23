package com.service.spring.controller;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.service.spring.domain.Book;
import com.service.spring.service.BookService;

@Controller
public class BookController {
	
	@Autowired
	private BookService bookService;
	
	@GetMapping("bookList")
	public ModelAndView getBooks(HttpSession session) throws Exception{
		try {
			List<Book> list = bookService.getBooks();
			
			return new ModelAndView("book/bookList", "list", list);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			
			return new ModelAndView("redirect:/Error.jsp");
		}
		
	}
	
	@PostMapping("bookRegister")
	public ModelAndView register(Book book, String isbn1, String isbn2, String isbn3, HttpSession session)throws Exception{		
		book.setIsbn(isbn1 + "-" + isbn2 + "-" + isbn3);

		System.out.println("register BookVO before:: " + book);
		
		String msg = "";
		String path = "Error.jsp";
		
		try {
			bookService.insertBook(book);
			msg = "책 등록 성공";
			
			path = "redirect:/result.jsp";
			
		} catch(Exception e) {
			msg = "책 등록 실패";
			
			System.out.println(e.getMessage());
		}
		
		session.setAttribute("msg", msg);
		return new ModelAndView(path);
	}
	
	@GetMapping("bookSearch")
    public ModelAndView search(String searchField, String searchText, HttpServletRequest request) throws Exception{ 
		List<Book> list = null;
		String path = "find_fail";
		String msg = "";
		
		try {
			switch (searchField) {
			case "TITLE":
				list = bookService.searchByTitle(searchText);
				break;
			case "PUBLISHER":
				list = bookService.searchByPublisher(searchText);
				break;
			case "PRICE":
				list = bookService.searchByPrice(Integer.parseInt(searchText));
				break;
			default:
				list = bookService.getBooks();
			}
			
			path = "/book/bookList";
			
			request.setAttribute("search", searchField);
			request.setAttribute("text", searchText);
					
			return new ModelAndView(path, "list", list);
			
		} catch(Exception e) {
			System.out.println(e.getMessage());
			
			return new ModelAndView("redirect:/Error.jsp");
		}
		
		
	}
	
	@GetMapping("bookView")
    public ModelAndView bookview(String isbn) throws Exception {	
		try {
			Book book = bookService.searchByIsbn(isbn);
			
			return new ModelAndView("book/bookView", "book", book);
		}catch(Exception e) {
			System.out.println(e.getMessage());
			
			return new ModelAndView("redirect:/Error.jsp");
		}
	}	
	
	@GetMapping("/bookAjax")
	@ResponseBody
	public Book bookDetail(String isbn) {
		Book book = null;
		
		try {
			book = bookService.getIsbn(isbn);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return book;
	}
}//





