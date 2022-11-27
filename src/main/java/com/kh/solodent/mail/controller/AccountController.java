package com.kh.solodent.mail.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.solodent.mail.RegisterMail;

@Controller
public class AccountController {

	@Autowired
	private RegisterMail rm;

	// 이메일 인증
	// 이메일 인증
	@RequestMapping("pleaseMail.me")
	@ResponseBody
	String mailConfirm(@RequestParam("email") String email) throws Exception {
		String code = rm.sendSimpleMessage(email);
		System.out.println("인증코드 : " + code);
		return code;
	}
}
