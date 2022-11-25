package com.kh.solodent.board.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("fDAO")
public class freeDAO {

	public String selectNoTice(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne("freeMapper.selectNoTice");
	}

}
