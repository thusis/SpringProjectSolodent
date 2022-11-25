package com.kh.solodent.board.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.kh.solodent.board.model.vo.Attachment;
import com.kh.solodent.board.model.vo.Board;
import com.kh.solodent.board.model.vo.Moim;
import com.kh.solodent.board.model.vo.PageInfo;

@Service
public interface MoimService {

	int getListCount();

	ArrayList<Moim> selectMoimList(PageInfo pi);
	ArrayList<Attachment> selectMoimAttm(ArrayList<Moim> list);

	int insertMoim(Moim moim, ArrayList<Attachment> list);

	Moim selectMoim(int boardId, boolean yn);

	ArrayList<Attachment> selectAttmList(Integer boardId);


}
