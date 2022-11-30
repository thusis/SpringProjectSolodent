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
public class Declare {
	/**
	DECLARE_CODE	NUMBER 신고번호(seq_did)
	DECLARE_DATE	DATE 신고날짜
	STATUS	CHAR(1 BYTE) 신고처리여부
	DECLARE_TYPE	NUMBER 신고사유
	DECLARE_TO	NUMBER 신고대상게시글번호
	USER_ID	VARCHAR2(30 BYTE) 신고한사람 아이디
	**/
	private int declareCode;
	private Date declareDate;
	private char status; 
	private int declareType;
	private int declareTo;
	private String userId;
}
