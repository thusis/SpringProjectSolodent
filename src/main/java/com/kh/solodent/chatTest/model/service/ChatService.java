package com.kh.solodent.chatTest.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.chatTest.model.dao.ChatDAO;
import com.kh.solodent.chatTest.model.vo.Chat;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatService {
	
	@Autowired
	private ChatDAO chatDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertChat(Chat chat) {
		return chatDAO.insertChat(sqlSession, chat);
	}



	public ArrayList<Chat> selectFirstChatList(int roomNo) {

		return chatDAO.selectFirstChatList(sqlSession, roomNo);
	}



	public List<Chat> messageList(Chat chat) {
	
		return chatDAO.messageList(sqlSession, chat);
	}



	public void updateReadCnt(Chat chat) {
		 chatDAO.updateReadCnt(sqlSession, chat);		
	}



	public List<Chat> messageNotificationList(Chat chat) {
		return chatDAO.messageNotificationList(sqlSession, chat);
	}



	public void endChat(Chat chat) {
		 chatDAO.endChat(sqlSession, chat);		
	}

	
	

}
