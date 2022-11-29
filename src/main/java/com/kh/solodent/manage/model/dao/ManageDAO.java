package com.kh.solodent.manage.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.solodent.manage.model.vo.DeclareManager;

@Repository("mngDAO")
public class ManageDAO {

	public ArrayList<DeclareManager> getDeclareList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("manageMapper.getDeclareList");
	}

	public int deleteMember(SqlSessionTemplate sqlSession, String[] userIds) {
		return sqlSession.update("manageMapper.updateDeleteMember",userIds);
	}

}
