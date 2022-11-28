package com.kh.solodent.board.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.solodent.board.common.Pagination;
import com.kh.solodent.board.model.exception.BoardException;
import com.kh.solodent.board.model.service.FreeService;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.member.model.service.MemberService;
import com.kh.solodent.member.model.vo.Member;

@Controller
public class FreeController {
	
	@Autowired
	private FreeService fService;

	@RequestMapping("freeHome.fe")
	public String selectBoardList(@RequestParam(value="page", required=false) Integer page, Model model) {
		
		 int currentPage = 1; 
		 if(page != null) { 
			 currentPage = 1; 
		 } 
		 int lisrtCount =fService.getListCount();
		 PageInfo pi = Pagination.getPageInfo(currentPage, lisrtCount, 5);
		 
		 
		 ArrayList<Board> list = fService.selectBoardList(pi);
		 
		 if(list != null) {
			 model.addAttribute("pi", pi);
			 model.addAttribute("list", list);
			 
			 return "freeHome";
		 }else {
			 throw new BoardException("게시글 조회 실패");
		 }
		
	/*public String selectNoTice(Model model) {*/
		
//		String Notice = fService.selectNoTice();
//		System.out.println(Notice);
//		model.addAttribute("Notice", Notice);
//		
		
		
	}
	@RequestMapping("freeWriter.fe")
	public String freeWriter() {
		return "freeWriter";
	}
	
	
		
	  @RequestMapping("freeInsert.fe") 
	  public String writeBoard(@ModelAttribute Board b, HttpSession session, Model model) { 
		  String id =((Member)session.getAttribute("loginUser")).getId(); 
		  b.setUserId(id);
		  System.out.println(b);
		  int result = fService.insertBoard(b); 
		  
		  if(result > 0) {
			  return "freeHome"; 
		  }else {
			  throw new BoardException("게시글 작성 실패");
		  }
		  
	  }
	 
	
}
