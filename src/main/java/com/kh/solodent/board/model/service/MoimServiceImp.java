package com.kh.solodent.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.dao.MoimDAO;
import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Moim;
import com.kh.solodent.board.model.vo.PageInfo;

@Service("moimService")
public class MoimServiceImp implements MoimService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MoimDAO mDAO;
	
	@Override
	public int getListCount() {
		return mDAO.getListCount(sqlSession);
	}

	@Override
	public ArrayList<Moim> selectMoimList(PageInfo pi) {
		return mDAO.selectMoimList(sqlSession, pi);
	}

	@Override
	public ArrayList<Attachment> selectMoimAttm(ArrayList<Moim> list) {
		return mDAO.selectMoimAttm(sqlSession,list);
	}

	@Override
	public int insertMoim(Moim moim, ArrayList<Attachment> list) {
		return mDAO.insertMoim(sqlSession, moim, list);
	}

	@Override
	public Moim selectMoim(int boardId, boolean yn) {
		int result = 0;
		if(yn) {
			result = mDAO.addCount(sqlSession, boardId);
		}
		Moim moim = mDAO.selectMoim(sqlSession,boardId);
		return moim;
	}

	@Override
	public ArrayList<Attachment> selectAttmList(Integer boardId) {
		return mDAO.selectAttmList(sqlSession, boardId);
	}


}
