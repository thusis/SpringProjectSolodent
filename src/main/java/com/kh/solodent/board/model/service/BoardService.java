package com.kh.solodent.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.dao.BoardDAO;
import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.Used;

import oracle.net.aso.b;

@Service("bService")
public class BoardService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private BoardDAO bDAO;
	
	public int insertBoard(Board b) {
		return bDAO.insertBoard(sqlSession, b);
	}

	public int insertAttm(ArrayList<Attachment> list) {
		return bDAO.insertAttm(sqlSession, list);
	}

	public int insertUsed(Used used) {
		return bDAO.insertUsed(sqlSession, used);
	}

	public ArrayList<Board> selectUsedList(int i) {
		return bDAO.selectUsedList(sqlSession, i);
	}

	public ArrayList<Used> selectUsedDetailList() {
		return bDAO.selectUsedDetailList(sqlSession);
	}

	public ArrayList<Attachment> selectAttmList(Integer bId) {
		return bDAO.selectAttmList(sqlSession, bId);
	}

	public Board selectBoard(Integer bId, boolean yn) {
		int result = 0;
		if(yn) {
			result = bDAO.addCount(sqlSession, bId);
		}
		
		return bDAO.selectBoard(sqlSession, bId);
	}

	public Used selectUsed(Integer bId) {
		return bDAO.selectUsed(sqlSession, bId);
	}

	public int isLike(Like like) {
		return bDAO.isLike(sqlSession, like);
	}

	public int addLike(Like like) {
		return bDAO.addLike(sqlSession, like);
	}

	public int deleteLike(Like like) {
		return bDAO.deleteLike(sqlSession, like);
	}

	public int selectLikeCount(int boardId) {
		return bDAO.selectLikeCount(sqlSession, boardId);
	}

	public int deleteBoard(int boardId) {
		return bDAO.deleteBoard(sqlSession, boardId);
	}

	public int deleteUsed(int boardId) {
		return bDAO.deleteUsed(sqlSession, boardId);
	}

	public ArrayList<Board> searchUsed(HashMap<String, String> map) {
		return bDAO.searchUsed(sqlSession, map);
	}

	public int deleteAttm(ArrayList<String> delRename) {
		return bDAO.deleteAttm(sqlSession, delRename);
	}

	public void updateIsThum(int boardId) {
		bDAO.updateIsThum(sqlSession, boardId);
	}

	public int updateBoard(Board b) {
		return bDAO.updateBoard(sqlSession, b);
	}

	public int updateUsed(Used used) {
		return bDAO.updateUsed(sqlSession, used);
	}

	
	

}
