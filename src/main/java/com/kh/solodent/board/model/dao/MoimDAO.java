package com.kh.solodent.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Moim;
import com.kh.solodent.board.model.vo.PageInfo;

@Repository("moimDAO")
public class MoimDAO {

	// 페이징처리
	public int getListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("moimMapper.getListCount");
	}

	// 모임 게시글 전체 불러오기
	public ArrayList<Moim> selectMoimList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		ArrayList<Moim> moimlist = (ArrayList)sqlSession.selectList("moimMapper.selectMoimList", null, rowBounds);
		System.out.println(moimlist);
		return moimlist;
	}

	// 모임 게시글 내부 혹은 모임 게시판 전체에서 이미지 리스트 가져오기
	public ArrayList<Attachment> selectMoimAttm(SqlSessionTemplate sqlSession, ArrayList<Moim> list) {
		return (ArrayList)sqlSession.selectList("moimMapper.selectMoimAttm", list);
	}

	// 모임 게시글 삽입
	public int insertMoim(SqlSessionTemplate sqlSession, Moim moim, ArrayList<Attachment> list) {
		Map<String, Object> map = new HashMap<>();
		map.put("moim", moim);
		map.put("list", list);

		return sqlSession.insert("moimMapper.insertMoim", map);
	}

	// 조회수 올리기
	public int addCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.update("moimMapper.addCount", boardId);
	}

	// 모임 게시글 상세 조회
	public Moim selectMoim(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("moimMapper.selectMoim", boardId);
	}

	public ArrayList<Attachment> selectAttmList(SqlSessionTemplate sqlSession, Integer boardId) {
		return (ArrayList)sqlSession.selectList("moimMapper.selectAttmList", boardId);
	}

	
	

}
