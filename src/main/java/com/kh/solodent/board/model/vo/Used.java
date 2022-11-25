package com.kh.solodent.board.model.vo;

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
public class Used {
	private int boardId;
	private String productCate;
	private String local;
	private String status;
	private String price;
}
