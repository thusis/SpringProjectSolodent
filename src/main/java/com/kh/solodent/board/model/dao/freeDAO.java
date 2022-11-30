package com.kh.solodent.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;

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

	public int addCount(SqlSessionTemplate sqlSession, int bId) {
		// TODO Auto-generated method stub
		return sqlSession.update("freeMapper.addCount", bId);
	}

	public Board selectBoard(SqlSessionTemplate sqlSession, int bId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("freeMapper.selectBoard", bId);
	}

	public ArrayList<Board> selectNoticeList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("freeMapper.selectNoticeList");
	}

	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("freeMapper.selectBoard5");
		
	}

	public ArrayList<Board> selectBoardListM(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("freeMapper.selectBoardM");
		
	}

	public int insertDboardInsert(SqlSessionTemplate sqlSession, Reply r) {
		// TODO Auto-generated method stub
		return sqlSession.insert("freeMapper.DboardInsert", r);
	}

	public Board selectBoardb(SqlSessionTemplate sqlSession, int bId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("freeMapper.selectBoardb", bId);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		// TODO Auto-generated method stub
		return sqlSession.update("freeMapper.updateBoard", b);
	}

	public ArrayList<Reply> selectReply(SqlSessionTemplate sqlSession, int bId) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.selectReply", bId);
	}

	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		// TODO Auto-generated method stub
		return sqlSession.insert("freeMapper.insertReply", r);
	}


	}


