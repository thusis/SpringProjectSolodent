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
	private String memberId;
	private int srNo;
	private String chatContent;
	private Date sendDate;

}
