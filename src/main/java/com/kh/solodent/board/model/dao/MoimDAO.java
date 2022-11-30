package com.kh.solodent.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.BoardScrap;
import com.kh.solodent.board.model.vo.Declare;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.Moim;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.board.model.vo.ReplyLike;

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

	public ArrayList<Integer> getPageReplyCount(SqlSessionTemplate sqlSession, ArrayList<Moim> list) {
		return (ArrayList)sqlSession.selectList("moimMapper.getPageReplyCount", list);
	}

	public ArrayList<Integer> getPageLikeCount(SqlSessionTemplate sqlSession, ArrayList<Moim> list) {
		return (ArrayList)sqlSession.selectList("moimMapper.getPageLikeCount",list);
	}

	public ArrayList<Integer> getPageScrapCount(SqlSessionTemplate sqlSession, ArrayList<Moim> list) {
		return (ArrayList)sqlSession.selectList("moimMapper.getPageScrapCount", list);
	}

	public ArrayList<Reply> getBoardReplyList(SqlSessionTemplate sqlSession, int boardId) {
		return (ArrayList)sqlSession.selectList("moimMapper.getBoardReplyList", boardId);
	}

	///////////////////여기 replylikecount는 좋아요 수(전체멤버의) 카운트
	public ArrayList<Integer> getBoardReplyLikeCount(SqlSessionTemplate sqlSession, ArrayList<Reply> replyList) {
		return (ArrayList)sqlSession.selectList("moimMapper.getBoardReplyLikeCount", replyList);
	}

	public int getBoardScrapCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("moimMapper.getBoardScrapCount",boardId);
	}

	public int getBoardLikeCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("moimMapper.getBoardLikeCount",boardId);
	}

	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("moimMapper.insertReply", r);
	}

	public int isLike(SqlSessionTemplate sqlSession, Like like) {
		int result = sqlSession.selectOne("moimMapper.isBoardLike", like);
		return result;
	}

	public void setBoardLike(SqlSessionTemplate sqlSession, Like likevo) {
		sqlSession.insert("moimMapper.setBoardLike",likevo);
	}

	public void deleteBoardLike(SqlSessionTemplate sqlSession, Like likevo) {
		sqlSession.delete("moimMapper.deleteBoardLike",likevo);
	}
	
	public ArrayList<Moim> selectTopThree(SqlSessionTemplate sqlSession){
		ArrayList<Integer> boardIds = (ArrayList)sqlSession.selectList("moimMapper.selectTopThree");
		return (ArrayList)sqlSession.selectList("moimMapper.selectTopBoard",boardIds);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.update("moimMapper.delectMoimBoard", boardId);
	}

	public ArrayList<Moim> searchMoim(SqlSessionTemplate sqlSession, HashMap paramap) {
		return (ArrayList)sqlSession.selectList("moimMapper.selectSearchMoimList", paramap);
	}

	public int getIsDeclared(SqlSessionTemplate sqlSession, Declare dcl) {
		return sqlSession.selectOne("moimMapper.getIsDeclared", dcl);
	}
	
	public int declareBoard(SqlSessionTemplate sqlSession, Declare dcl) {
		return sqlSession.insert("moimMapper.declareBoard", dcl);
	}

	public int isScrap(SqlSessionTemplate sqlSession, BoardScrap scrap) {
		return sqlSession.selectOne("moimMapper.isScrap", scrap);
	}

	public void setScrap(SqlSessionTemplate sqlSession, BoardScrap scrapvo) {
		sqlSession.insert("moimMapper.setScrap",scrapvo);
	}

	public void deleteScrap(SqlSessionTemplate sqlSession, BoardScrap scrapvo) {
		sqlSession.delete("moimMapper.deleteScrap",scrapvo);
	}

	public int deleteReply(SqlSessionTemplate sqlSession, int replyId) {
		return sqlSession.update("moimMapper.deleteReply", replyId);
	}
	
	///////////////////여기 replylikecount는 나의 좋아요 수(1 or 0) 카운트
	public ArrayList<Integer> getisReplyLikeList(SqlSessionTemplate sqlSession, 
			ArrayList<Reply> replyList,	String loginId) {
		ArrayList<Integer> isReplyLikeCountList = new ArrayList<Integer>();
		for(int i=0; i<replyList.size(); i++) {
			ReplyLike rl = new ReplyLike(loginId, replyList.get(i).getReplyId());
			isReplyLikeCountList.add(sqlSession.selectOne("moimMapper.isReplyLike", rl));
		}
		return isReplyLikeCountList;
	}

	public int isReplyLike(SqlSessionTemplate sqlSession, ReplyLike rLikevo) {
		return sqlSession.selectOne("moimMapper.isReplyLike", rLikevo);
	}

	public int setReplyLike(SqlSessionTemplate sqlSession, ReplyLike rLikevo) {
		return sqlSession.insert("moimMapper.setReplyLike", rLikevo);
	}

	public int deleteRepyLike(SqlSessionTemplate sqlSession, ReplyLike rLikevo) {
		return sqlSession.delete("moimMapper.deleteReplyLike", rLikevo);
	}

	public int deleteAttm(SqlSessionTemplate sqlSession, ArrayList<String> delRename) {
		System.out.println("여기는 DAO deleteAttm");
		int result= sqlSession.delete("boardMapper.deleteAttm", delRename);
		System.out.println(result);
		return result;
	}

	public void updateAttmLevel(SqlSessionTemplate sqlSession, int boardId) {
		System.out.println("여기는 DAO updateAttmLevel");
		System.out.println(boardId);
		int result = sqlSession.update("boardMapper.updateAttmLevel", boardId);
		System.out.println("after"+result);
	}

	public int updateMoim(SqlSessionTemplate sqlSession, Moim moim) {
		int result1 = sqlSession.update("moimMapper.updateBoard",moim);
		int result2 = sqlSession.update("moimMapper.updateBoardMoim", moim);
		return result1 + result2 ;
	}

	public int insertNewAttmUpdate(SqlSessionTemplate sqlSession, Moim moim, ArrayList<Attachment> list) {
		int boardId = moim.getBoardId();
		for(Attachment a: list) {
			a.setBoardId(boardId);
		}
		return sqlSession.insert("moimMapper.insertNewAttmUpdate", list);
	}


	
	
	

}
