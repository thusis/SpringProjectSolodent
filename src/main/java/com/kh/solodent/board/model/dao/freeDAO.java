package com.kh.solodent.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.PageInfo;

@Repository("fDAO")
public class freeDAO {

	public String selectNoTice(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne("freeMapper.selectNoTice");
	}

	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("freeMapper.selectBoardList", null, rowBounds);
	}

	public int getListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("freeMapper.getListCount");
	}


	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		System.out.println(b);
		return sqlSession.insert("freeMapper.insertBoard", b);
	}

}
