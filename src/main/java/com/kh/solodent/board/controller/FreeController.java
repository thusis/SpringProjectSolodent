package com.kh.solodent.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.solodent.board.model.service.FreeService;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.member.model.service.MemberService;
import com.kh.solodent.member.model.vo.Member;

@Controller
public class FreeController {
	
	@Autowired
	private FreeService fService;

	@RequestMapping("freeHome.fe")
	public String selectNoTice(Model model) {
		
//		String Notice = fService.selectNoTice();
//		System.out.println(Notice);
//		model.addAttribute("Notice", Notice);
//		
		
		return "freeWriter";
	}
	/*
	 * @RequestMapping("freeWriter.fe") public String freeWriter(HttpSession
	 * session, Model model) { String id =
	 * ((Member)session.getAttribute("loginUser")).getId(); Board b =
	 * fService.selectBoard(id); return "freeWriter"; }
	 */
	
}
