package com.kh.solodent.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Moim {
	private int boardId;
	private String boardTitle;
	private String boardContent;
	private String userId;
	private Date createDate;
	private Date modifyDate;
	private char isNotice;
	private int boardCount;
	private String boardStatus;

	private String moimCategory;
	private Date moimStart;
	private Date moimEnd;
	private String local;
	private char moimStatus;
	
	private String moimWriter;

}
