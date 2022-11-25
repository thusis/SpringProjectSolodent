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
public class Attachment {
	private int fileId;
	private Date uploadDate;
	private String rawname;
	private String rename;
	private String fileRoute;
	private int boardCode;
	private int boardId;
	private String isThum;
}
