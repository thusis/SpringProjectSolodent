package com.kh.solodent.chatTest.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Chat {
	
	
	private int no;
	private Integer chatroomId;
	private String sendId;	
	private String receivedId;
	private String content;	
	private String sendName;
	private String myId; //현재 나의 아이디
	private String otherId; //상대방 접속자 아이디
	private int readCnt;
	private Date sendDate;
	private Date readDate;


}
