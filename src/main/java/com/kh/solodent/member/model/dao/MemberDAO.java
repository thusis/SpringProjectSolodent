package com.kh.solodent.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.member.model.vo.Member;

@Repository("mDAO")
public class MemberDAO {

	public Member login(SqlSessionTemplate sqlSession, Member m) {
		System.out.println(m);
		return sqlSession.selectOne("memberMapper.login", m);
		
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public int checkNickName(SqlSessionTemplate sqlSession, String nickName) {
		return sqlSession.selectOne("memberMapper.checkNickName",nickName);
	}

	public int checkId(SqlSessionTemplate sqlSession, String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.checkId",id);
	}

	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.updateMember", m);
	}

	public ArrayList<HashMap<String, Object>> selectMyList(SqlSessionTemplate sqlSession, String id) {
		ArrayList<HashMap<String, Object>> list = (ArrayList)sqlSession.selectList("memberMapper.selectMyList", id);
		
		return list;
	}

	public String findEmail(SqlSessionTemplate sqlSession, String email) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.findEmail", email);
	}

	public String finPwd(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.findPwd", m);
	}

	public int changePwd(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return sqlSession.update("memberMapper.changePwd", m);
	}

	public ArrayList<Board> myInfoBoard(SqlSessionTemplate sqlSession, String id) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("memberMapper.myInfoBoard", id);
	}

	public ArrayList<Reply> myInfoDoard(SqlSessionTemplate sqlSession, String id) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("memberMapper.myInfoDoard", id);
	}

	public ArrayList<Board> selectMyScrab(SqlSessionTemplate sqlSession, String id) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("memberMapper.selectMyScrab", id);
	}

	
}
