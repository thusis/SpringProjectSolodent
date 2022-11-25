package com.kh.solodent.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.Used;

import oracle.net.aso.b;

@Repository("bDAO")
public class BoardDAO {

	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}

	public int insertAttm(SqlSessionTemplate sqlSession, ArrayList<Attachment> list) {
		return sqlSession.insert("boardMapper.insertAttm", list);
	}

	public int insertUsed(SqlSessionTemplate sqlSession, Used used) {
		return sqlSession.insert("boardMapper.insertUsed", used);
	}

	public ArrayList<Board> selectUsedList(SqlSessionTemplate sqlSession, int i) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectUsedList", i);
	}

	public ArrayList<Used> selectUsedDetailList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectUsedDetailList");
	}

	public ArrayList<Attachment> selectAttmList(SqlSessionTemplate sqlSession, Integer bId) {
		return(ArrayList)sqlSession.selectList("boardMapper.selectAttmList", bId);
	}

	public int addCount(SqlSessionTemplate sqlSession, Integer bId) {
		return sqlSession.update("boardMapper.addCount", bId);
	}

	public Board selectBoard(SqlSessionTemplate sqlSession, Integer bId) {
		return sqlSession.selectOne("boardMapper.selectBoard", bId);
	}

	public Used selectUsed(SqlSessionTemplate sqlSession, Integer bId) {
		return sqlSession.selectOne("boardMapper.selectUsed", bId);
	}

	public int isLike(SqlSessionTemplate sqlSession, Like like) {
		return sqlSession.selectOne("boardMapper.isLike", like);
	}

	public int addLike(SqlSessionTemplate sqlSession, Like like) {
		return sqlSession.insert("boardMapper.addLike", like);
	}

	public int deleteLike(SqlSessionTemplate sqlSession, Like like) {
		return sqlSession.delete("boardMapper.deleteLike", like);
	}

	public int selectLikeCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("boardMapper.selectLikeCount", boardId);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.update("boardMapper.deleteBoard", boardId);
	}

	public int deleteUsed(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.update("boardMapper.deleteUsed", boardId);
	}

	public ArrayList<Board> searchUsed(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return (ArrayList)sqlSession.selectList("boardMapper.searchUsed", map);
	}

	public int deleteAttm(SqlSessionTemplate sqlSession, ArrayList<String> delRename) {
		return sqlSession.delete("boardMapper.deleteAttm", delRename);
	}

	public void updateIsThum(SqlSessionTemplate sqlSession, int boardId) {
		sqlSession.update("boardMapper.updateIsThum", boardId);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}

	public int updateUsed(SqlSessionTemplate sqlSession, Used used) {
		return sqlSession.update("boardMapper.updateUsed", used);
	}


	

}
