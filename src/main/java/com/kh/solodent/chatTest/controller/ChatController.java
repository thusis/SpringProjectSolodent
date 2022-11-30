package com.kh.solodent.chatTest.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.solodent.chatTest.model.service.ChatService;
import com.kh.solodent.chatTest.model.vo.Chat;
import com.kh.solodent.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat/")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	/**
	 * 메시지 보내기
	 * @param chat
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@PostMapping(value ="send.do" )
	public ResponseEntity<?> sendChat(Chat chat , HttpSession session) throws Exception {
		
		Member member=(Member)session.getAttribute("loginUser");
		if(member==null) return  ResponseEntity.status(HttpStatus.BAD_REQUEST).body("loginFail");		
		
		chat.setSendId(member.getId());
	    //System.out.println("chat  : " + chat.toString());
	    
		chatService.insertChat(chat);
		return ResponseEntity.status(HttpStatus.OK).body(member.toString());
	}
	
	/**
	 * 메시지 목록 보기
	 * @param chat
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping("messageList.do")
	public String  messageList(Chat chat, HttpSession session, Model model) throws Exception{
		Member member=(Member)session.getAttribute("loginUser");
		if(member==null) return  "redirect:/loginView.me";	
		chat.setSendId(member.getId());
		chat.setMyId(member.getId());
		chat.setOtherId(chat.getReceivedId());
		
		chatService.updateReadCnt(chat);
		
		List<Chat> messageList =chatService.messageList(chat);
		
		model.addAttribute("receiveId" , chat.getOtherId());
		model.addAttribute("messageList" ,messageList);
		return "/chat/chat";
	}
	
	
	/** http://localhost:8080/solodent/chat/notificationList.do
	 * 메시지 알림
	 * @param chat
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@PostMapping("notificationList.do")
	public String notificationList(Chat chat, HttpSession session, Model model) throws Exception{
		Member member=(Member)session.getAttribute("loginUser");
		if(member==null) return  "redirect:/loginView.me";	
		
		chat.setReceivedId(member.getId());
		
		List<Chat> notificationList =chatService.messageNotificationList(chat);	
		//System.out.println("notificationList  :  " +notificationList.size());
		model.addAttribute("notificationList" ,notificationList);
		return "/chat/notification";
	}
	
	
	/**
	 * 채팅방 나가기
	 * @param roomNo
	 * @param mv
	 * @param session
	 * @return
	 */
	@PostMapping("endChat.do")
	public ResponseEntity<?> endChat(Chat chat , HttpSession session) throws Exception {		
		Member member=(Member)session.getAttribute("loginUser");
		if(member==null) return  ResponseEntity.status(HttpStatus.BAD_REQUEST).body("loginFail");		
		
		chat.setSendId(member.getId());	    
		chatService.endChat(chat);		
		return ResponseEntity.status(HttpStatus.OK).body("success");
	}
	
	
	
	
	//채팅방 입장
	@RequestMapping("/enter/chat.do")
    public ModelAndView enterChat(@RequestParam int roomNo,ModelAndView mv,HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		ArrayList<Chat> firstList = chatService.selectFirstChatList(roomNo);
		mv.addObject("roomNo",roomNo);
		mv.addObject("memberId",memberId);
		mv.addObject("firstList",firstList);
		mv.setViewName("chat");
    	return mv;
    }
	
	

	
	
	
	
	


	
}
