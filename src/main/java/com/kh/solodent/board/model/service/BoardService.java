package com.kh.solodent.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.dao.BoardDAO;
import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.BoardScrap;
import com.kh.solodent.board.model.vo.Declare;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.board.model.vo.ReplyLike;
import com.kh.solodent.board.model.vo.Tip;
import com.kh.solodent.board.model.vo.Used;

import oracle.net.aso.b;

@Service("bService")
public class BoardService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private BoardDAO bDAO;
	
	public int insertBoard(Board b) {
		return bDAO.insertBoard(sqlSession, b);
	}

	public int insertAttm(ArrayList<Attachment> list) {
		return bDAO.insertAttm(sqlSession, list);
	}

	public int insertUsed(Used used) {
		return bDAO.insertUsed(sqlSession, used);
	}

	public ArrayList<Board> selectUsedList(int i) {
		return bDAO.selectUsedList(sqlSession, i);
	}

	public ArrayList<Used> selectUsedDetailList() {
		return bDAO.selectUsedDetailList(sqlSession);
	}

	public ArrayList<Attachment> selectAttmList(Integer bId) {
		return bDAO.selectAttmList(sqlSession, bId);
	}

	public Board selectBoard(Integer bId, boolean yn) {
		int result = 0;
		if(yn) {
			result = bDAO.addCount(sqlSession, bId);
		}
		
		return bDAO.selectBoard(sqlSession, bId);
	}

	public Used selectUsed(Integer bId) {
		return bDAO.selectUsed(sqlSession, bId);
	}

	public int isLike(Like like) {
		return bDAO.isLike(sqlSession, like);
	}

	public int addLike(Like like) {
		return bDAO.addLike(sqlSession, like);
	}

	public int deleteLike(Like like) {
		return bDAO.deleteLike(sqlSession, like);
	}

	public int selectLikeCount(int boardId) {
		return bDAO.selectLikeCount(sqlSession, boardId);
	}

	public int deleteBoard(int boardId) {
		return bDAO.deleteBoard(sqlSession, boardId);
	}

	public int deleteUsed(int boardId) {
		return bDAO.deleteUsed(sqlSession, boardId);
	}

	public ArrayList<Board> searchUsed(HashMap<String, String> map) {
		return bDAO.searchUsed(sqlSession, map);
	}

	public int deleteAttm(ArrayList<String> delRename) {
		return bDAO.deleteAttm(sqlSession, delRename);
	}

	public void updateIsThum(int boardId) {
		bDAO.updateIsThum(sqlSession, boardId);
	}

	public int updateBoard(Board b) {
		return bDAO.updateBoard(sqlSession, b);
	}

	public int updateUsed(Used used) {
		return bDAO.updateUsed(sqlSession, used);
	}

	//여기서부터 팁 부분
	
	public int insertTip(String category) {
		return bDAO.insertTip(sqlSession, category);
	}

	public ArrayList<Board> selectBoardList(PageInfo pi, int i) {
		return bDAO.selectBoardList(sqlSession, pi, i);
	}

	public ArrayList<Tip> selectTipList() {
		return bDAO.selectTipList(sqlSession);
	}

	public int getListCount(int i) {
		return bDAO.getListCount(sqlSession, i);
	}

	public ArrayList<Board> searchTip(HashMap<String, Object> map) {
		return bDAO.searchTip(sqlSession, map);
	}

	public ArrayList<Board> selectSearchTipList(HashMap<String, Object> map, PageInfo pi) {
		return bDAO.selectSearchTipList(sqlSession, map, pi);
	}

	public Tip selectTip(int bId) {
		return bDAO.selectTip(sqlSession, bId);
	}

	public int updateTip(Tip tip) {
		return bDAO.updateTip(sqlSession, tip);
	}

	public int deleteTip(int boardId) {
		return bDAO.deleteTip(sqlSession, boardId);
	}

	public String selectNickName(String userId) {
		return bDAO.selectNickName(sqlSession, userId);
	}

	public int insertReply(Reply r) {
		return bDAO.insertReply(sqlSession, r);
	}

	public ArrayList<Reply> selectReply(int boardId) {
		return bDAO.selectReply(sqlSession, boardId);
	}

	public Integer replyLikeCount(int boardId) {
		return bDAO.replyLikeCount(sqlSession, boardId);
	}

	public Integer isReplyLikeList(HashMap<String, Object> map) {
		return bDAO.isReplyLikeList(sqlSession, map);
	}

	public void addReplyLike(ReplyLike r) {
		bDAO.addReplyLike(sqlSession, r);
	}

	public void deleteReplyLike(ReplyLike r) {
		bDAO.deleteReplyLike(sqlSession, r);
	}

	public Integer boardLikeCount(int boardId) {
		return bDAO.boardLikeCount(sqlSession, boardId);
	}

	public int isScrap(HashMap<String, Object> scrapMap) {
		return bDAO.isScrap(sqlSession, scrapMap);
	}

	public void boardScrap(BoardScrap bs) {
		bDAO.boardScrap(sqlSession, bs);
	}

	public void deleteScrap(BoardScrap bs) {
		bDAO.deleteScrap(sqlSession, bs);
	}

	public int deleteReply(int replyId) {
		return bDAO.deleteReply(sqlSession, replyId);
	}

	public int updateReply(Reply r) {
		return bDAO.updateReply(sqlSession, r);
	}

	public int insertDeclare(Declare d) {
		return bDAO.insertDeclare(sqlSession, d);
	}

	public int deleteReplyFromBoard(int boardId) {
		return bDAO.deleteReplyFromBoard(sqlSession, boardId);
	}

	public Attachment mainPageUsedList(int boardId) {
		return bDAO.mainPageUsedList(sqlSession, boardId);
	}


	



	

}
