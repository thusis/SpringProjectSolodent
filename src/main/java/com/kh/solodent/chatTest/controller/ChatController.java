package com.kh.solodent.chatTest.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.solodent.chatTest.model.service.ChatService;
import com.kh.solodent.chatTest.model.vo.Chat;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
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
	
	// 채팅 메세지 전달
    @MessageMapping("/hello/{roomNo}")
    @SendTo("/subscribe/chat/{roomNo}")
    public Chat broadcasting(Chat chat) {

    	log.debug("받아온 data={}",chat);
    	HashMap<String,Object> map = new HashMap();
    	map.put("chat", chat);
    	
//        chat.setSendDate(new Date());
    	/** 수정해주세요
    	 * @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    	 */
    	
//        int result = chatService.insertChat(chat);
        log.info("selectkey 사용 = {}",chat);
        return chat;
    }
    
//  //채팅 저장
//  @RequestMapping("/chat/insertChat.do")
//  @ResponseBody
//  public int insertChat(Chat chat) {
//  	Map<String,Object> map = new HashMap<>();
//  	map.put("chat", chat);
//  	int result = chatService.insertChat(chat);
//  	return result; //차차 수정 갈아엎어야할수도...?
//  }
  
	
}
