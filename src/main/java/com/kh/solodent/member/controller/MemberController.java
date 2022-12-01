package com.kh.solodent.member.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.member.model.exception.MemberException;
import com.kh.solodent.member.model.service.MemberService;
import com.kh.solodent.member.model.vo.Member;

@SessionAttributes("loginUser")
@Controller
public class MemberController {

	@Autowired
	private MemberService mService;
	@Autowired
	private BCryptPasswordEncoder bcrypt;

	@RequestMapping(value = "loginView.me", method = RequestMethod.GET)
	public String loginView() {
		System.out.println("로그인 처리");
		return "login";
	}

	// 로그아웃 2
	@RequestMapping("logout.me")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:home.do";
	}

	// 회우너가입 페이지 이동
	@RequestMapping("enroll.me")
	public String enroll() {
		return "enroll";
	}

	// 암호화 후 로그인
	@RequestMapping(value = "login.me", method = RequestMethod.POST)
	public String login(Member m, Model model) {
		Member loginUser = mService.login(m);
		System.out.println(loginUser);
		System.out.println(m);
		System.out.println(bcrypt);
		String encPwd = bcrypt.encode(m.getPwd());
		System.out.println(encPwd);
		if (bcrypt.matches(m.getPwd(), loginUser.getPwd())) {
			model.addAttribute("loginUser", loginUser);
			return "redirect:home.do";

		} else {
			throw new MemberException("로그인에 실패하였습니다");
		}
	}

	// 회원가입
	@RequestMapping("insertMember.me")
	public String insertMember(@ModelAttribute Member m, @RequestParam("yyyy") String yyyy,
			@RequestParam("mm") String mm, @RequestParam("dd") String dd) {
		System.out.println(m);

		String birthDate = null;
		if (!yyyy.trim().equals("")) {
			birthDate = yyyy + "년" + mm + "월" + dd + "일";
		}

		m.setBirthDate(birthDate);

		String encPwd = bcrypt.encode(m.getPwd());

		m.setPwd(encPwd);
		int result = mService.insertMember(m);

		if (result > 0) {
			return "redirect:home.do";
		} else {
			throw new MemberException("회원가입 실패");
		}
	}

	// 마이페이지
	@RequestMapping("myInfo.me")
	public String myInfo(HttpSession session, Model model) {
		String id = ((Member) session.getAttribute("loginUser")).getId();

		ArrayList<HashMap<String, Object>> list = mService.selectMyList(id);
		/*
		 * ArrayList<Board>b = mService.selectMyScrab(id); model.addAttribute("b",b);
		 */
		model.addAttribute("list", list);
		return "myInfo";

	}

	// 아이디찾기 페이지 이동
	@RequestMapping("findId.me")
	public String findId() {
		return "findId";
	}

	// 아이디찾기 페이지 이동
	@RequestMapping("findPwd.me")
	public String findPwd() {
		return "findPwd";
	}

	// 아이디체크
	@RequestMapping("checkId.me")
	@ResponseBody
	public String checkId(@RequestParam("id") String id) {
		int count = mService.checkId(id);
		String result = count == 0 ? "yes" : "no";

		return result;
	}

	// 닉네임체크
	@RequestMapping("checkNickName.me")
	@ResponseBody
	public String checkNickName(@RequestParam("nickName") String nickName) {
		int count = mService.checkNickName(nickName);
		String result = count == 0 ? "yes" : "no";

		return result;
	}

	// 회원 수정
	@RequestMapping("updateMember.me")
	public String updateMember(@ModelAttribute Member m, Model model, @RequestParam("pwd1") String pwd1) {
		String pwd = null;
		System.out.println("확인" + m);
		System.out.println(pwd1);
		if (pwd1.trim().equals("")) {
			String nuPwd = pwd1;
			m.setPwd(nuPwd);
		} else {
			m.setPwd(bcrypt.encode(pwd1));
		}
		int result = mService.updateMember(m);

		if (result > 0) {
			model.addAttribute("loginUser", mService.login(m));
			return "redirect:myInfo.me";
		} else {
			throw new MemberException("회원수정을 실패하였습니다.");
		}

	}

	

	@RequestMapping("deal.me")
	public String deal() {
		return "deal";
	}

	@RequestMapping("dealRegister.me")
	public String dealRegister() {
		return "dealRegister";
	}
	@RequestMapping("findIdDetail.me")
	public String findIdDetail(@RequestParam("email") String email, Model model) {
		String findEmail = mService.finEmail(email);
		if(findEmail !=null){
			model.addAttribute("findEmail", findEmail);
			return "findIdDetail";
		}else {
			throw new MemberException("등록된 이메일이 없습니다.");
		}
	}
	@RequestMapping("findPwdDetail.me")
	public String findPwdDetail(@ModelAttribute Member m, Model model) {
		String findPwd = mService.findPwd(m);
		System.out.println("나누누누누누누"+findPwd);
		if(findPwd != null) {
			model.addAttribute("findPwd", findPwd);
			return "changePwd";
		}else {
			throw new MemberException("등록된 회원정보가 없습니다.");
		}
		
	}
	@RequestMapping("changePwd.me")
	public String changePwd(@ModelAttribute Member m, @RequestParam("bId")String bId) {
		String bpwd = bcrypt.encode(m.getPwd());
		m.setId(bId.trim());
		m.setPwd(bpwd);
		System.out.println(m + "m체크");
		System.out.println(bId + "bId체크");
		System.out.println(bpwd + "bpwd체크");
		System.out.println(m);
		int change = mService.changePwd(m);
		System.out.println(change);
		if(change > 0) {
			return "login";
		}else {
			throw new MemberException("비밀번호 변경이 작동되지 않았습니다.");
		}
	}
	@RequestMapping("myInfoBoard.me")
	public String myInfoBoard(HttpSession session, Model model) {
		String id = ((Member)session.getAttribute("loginUser")).getId();
		
		ArrayList<Board> b = mService.myInfoBoard(id);
		System.out.println(b+ "dsakdklasjlasflka");
		model.addAttribute("b",b);
		return "myInfoBoard";
		
	}
	@RequestMapping("myInfoDoard.me")
	public String myInfoDoard(HttpSession session, Model model) {
		String id = ((Member)session.getAttribute("loginUser")).getId();
		
		ArrayList<Reply> r = mService.myInfoDoard(id);
		model.addAttribute("r",r);
		return "myInfoDoard";
		
	}
}
