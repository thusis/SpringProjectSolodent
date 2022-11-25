package com.kh.solodent.board.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.dao.freeDAO;


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
}
