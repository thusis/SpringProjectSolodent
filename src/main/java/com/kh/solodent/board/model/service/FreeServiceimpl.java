package com.kh.solodent.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.dao.freeDAO;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;


@Service("fService")
public class FreeServiceimpl implements FreeService {
	
	@Autowired
	private freeDAO fDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public String selectNoTice() {
		return fDAO.selectNoTice(sqlSession);
	}

	@Override
	public int getListCount() {
		// TODO Auto-generated method stub
		return fDAO.getListCount(sqlSession);
	}



	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi) {
		// TODO Auto-generated method stub
		return fDAO.selectBoardList(sqlSession, pi);
	}

	@Override
	public int insertBoard(Board b) {
		// TODO Auto-generated method stub
		return fDAO.insertBoard(sqlSession, b);
	}

	@Override
	public Board selectBoard(int bId, boolean yn) {
		int result = 0;
		if(yn) {
		
		 result = fDAO.addCount(sqlSession, bId);
		}
		Board b = fDAO.selectBoard(sqlSession, bId);
		return b;
	}

	@Override
	public ArrayList<Board> selectNoticeList() {
		// TODO Auto-generated method stub
		return fDAO.selectNoticeList(sqlSession);
	}

	@Override
	public ArrayList<Board> selectBoard5() {
		// TODO Auto-generated method stub
		return fDAO.selectBoardList(sqlSession);
	}

	@Override
	public ArrayList<Board> selectBoardM() {
		// TODO Auto-generated method stub
		return fDAO.selectBoardListM(sqlSession);
	}

	@Override
	public int insertDboard(Reply r) {
		// TODO Auto-generated method stub
		return fDAO.insertDboardInsert(sqlSession, r);
	}

	@Override
	public Board selectBoardb(int bId) {
		// TODO Auto-generated method stub
		return fDAO.selectBoardb(sqlSession, bId);
	}

	@Override
	public int UpdateBoard(Board b) {
		// TODO Auto-generated method stub
		return fDAO.updateBoard(sqlSession, b);
	}

	@Override
	public ArrayList<Reply> selectReply(int bId) {
		// TODO Auto-generated method stub
		return fDAO.selectReply(sqlSession, bId);
	}

	@Override
	public int insertReply(Reply r) {
		// TODO Auto-generated method stub
		return fDAO.insertReply(sqlSession, r);
	}



	

	
}
	
	
