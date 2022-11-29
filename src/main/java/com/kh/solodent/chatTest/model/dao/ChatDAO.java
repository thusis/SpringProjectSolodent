package com.kh.solodent.chatTest.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.solodent.chatTest.model.vo.Chat;

@Repository
public class ChatDAO {

	public int insertChat(SqlSessionTemplate sqlSession, Chat chat) {		
		return sqlSession.insert("chatMapper.insertChat",chat);
	}

	
	
	public ArrayList<Chat> selectFirstChatList(SqlSessionTemplate sqlSession, int roomNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.selectFistChatList", roomNo);
	}



	public List<Chat> messageList(SqlSessionTemplate sqlSession, Chat chat) {
		return (ArrayList)sqlSession.selectList("chatMapper.messageList", chat);
	}


	public void updateReadCnt(SqlSessionTemplate sqlSession , Chat chat) {
		sqlSession.update("chatMapper.updateReadCnt", chat);		
	}



	public List<Chat> messageNotificationList(SqlSessionTemplate sqlSession, Chat chat) {
		return (ArrayList)sqlSession.selectList("chatMapper.messageNotificationList", chat);
	}



	public void endChat(SqlSessionTemplate sqlSession, Chat chat) {
		sqlSession.delete("chatMapper.endChat", chat);		
	}

	

}
