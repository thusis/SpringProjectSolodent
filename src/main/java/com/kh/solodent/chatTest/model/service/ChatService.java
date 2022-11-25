package com.kh.solodent.chatTest.model.service;

import java.util.ArrayList;

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


}
