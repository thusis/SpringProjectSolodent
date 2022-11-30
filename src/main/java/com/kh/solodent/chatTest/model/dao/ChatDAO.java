package com.kh.solodent.chatTest.model.dao;

import java.util.ArrayList;

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


}
