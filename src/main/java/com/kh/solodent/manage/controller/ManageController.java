package com.kh.solodent.manage.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.solodent.manage.model.service.ManageService;
import com.kh.solodent.manage.model.vo.DeclareManager;

@Controller
public class ManageController {
	
	@Autowired
	private ManageService mngService;

	@RequestMapping("declaremanage.mng")
	public String getDeclareList(Model model) {
		ArrayList<DeclareManager> list = mngService.getDeclareList();
		System.out.println(list);
		if(list!=null) {
			model.addAttribute("list",list);
			return "declaremanage";
		}else {
			model.addAttribute("msg","신고목록을 찾을 수 없습니다.");
			return "declaremanage";
		}
	}
	
	@RequestMapping("deleteMember.mng")
	public String deleteMember(
			@RequestParam(value="userId", required=false) String[] userIds, 
			Model model) {
		
		// userId의 각 값을 .trim() 한 값이 중복되지 않아야 한다.
		System.out.println(userIds);
		int result = mngService.deleteMember(userIds);
		System.out.println(result);
		if(result>0) {
			ArrayList<DeclareManager> list = mngService.getDeclareList();
			model.addAttribute("list",list);
			return "redirect: declaremanage.mng";
		}else {
			model.addAttribute("msg","신고목록을 찾을 수 없습니다.");
			return "redirect: declaremanage.mng";
		}
		
	}

		
}
