package com.kh.solodent.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.BoardScrap;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.board.model.vo.ReplyLike;
import com.kh.solodent.board.model.vo.Tip;
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

	//여기서부터 팁 부분
	
	public int insertTip(SqlSessionTemplate sqlSession, String category) {
		return sqlSession.insert("boardMapper.insertTip", category);
	}

	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, int i) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", i, rowBounds);
	}

	public ArrayList<Tip> selectTipList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectTipList");
	}

	public int getListCount(SqlSessionTemplate sqlSession, int i) {
		return sqlSession.selectOne("boardMapper.getListCount", i);
	}

	public ArrayList<Board> searchTip(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return (ArrayList)sqlSession.selectList("boardMapper.searchTip", map);
	}

	public ArrayList<Board> selectSearchTipList(SqlSessionTemplate sqlSession, HashMap<String, Object> map,
			PageInfo pi) {
		if(pi != null) {
			int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
			RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
			return (ArrayList)sqlSession.selectList("boardMapper.selectSearchTipList", map, rowBounds);
		} else {
			return (ArrayList)sqlSession.selectList("boardMapper.selectSearchTipList", map);
		}
	}

	public Tip selectTip(SqlSessionTemplate sqlSession, int bId) {
		return sqlSession.selectOne("boardMapper.selectTip", bId);
	}

	public int updateTip(SqlSessionTemplate sqlSession, Tip tip) {
		return sqlSession.update("boardMapper.updateTip", tip);
	}

	public int deleteTip(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.delete("boardMapper.deleteTip", boardId);
	}

	public String selectNickName(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("boardMapper.selectNickName", userId);
	}

	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("boardMapper.insertReply", r);
	}

	public ArrayList<Reply> selectReply(SqlSessionTemplate sqlSession, int boardId) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectReply", boardId);
	}

	public Integer replyLikeCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("boardMapper.replyLikeCount", boardId);
	}

	public Integer isReplyLikeList(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("boardMapper.isReplyLikeList", map);
	}

	public void addReplyLike(SqlSessionTemplate sqlSession, ReplyLike r) {
		sqlSession.insert("boardMapper.addReplyLike", r);
	}

	public void deleteReplyLike(SqlSessionTemplate sqlSession, ReplyLike r) {
		sqlSession.delete("boardMapper.deleteReplyLike", r);
	}

	public Integer boardLikeCount(SqlSessionTemplate sqlSession, int boardId) {
		return sqlSession.selectOne("boardMapper.boardLikeCount", boardId);
	}

	public int isScrap(SqlSessionTemplate sqlSession, HashMap<String, Object> scrapMap) {
		return sqlSession.selectOne("boardMapper.isScrap", scrapMap);
	}

	public void boardScrap(SqlSessionTemplate sqlSession, BoardScrap bs) {
		sqlSession.insert("boardMapper.boardScrap", bs);
	}

	public void deleteScrap(SqlSessionTemplate sqlSession, BoardScrap bs) {
		sqlSession.delete("boardMapper.deleteScrap", bs);
	}

	public int deleteReply(SqlSessionTemplate sqlSession, int replyId) {
		return sqlSession.delete("boardMapper.deleteReply", replyId);
	}

	public int updateReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.update("boardMapper.updateReply", r);
	}


	

}
