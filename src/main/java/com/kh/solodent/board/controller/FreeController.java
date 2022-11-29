package com.kh.solodent.board.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
			 currentPage = page; 
		 } 
		 int lisrtCount =fService.getListCount();
		 PageInfo pi = Pagination.getPageInfo(currentPage, lisrtCount, 5);
		 
		 
		 ArrayList<Board> list = fService.selectBoardList(pi);
		 ArrayList<Board> notice = fService.selectNoticeList();
		 System.out.println("notice" + notice);
		 if(list != null) {
			 model.addAttribute("pi", pi);
			 model.addAttribute("list", list);
			 model.addAttribute("notice", notice);
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
	@RequestMapping(value ="freeWriter.fe")
	public String freeWriter() {
		return "freeWriter";
	}
	
	
		
	  @RequestMapping(value ="freeInsert.fe", method = RequestMethod.POST) 
	  public String writeBoard(@ModelAttribute Board b, HttpSession session, Model model) { 
		  String id =((Member)session.getAttribute("loginUser")).getId(); 
		  b.setUserId(id);
		  System.out.println(b);
		  int result = fService.insertBoard(b); 
		  
		  if(result > 0) {
			  return "redirect:freeHome.fe";
		  }else {
			  throw new BoardException("게시글 작성 실패");
		  }
		  
	  }
	 @RequestMapping("selectBoard.fe")
	 public ModelAndView selectBoard(@RequestParam("bId") int bId, @RequestParam("writer")String writer,
			 					@RequestParam("page") int page, HttpSession session, ModelAndView mv
			 					) {
		 Member m = (Member)session.getAttribute("loginUser");
		 String login = null;
		 
		 System.out.println("bid는" + bId);
		 
		 if(m != null) {
			 login = m.getId();
		 }
		 boolean yn = false;
		 if(!writer.equals(login)) {
			 yn = true;
		 }
		 Board b = fService.selectBoard(bId, yn);
		 if(b != null) {
			 mv.addObject("b", b);
			 mv.addObject("page", page);
			 mv.setViewName("freeDetail");
			 return mv;
		 }else {
			 throw new BoardException("게시글 상세보기 실패");
		 }
		
	 }
	
}
