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
public class Reply {
	private int replyId;
	private String replyContent;
	private Date createDate;
	private char status;
	private String userId;
	private String nickName;
	private int boardId;
}
