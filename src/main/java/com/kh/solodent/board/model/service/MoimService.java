package com.kh.solodent.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.BoardScrap;
import com.kh.solodent.board.model.vo.Declare;
import com.kh.solodent.board.model.vo.Like;
import com.kh.solodent.board.model.vo.Moim;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;
import com.kh.solodent.board.model.vo.ReplyLike;

@Service
public interface MoimService {

	int getListCount();

	ArrayList<Moim> selectMoimList(PageInfo pi);
	ArrayList<Attachment> selectMoimAttm(ArrayList<Moim> list);

	int insertMoim(Moim moim, ArrayList<Attachment> list);

	Moim selectMoim(int boardId, boolean yn);

	ArrayList<Attachment> selectAttmList(Integer boardId);

	ArrayList<Integer> getPageReplyCount(ArrayList<Moim> list);

	ArrayList<Integer> getPageLikeCount(ArrayList<Moim> list);

	ArrayList<Integer> getPageScrapCount(ArrayList<Moim> list);

	ArrayList<Reply> getBoardReplyList(int boardId);

	ArrayList<Integer> getBoardReplyLikeCount(ArrayList<Reply> replyList);

	int getBoardScrapCount(int boardId);

	int getBoardLikeCount(int boardId);

	int insertReply(Reply r);

	int isLike(Like like);

	void setBoardLike(Like likevo);

	void deleteBoardLike(Like likevo);

	ArrayList<Moim> getTopBoard();

	int deleteBoard(int boardId);

	ArrayList<Moim> searchMoim(HashMap paramap);

	int declareBoard(Declare dcl);

	int getIsDeclared(Declare dcl);

	int isScrap(BoardScrap scrap);

	void setScrap(BoardScrap scrapvo);

	void deleteScrap(BoardScrap scrapvo);


}
