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
public class Board {
	private int boardId;
	private int boardCode;
	private String boardTitle;
	private String boardContent;
	private String userId;
	private Date createDate;
	private Date modifyDate;
	private String isNotice;
	private int boardCount;
	private String status;
}
