package com.kh.solodent.board.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.PageInfo;
import com.kh.solodent.board.model.vo.Reply;

@Service
public interface FreeService {
	String selectNoTice();

	

	int getListCount();

	ArrayList<Board> selectBoardList(PageInfo pi);

	int insertBoard(Board b);


	Board selectBoard(int bId, boolean yn);



	ArrayList<Board> selectNoticeList();



	ArrayList<Board> selectBoard5();



	ArrayList<Board> selectBoardM();



	int insertDboard(Reply r);



	Board selectBoardb(int bId);



	



	int UpdateBoard(Board b);


	ArrayList<Reply> selectReply(int bId);



	int insertReply(Reply r);



	










	



	


	

}
