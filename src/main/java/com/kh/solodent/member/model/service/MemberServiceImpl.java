package com.kh.solodent.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.member.model.dao.MemberDAO;
import com.kh.solodent.member.model.vo.Member;





@Service("mService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Member login(Member m) {
		// TODO Auto-generated method stub
		return mDAO.login(sqlSession, m);
	
	
	
	
	}

	@Override
	public int insertMember(Member m) {
		System.out.println(m);
		return mDAO.insertMember(sqlSession, m);

	}

	@Override
	public int checkNickName(String nickName) {
		// TODO Auto-generated method stub
		return mDAO.checkNickName(sqlSession, nickName);
	}

	@Override
	public int checkId(String id) {
		// TODO Auto-generated method stub
		return mDAO.checkId(sqlSession, id);
	}

	@Override
	public int updateMember(Member m) {
		return mDAO.updateMember(sqlSession, m);
	}

	@Override
	public ArrayList<HashMap<String, Object>> selectMyList(String id) {
		return mDAO.selectMyList(sqlSession, id);
	}
}
