package com.kh.solodent.manage.model.vo;

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
public class DeclareManager {
	private int declareCode;
	private String whoDeclare;
	private String whoIsDeclared;
	private int boardCode; //자유 1 , 중고 2 , 꿀팁 3, 모임 4
	private int declareTo;
	private String boardTitle;
	private String boardContent;
	private int declareType;
	private Date declareDate;
	private char declareStatus;


}
