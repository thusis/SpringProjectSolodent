package com.kh.solodent.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.dao.freeDAO;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.PageInfo;


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

	
	}
