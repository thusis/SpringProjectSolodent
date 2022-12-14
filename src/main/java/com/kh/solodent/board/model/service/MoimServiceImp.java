package com.kh.solodent.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.dao.MoimDAO;
import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.BoardScrap;
import com.kh.solodent.board.model.vo.Declare;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.Moim;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.board.model.vo.ReplyLike;

@Service("moimService")
public class MoimServiceImp implements MoimService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MoimDAO mDAO;
	
	@Override
	public int getListCount() {
		return mDAO.getListCount(sqlSession);
	}

	@Override
	public ArrayList<Moim> selectMoimList(PageInfo pi) {
		return mDAO.selectMoimList(sqlSession, pi);
	}

	@Override
	public ArrayList<Attachment> selectMoimAttm(ArrayList<Moim> list) {
		return mDAO.selectMoimAttm(sqlSession,list);
	}

	@Override
	public int insertMoim(Moim moim, ArrayList<Attachment> list) {
		System.out.println("이곳은 moimservice의 insertMoim" + moim+"/"+list);
		return mDAO.insertMoim(sqlSession, moim, list);
	}

	@Override
	public Moim selectMoim(int boardId, boolean yn) {
		int result = 0;
		if(yn) {
			result = mDAO.addCount(sqlSession, boardId);
		}
		Moim moim = mDAO.selectMoim(sqlSession,boardId);
		return moim;
	}

	@Override
	public ArrayList<Attachment> selectAttmList(Integer boardId) {
		return mDAO.selectAttmList(sqlSession, boardId);
	}

	@Override
	public ArrayList<Integer> getPageReplyCount(ArrayList<Moim> list) {
		return mDAO.getPageReplyCount(sqlSession, list);
	}

	@Override
	public ArrayList<Integer> getPageLikeCount(ArrayList<Moim> list) {
		return mDAO.getPageLikeCount(sqlSession, list);
	}

	@Override
	public ArrayList<Integer> getPageScrapCount(ArrayList<Moim> list) {
		return mDAO.getPageScrapCount(sqlSession, list);
	}

	@Override
	public ArrayList<Reply> getBoardReplyList(int boardId) {
		return mDAO.getBoardReplyList(sqlSession, boardId);
	}

	@Override
	public ArrayList<Integer> getBoardReplyLikeCount(ArrayList<Reply> replyList) {
		return mDAO.getBoardReplyLikeCount(sqlSession, replyList);
	}

	@Override
	public int getBoardScrapCount(int boardId) {
		return mDAO.getBoardScrapCount(sqlSession, boardId);
	}

	@Override
	public int getBoardLikeCount(int boardId) {
		return mDAO.getBoardLikeCount(sqlSession,  boardId);
	}

	@Override
	public int insertReply(Reply r) {
		return mDAO.insertReply(sqlSession, r);
	}

	@Override
	public int isLike(Like like) {
		return mDAO.isLike(sqlSession, like);
	}

	@Override
	public void setBoardLike(Like likevo) {
		mDAO.setBoardLike(sqlSession, likevo);
	}

	@Override
	public void deleteBoardLike(Like likevo) {
		mDAO.deleteBoardLike(sqlSession, likevo);
	}

	@Override
	public ArrayList<Moim> getTopBoard() {
		return mDAO.selectTopThree(sqlSession);
	}

	@Override
	public int deleteBoard(int boardId) {
		return mDAO.deleteBoard(sqlSession, boardId);
	}

	@Override
	public ArrayList<Moim> searchMoim(HashMap paramap) {
		return mDAO.searchMoim(sqlSession, paramap);
	}

	@Override
	public int getIsDeclared(Declare dcl) {
		return mDAO.getIsDeclared(sqlSession,dcl);
	}

	@Override
	public int declareBoard(Declare dcl) {
		return mDAO.declareBoard(sqlSession, dcl);
	}

	@Override
	public int isScrap(BoardScrap scrap) {
		return mDAO.isScrap(sqlSession, scrap);
	}

	@Override
	public void setScrap(BoardScrap scrapvo) {
		mDAO.setScrap(sqlSession, scrapvo);
	}

	@Override
	public void deleteScrap(BoardScrap scrapvo) {
		mDAO.deleteScrap(sqlSession, scrapvo);
	}

	@Override
	public int deleteReply(int replyId) {
		return mDAO.deleteReply(sqlSession, replyId);
	}

	@Override
	public ArrayList<Integer> getisReplyLikeList(ArrayList<Reply> replyList, String loginId) {
		return mDAO.getisReplyLikeList(sqlSession, replyList, loginId);
	}

	@Override
	public int isReplyLike(ReplyLike rLikevo) {
		return mDAO.isReplyLike(sqlSession, rLikevo);
	}

	@Override
	public int setReplyLike(ReplyLike rLikevo) {
		return mDAO.setReplyLike(sqlSession, rLikevo);
	}

	@Override
	public int deleteReplyLike(ReplyLike rLikevo) {
		return mDAO.deleteRepyLike(sqlSession,rLikevo);
	}

	@Override
	public int deleteAttm(ArrayList<String> delRename) {
		System.out.println("여기는 서비스임플 deleteAttm");
		return mDAO.deleteAttm(sqlSession, delRename);
	}

	@Override
	public void updateAttmLevel(int boardId) {
		System.out.println("여기는 서비스임플 updateAttmLevel");
		mDAO.updateAttmLevel(sqlSession, boardId);
	}

	@Override
	public int updateMoim(Moim moim) {
		return mDAO.updateMoim(sqlSession, moim);
	}

	@Override
	public int insertNewAttmUpdate(Moim moim, ArrayList<Attachment> list) {
		return mDAO.insertNewAttmUpdate(sqlSession, moim, list);
	}

	
	


}