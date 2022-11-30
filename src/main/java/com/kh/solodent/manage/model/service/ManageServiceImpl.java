package com.kh.solodent.manage.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.manage.model.dao.ManageDAO;
import com.kh.solodent.manage.model.vo.DeclareManager;

@Service
public class ManageServiceImpl implements ManageService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ManageDAO mngDAO;
	
	@Override
	public ArrayList<DeclareManager> getDeclareList() {
		return mngDAO.getDeclareList(sqlSession);
	}

	@Override
	public int deleteMember(String[] userIds) {
		return mngDAO.deleteMember(sqlSession, userIds);
	}

}
